import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mentormeister/core/errors/exceptions.dart';
import 'package:mentormeister/features/Teacher/data/models/assignment_model.dart';
import 'package:mentormeister/features/Teacher/data/models/course_model.dart';
import 'package:mentormeister/features/Teacher/domain/entities/assignment.dart';

abstract class AssignmentRemoteDataSrc {
  const AssignmentRemoteDataSrc();

  Future<void> createAssignment(XAssignment assignment);

  Future<List<XAssignment>> getAssignments();
}

class AssignmentRemoteDataSrcImpl implements AssignmentRemoteDataSrc {
  const AssignmentRemoteDataSrcImpl({
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
  Future<void> createAssignment(XAssignment assignment) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw const ServerException(
          message: 'User is not authenticated',
          statusCode: '401',
        );
      }
      final assignmentRef = _firestore.collection('assignments').doc();
      var assignmentModel = (assignment as AssignmentModel).copyWith(
        id: assignmentRef.id,
      );
      int previousNumberOfAssignments = 0;
      if (assignmentModel.isAssignmentFile) {
        final fileRef = _storage.ref().child(
            'assignments/${assignmentModel.courseName}/${assignmentModel.assignmentNumber}');
        await fileRef.putFile(assignmentModel.assignmentFile!);
      }
      await assignmentRef.set(
        assignmentModel.toMap(),
      );
      await _firestore
          .collection('courses')
          .doc(assignmentModel.courseId)
          .get()
          .then((value) {
        previousNumberOfAssignments =
            CourseModel.fromMap(value.data()!).numberOfAssignments == 0
                ? 1
                : CourseModel.fromMap(value.data()!).numberOfAssignments + 1;
      });
      await _firestore
          .collection('courses')
          .doc(assignmentModel.courseId)
          .update({
        'numberOfAssignments': previousNumberOfAssignments,
      });
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
  Future<List<XAssignment>> getAssignments() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw const ServerException(
          message: 'User is not authenticated',
          statusCode: '401',
        );
      }
      return await _firestore.collection('assignments').get().then(
            (value) => value.docs
                .map(
                  (doc) => AssignmentModel.fromMap(
                    doc.data(),
                  ),
                )
                .toList(),
          );
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
