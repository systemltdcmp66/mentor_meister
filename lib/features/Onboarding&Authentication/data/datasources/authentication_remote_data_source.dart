import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mentormeister/core/enums/update_user.dart';
import 'package:mentormeister/core/errors/exceptions.dart';
import 'package:mentormeister/core/utils/constants.dart';
import 'package:mentormeister/core/utils/typedefs.dart';
import 'package:mentormeister/features/Onboarding&Authentication/data/models/user_model.dart';

abstract class AuthenticationRemoteDataSource {
  const AuthenticationRemoteDataSource();

  Future<LocalUserModel> signIn({
    required String email,
    required String password,
  });

  Future<void> signUp({
    required String name,
    required String email,
    required String phoneNumber,
    required String password,
  });

  Future<void> forgotPassword(String email);

  Future<void> updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  });

  Future<List<LocalUserModel>> getAllUsers();
}

class AuthenticationRemoteDataSourceImplementation
    implements AuthenticationRemoteDataSource {
  const AuthenticationRemoteDataSourceImplementation({
    required FirebaseAuth authClient,
    required FirebaseFirestore cloudStoreClient,
    required FirebaseStorage dbClient,
  })  : _authClient = authClient,
        _cloudStoreClient = cloudStoreClient,
        _dbClient = dbClient;

  final FirebaseAuth _authClient;
  final FirebaseFirestore _cloudStoreClient;
  final FirebaseStorage _dbClient;

  @override
  Future<void> forgotPassword(String email) async {
    try {
      await _authClient.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        message: e.toString(),
        statusCode: e.code,
      );
    } catch (e) {
      throw ServerException(
        message: e.toString(),
        statusCode: 'error-coming-from-us',
      );
    }
  }

  @override
  Future<LocalUserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _authClient.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result.user == null) {
        throw const ServerException(
          message: 'User may have been deleted',
          statusCode: 'user-not-found',
        );
      }

      var userData = await _getUserData(result.user!.uid);
      if (userData.exists) {
        return LocalUserModel.fromMap(userData.data()!);
      }
      await _setUserData(result.user!, email, 'null');
      userData = await _getUserData(result.user!.uid);
      return LocalUserModel.fromMap(userData.data()!);
    } on ServerException {
      rethrow;
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        message: e.toString(),
        statusCode: e.code,
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: 'error-coming-from-us',
      );
    }
  }

  @override
  Future<void> signUp({
    required String name,
    required String phoneNumber,
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _authClient.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user!.updatePhotoURL(kDefaultAvatar);
      await userCredential.user!.updateDisplayName(name);
      await _setUserData(
        _authClient.currentUser!,
        email,
        phoneNumber,
      );
    } on ServerException {
      rethrow;
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        message: e.toString(),
        statusCode: e.code,
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: 'error-coming-from-us',
      );
    }
  }

  @override
  Future<void> updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  }) async {
    try {
      switch (action) {
        case UpdateUserAction.displayName:
          await _authClient.currentUser!.updateDisplayName(userData as String);
          await _updateUserData({'fullName': userData});

        case UpdateUserAction.email:
          await _authClient.currentUser!.verifyBeforeUpdateEmail(
            userData as String,
          );
          await _updateUserData({'email': userData});

        case UpdateUserAction.profilePic:
          final ref = _dbClient
              .ref()
              .child('profile_pics/${_authClient.currentUser!.uid}');

          await ref.putFile(userData as File);
          final downloadUrl = await ref.getDownloadURL();
          await _authClient.currentUser!.updatePhotoURL(downloadUrl);
          await _updateUserData({'profilePic': downloadUrl});

        case UpdateUserAction.bio:
          await _updateUserData({'bio': userData});

        case UpdateUserAction.password:
          if (_authClient.currentUser!.email == null) {
            throw const ServerException(
              message: 'there is no user found',
              statusCode: 'null-email',
            );
          }
          final newData = jsonDecode(userData as String) as DataMap;
          await _authClient.currentUser!.reauthenticateWithCredential(
            EmailAuthProvider.credential(
              email: _authClient.currentUser!.email!,
              password: newData['oldPassword'] as String,
            ),
          );
          await _updateUserData({'password': newData['newPassword']});
        // await _authClient.currentUser!.updatePassword(
        //   newData['newPassword'] as String,
        // );
      }
    } on ServerException {
      rethrow;
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.toString(),
        statusCode: e.code,
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: 'error-is-from-us',
      );
    }
  }

  Future<void> _setUserData(
    User user,
    String fallbackEmail,
    String fallBackPhoneNumber, {
    bool? isFirstTime = true,
  }) async {
    await _cloudStoreClient.collection('users').doc(user.uid).set(
          LocalUserModel(
            uid: user.uid,
            name: user.displayName ?? '',
            phoneNumber: user.phoneNumber ?? fallBackPhoneNumber,
            email: user.email ?? fallbackEmail,
            isFirstTime: isFirstTime,
          ).toMap(),
        );
  }

  Future<DocumentSnapshot<DataMap>> _getUserData(String uid) async {
    return _cloudStoreClient.collection('users').doc(uid).get();
  }

  Future<void> _updateUserData(DataMap data) async {
    await _cloudStoreClient
        .collection('users')
        .doc(_authClient.currentUser!.uid)
        .update(data);
  }

  @override
  Future<List<LocalUserModel>> getAllUsers() async {
    try {
      return await _cloudStoreClient
          .collection('users')
          .where(
            'uid',
            isNotEqualTo: _authClient.currentUser!.uid,
          )
          .get()
          .then(
            (value) => value.docs
                .map(
                  (e) => LocalUserModel.fromMap(
                    e.data(),
                  ),
                )
                .toList(),
          );
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.toString(),
        statusCode: e.code,
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: 'error-is-from-us',
      );
    }
  }
}
