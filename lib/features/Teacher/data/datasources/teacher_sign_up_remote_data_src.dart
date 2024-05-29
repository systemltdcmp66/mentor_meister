import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mentormeister/core/errors/exceptions.dart';
import 'package:mentormeister/core/utils/basic_screen_imports.dart';
import 'package:mentormeister/features/Onboarding&Authentication/data/models/user_model.dart';
import 'package:mentormeister/features/Teacher/data/models/course_model.dart';
import 'package:mentormeister/features/Teacher/data/models/teacher_info_model.dart';
import 'package:mentormeister/features/Teacher/domain/entities/teacher_info.dart';

abstract class TeacherSignUpRemoteDataSrc {
  TeacherSignUpRemoteDataSrc();

  Future<void> postTeacherInformations(TeacherInfo teacherInfo);

  Future<TeacherInfoModel> getTeacherInformations(String params);

  Future<List<TeacherInfoModel>> getAllTeacherInformations();

  Future<void> hireATeacher(String teacherId);

  Future<List<TeacherInfoModel>> getHiredTeacherInfos();

  Future<List<LocalUserModel>> getTeacherUsersData(String teacherId);

  Future<List<CourseModel>> getTeacherCourses();
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
          'alreadyVisitTutorSignUpPage': true,
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

  @override
  Future<List<TeacherInfoModel>> getAllTeacherInformations() async {
    try {
      final user = _auth.currentUser;

      if (user == null) {
        throw const ServerException(
          message: 'User is not authenticated',
          statusCode: '401',
        );
      }

      return await _firestore.collection('teachers').get().then(
            (value) => value.docs
                .map(
                  (doc) => TeacherInfoModel.fromMap(
                    doc.data(),
                  ),
                )
                .toList(),
          );
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
  Future<List<TeacherInfoModel>> getHiredTeacherInfos() async {
    try {
      final user = _auth.currentUser;

      if (user == null) {
        throw const ServerException(
          message: 'User is not authenticated',
          statusCode: '401',
        );
      }

      List<String> hiredTeacherIds = [];
      List<TeacherInfoModel> hiredTeacherInfos = [];

      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get()
          .then(
        (value) {
          hiredTeacherIds =
              LocalUserModel.fromMap(value.data()!).hiredTeacherIds ?? [];
        },
      );
      await _firestore.collection('teachers').get().then(
        (value) {
          for (String teacherId in hiredTeacherIds) {
            for (QueryDocumentSnapshot<Map<String, dynamic>> e in value.docs) {
              if (teacherId == TeacherInfoModel.fromMap(e.data()).id) {
                hiredTeacherInfos.add(
                  TeacherInfoModel.fromMap(
                    e.data(),
                  ),
                );
              }
            }
          }
        },
      );
      return hiredTeacherInfos;
    } on ServerException {
      rethrow;
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: e.code,
      );
    } catch (e, s) {
      debugPrintStack(
        stackTrace: s,
      );
      throw ServerException(
        message: e.toString(),
        statusCode: '505',
      );
    }
  }

  @override
  Future<void> hireATeacher(String teacherId) async {
    try {
      final user = _auth.currentUser;

      if (user == null) {
        throw const ServerException(
          message: 'User is not authenticated',
          statusCode: '401',
        );
      }

      List<String> hiredTeacherIds = [];

      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get()
          .then(
        (value) {
          hiredTeacherIds =
              LocalUserModel.fromMap(value.data()!).hiredTeacherIds ?? [];
        },
      );
      hiredTeacherIds.add(teacherId);
      await _firestore.collection('users').doc(_auth.currentUser!.uid).update(
        {
          'hiredTeacherIds': hiredTeacherIds,
        },
      );
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
  Future<List<LocalUserModel>> getTeacherUsersData(String teacherId) async {
    try {
      final user = _auth.currentUser;

      if (user == null) {
        throw const ServerException(
          message: 'User is not authenticated',
          statusCode: '401',
        );
      }

      List<LocalUserModel> allUsers = [];
      List<LocalUserModel> teacherUsersData = [];
      await _firestore.collection('users').get().then(
        (value) {
          allUsers = value.docs
              .map(
                (e) => LocalUserModel.fromMap(
                  e.data(),
                ),
              )
              .toList();
        },
      );

      for (int i = 0; i < allUsers.length; i++) {
        if (allUsers[i].hiredTeacherIds != null &&
            allUsers[i].hiredTeacherIds!.isNotEmpty) {
          for (int j = 0; j < allUsers[i].hiredTeacherIds!.length; j++) {
            if (teacherId == allUsers[i].hiredTeacherIds![j]) {
              teacherUsersData.add(allUsers[i]);
            }
          }
        }
      }
      return teacherUsersData;
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
  Future<List<CourseModel>> getTeacherCourses() async {
    try {
      final user = _auth.currentUser;

      if (user == null) {
        throw const ServerException(
          message: 'User is not authenticated',
          statusCode: '401',
        );
      }

      return await _firestore
          .collection('courses')
          .where('userId', isEqualTo: _auth.currentUser!.uid)
          .get()
          .then(
            (value) => value.docs
                .map(
                  (e) => CourseModel.fromMap(
                    e.data(),
                  ),
                )
                .toList(),
          );
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
