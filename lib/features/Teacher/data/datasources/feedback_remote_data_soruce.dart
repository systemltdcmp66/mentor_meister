import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:mentormeister/core/errors/exceptions.dart';
import 'package:mentormeister/features/Teacher/data/models/feedback_model.dart';
import 'package:mentormeister/features/Teacher/domain/entities/user_feedback.dart';

abstract class FeedbackRemoteDataSrc {
  const FeedbackRemoteDataSrc();

  Future<void> sendFeedback(UserFeedback userFeedback);
}

class FeedbackRemoteDataSrcImpl extends FeedbackRemoteDataSrc {
  const FeedbackRemoteDataSrcImpl({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
  })  : _auth = auth,
        _firestore = firestore;

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  @override
  Future<void> sendFeedback(UserFeedback userFeedback) async {
    try {
      final user = _auth.currentUser;

      if (user == null) {
        throw const ServerException(
          message: 'User is not authenticated',
          statusCode: '401',
        );
      }

      var feedbackModel =
          (userFeedback as FeedbackModel).copyWith(userId: user.uid);

      await _firestore.collection('feedbacks').doc(user.uid).set(
            feedbackModel.toMap(),
          );
    } on ServerException {
      rethrow;
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Unknown message',
        statusCode: e.code,
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: '505',
      );
    }
  }
}
