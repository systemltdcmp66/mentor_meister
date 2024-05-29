import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mentormeister/core/errors/exceptions.dart';
import 'package:mentormeister/core/utils/basic_screen_imports.dart';
import 'package:mentormeister/features/Onboarding&Authentication/data/models/user_model.dart';
import 'package:mentormeister/features/Teacher/data/models/course_model.dart';
import 'package:mentormeister/features/payment/data/models/course_payment_model.dart';
import 'package:mentormeister/features/payment/data/models/hiring_model.dart';
import 'package:mentormeister/features/payment/data/models/subscription_model.dart';
import 'package:mentormeister/features/payment/domain/entities/course_payment.dart';
import 'package:mentormeister/features/payment/domain/entities/hiring.dart';

import 'package:mentormeister/features/payment/domain/entities/subscription.dart';

abstract class CoursePaymentRemoteDataSrc {
  const CoursePaymentRemoteDataSrc();

  Future<void> paypalPayment(CoursePayment coursePayment);
  Future<void> makeSubscription(Subscription subscription);
  Future<void> hiringPayment(Hiring hiring);
}

class CoursePaymentRemoteDataSrcImpl extends CoursePaymentRemoteDataSrc {
  const CoursePaymentRemoteDataSrcImpl({
    required FirebaseAuth authClient,
    required FirebaseFirestore cloudStoreClient,
  })  : _authClient = authClient,
        _cloudStoreClient = cloudStoreClient;

  final FirebaseAuth _authClient;
  final FirebaseFirestore _cloudStoreClient;

  @override
  Future<void> paypalPayment(CoursePayment coursePayment) async {
    try {
      final user = _authClient.currentUser;
      if (user == null) {
        throw const ServerException(
          message: 'User is not authenticated',
          statusCode: '401',
        );
      }

      // Enroll a course

      List<String> previousCourseIds = [];
      int previousNumberOfStudents = 0;
      await _cloudStoreClient
          .collection('users')
          .doc(_authClient.currentUser!.uid)
          .get()
          .then((value) {
        previousCourseIds =
            LocalUserModel.fromMap(value.data()!).enrolledCourseIds ?? [];
      });

      final courseId = coursePayment.courseId;

      await _cloudStoreClient
          .collection('courses')
          .doc(courseId)
          .get()
          .then((value) {
        previousNumberOfStudents =
            CourseModel.fromMap(value.data()!).numberOfAssignments == 0
                ? 1
                : CourseModel.fromMap(value.data()!).numberOfAssignments + 1;
      });

      previousCourseIds.add(courseId);

      await _cloudStoreClient
          .collection('users')
          .doc(_authClient.currentUser!.uid)
          .update({
        'enrolledCourseIds': previousCourseIds,
      });
      await _cloudStoreClient.collection('courses').doc(courseId).update({
        'numberOfStudents': previousNumberOfStudents,
      });

      // Save payment data

      await _cloudStoreClient
          .collection('course_payments')
          .doc(_authClient.currentUser!.uid)
          .set(
            (coursePayment as CoursePaymentModel)
                .copyWith(
                  paymentId: _authClient.currentUser!.uid,
                )
                .toMap(),
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
  Future<void> makeSubscription(Subscription subscription) async {
    try {
      final user = _authClient.currentUser;
      if (user == null) {
        throw const ServerException(
          message: 'User is not authenticated',
          statusCode: '401',
        );
      }

      List<SubscriptionModel> s = [];
      bool i = false;

      await _cloudStoreClient.collection('subscriptions').get().then((value) {
        value.docs.map((e) async {
          if (value.docs.isEmpty) {
            s = [];
            i = false;
          } else {
            s = value.docs
                .map((e) => SubscriptionModel.fromMap(e.data()))
                .toList();
          }
        });

        for (SubscriptionModel sub in s) {
          if (sub.teacherId == subscription.teacherId) {
            i = true;
          }
        }
      });

      if (i) {
        await _cloudStoreClient
            .collection('subscriptions')
            .doc(subscription.paymentId)
            .update(
              (subscription as SubscriptionModel)
                  .copyWith(
                    paymentId: subscription.paymentId,
                  )
                  .toMap(),
            );
      } else {
        await _cloudStoreClient
            .collection('subscriptions')
            .doc(_authClient.currentUser!.uid)
            .set(
              (subscription as SubscriptionModel)
                  .copyWith(
                    paymentId: _authClient.currentUser!.uid,
                  )
                  .toMap(),
            );
      }
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
  Future<void> hiringPayment(Hiring hiring) async {
    try {
      final user = _authClient.currentUser;
      if (user == null) {
        throw const ServerException(
          message: 'User is not authenticated',
          statusCode: '401',
        );
      }

      List<HiringModel> s = [];
      bool i = false;

      await _cloudStoreClient.collection('hiring_payments').get().then((value) {
        value.docs.map((e) async {
          if (value.docs.isEmpty) {
            s = [];
            i = false;
          } else {
            s = value.docs.map((e) => HiringModel.fromMap(e.data())).toList();
          }
        });

        for (HiringModel hir in s) {
          if (hir.teacherId == hir.teacherId) {
            i = true;
          }
        }
      });

      if (i) {
        await _cloudStoreClient
            .collection('hiring_payments')
            .doc('${_authClient.currentUser!.uid}_${hiring.teacherId}')
            .update(
              (hiring as HiringModel).toMap(),
            );
      } else {
        await _cloudStoreClient
            .collection('hiring_payments')
            .doc('${_authClient.currentUser!.uid}_${hiring.teacherId}')
            .set(
              (hiring as HiringModel).toMap(),
            );
      }

      // await _cloudStoreClient.collection('hiring_payments').add(
      //       (hiring as HiringModel).toMap(),
      //     );
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
}
