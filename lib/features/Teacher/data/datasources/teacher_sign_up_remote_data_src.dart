import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mentormeister/core/errors/exceptions.dart';
import 'package:mentormeister/features/Teacher/data/models/teacher_info_model.dart';
import 'package:mentormeister/features/Teacher/domain/entities/teacher_info.dart';

abstract class TeacherSignUpRemoteDataSrc {
  TeacherSignUpRemoteDataSrc();

  Future<void> postTeacherInformations(TeacherInfo teacherInfo);

  Future<TeacherInfoModel> getTeacherInformations(String params);
}

class TeacherSignUpRemoteDataSrcImpl implements TeacherSignUpRemoteDataSrc {
  const TeacherSignUpRemoteDataSrcImpl({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
    required FirebaseStorage storage,
  })  : _auth = auth,
        _firestore = firestore,
        _storage = storage;

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;
  @override
  Future<TeacherInfoModel> getTeacherInformations(String id) async {
    try {
      final user = _auth.currentUser;

      if (user == null) {
        throw const ServerException(
          message: 'User is not authenticated',
          statusCode: '401',
        );
      }
      return _firestore
          .collection('teachers')
          .doc(id)
          .get()
          .then((value) => TeacherInfoModel.fromMap(value.data()!));
    } on ServerException {
      rethrow;
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: e.code,
      );
    } catch (e) {
      throw ServerException(
        message: e.toString(),
        statusCode: '505',
      );
    }
  }

  @override
  Future<void> postTeacherInformations(TeacherInfo teacherInfo) async {
    try {
      final user = _auth.currentUser;

      if (user == null) {
        throw const ServerException(
          message: 'User is not authenticated',
          statusCode: '401',
        );
      }

      final teacherRef = _firestore.collection('teachers').doc();

      var teacherInfoModel = (teacherInfo as TeacherInfoModel).copyWith(
        id: teacherRef.id,
        userId: _auth.currentUser!.uid,
      );

      if (teacherInfoModel.isProfilePicFile!) {
        final imageRef = _storage.ref().child(
              'teachers/${teacherInfoModel.id}/profile-pic/${teacherInfoModel.firstName}',
            );
        await imageRef.putFile(File(teacherInfoModel.profilePic!)).then(
          (value) async {
            final url = await value.ref.getDownloadURL();
            teacherInfoModel = teacherInfoModel.copyWith(profilePic: url);
          },
        );
      }
      await _firestore.collection('users').doc(_auth.currentUser!.uid).update(
        {
          'teacherId': teacherRef.id,
        },
      );
      await teacherRef.set(teacherInfoModel.toMap());
    } on ServerException {
      rethrow;
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: e.code,
      );
    } catch (e) {
      throw ServerException(
        message: e.toString(),
        statusCode: '505',
      );
    }
  }
}
