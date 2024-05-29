import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mentormeister/core/errors/exceptions.dart';
import 'package:mentormeister/features/Group/data/models/group_model.dart';
import 'package:mentormeister/features/Onboarding&Authentication/data/models/user_model.dart';
import 'package:mentormeister/features/Teacher/data/models/course_model.dart';
import 'package:mentormeister/features/Teacher/domain/entities/course.dart';

abstract class CourseRemoteDataSrc {
  const CourseRemoteDataSrc();

  Future<void> createCourse(Course course);

  Future<List<CourseModel>> getCourses();

  Future<void> enrolCourse(String courseId);

  Future<List<CourseModel>> getEnrolledCourses();
}

class CourseRemoteDataSrcImpl implements CourseRemoteDataSrc {
  const CourseRemoteDataSrcImpl({
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
  Future<void> createCourse(Course course) async {
    try {
      final user = _auth.currentUser;

      if (user == null) {
        throw const ServerException(
          message: 'User is not authenticated',
          statusCode: '401',
        );
      }

      final courseRef = _firestore.collection('courses').doc();
      final groupRef = _firestore.collection('groups').doc();

      var courseModel = (course as CourseModel).copyWith(
        id: courseRef.id,
        groupId: groupRef.id,
        userId: user.uid,
      );

      if (courseModel.isImageFile) {
        final imageRef = _storage.ref().child(
              'teachers/${courseModel.id}/profile-pic/${courseModel.title}',
            );
        await imageRef.putFile(File(courseModel.image!)).then(
          (value) async {
            final url = await value.ref.getDownloadURL();
            courseModel = courseModel.copyWith(
              image: url,
            );
          },
        );
      }
      await courseRef.set(
        courseModel.toMap(),
      );
      final groupModel = GroupModel(
        id: groupRef.id,
        title: courseModel.title,
        courseId: courseRef.id,
        members: const [],
      );
      await groupRef.set(
        groupModel.toMap(),
      );
    } on ServerException {
      rethrow;
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Unkown error occurred',
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
  Future<List<CourseModel>> getCourses() async {
    try {
      return await _firestore.collection('courses').get().then(
            (value) => value.docs
                .map(
                  (doc) => CourseModel.fromMap(
                    doc.data(),
                  ),
                )
                .toList(),
          );
    } on ServerException {
      rethrow;
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Unkown error occurred',
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
  Future<void> enrolCourse(String courseId) async {
    try {
      final user = _auth.currentUser;

      if (user == null) {
        throw const ServerException(
          message: 'User is not authenticated',
          statusCode: '401',
        );
      }

      List<String> previousCourseIds = [];
      int previousNumberOfStudents = 0;
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get()
          .then((value) {
        previousCourseIds =
            LocalUserModel.fromMap(value.data()!).enrolledCourseIds ?? [];
      });

      await _firestore.collection('courses').doc(courseId).get().then((value) {
        previousNumberOfStudents =
            CourseModel.fromMap(value.data()!).numberOfAssignments == 0
                ? 1
                : CourseModel.fromMap(value.data()!).numberOfAssignments + 1;
      });

      previousCourseIds.add(courseId);

      await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
        'enrolledCourseIds': previousCourseIds,
      });
      await _firestore.collection('courses').doc(courseId).update({
        'numberOfStudents': previousNumberOfStudents,
      });
    } on ServerException {
      rethrow;
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Unkown error occurred',
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
  Future<List<CourseModel>> getEnrolledCourses() async {
    try {
      final user = _auth.currentUser;

      if (user == null) {
        throw const ServerException(
          message: 'User is not authenticated',
          statusCode: '401',
        );
      }
      List<String> enrolledCourseIds = [];

      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get()
          .then(
        (value) {
          enrolledCourseIds =
              LocalUserModel.fromMap(value.data()!).enrolledCourseIds ?? [];
        },
      );

      if (enrolledCourseIds.isEmpty) {
        return [];
      }
      List<CourseModel> enrolledCourses = [];
      for (String courseId in enrolledCourseIds) {
        await _firestore
            .collection('courses')
            .doc(courseId)
            .get()
            .then((value) {
          enrolledCourses.add(CourseModel.fromMap(value.data()!));
        });
      }
      return enrolledCourses;
    } on ServerException {
      rethrow;
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Unkown error occurred',
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
