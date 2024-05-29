import 'package:dartz/dartz.dart';
import 'package:mentormeister/core/errors/exceptions.dart';
import 'package:mentormeister/core/errors/failure.dart';
import 'package:mentormeister/core/utils/typedefs.dart';
import 'package:mentormeister/features/payment/data/datasources/course_payment_remote_data_src.dart';
import 'package:mentormeister/features/payment/domain/entities/course_payment.dart';
import 'package:mentormeister/features/payment/domain/entities/hiring.dart';
import 'package:mentormeister/features/payment/domain/entities/subscription.dart';
import 'package:mentormeister/features/payment/domain/repositories/course_payment_repo.dart';

class CoursePaymentRepoImpl extends CoursePaymentRepository {
  CoursePaymentRepoImpl(this._remoteDataSrc);
  final CoursePaymentRemoteDataSrc _remoteDataSrc;
  @override
  ResultFuture<void> paypalPayment(CoursePayment coursePayment) async {
    try {
      await _remoteDataSrc.paypalPayment(coursePayment);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.message,
          statusCode: e.statusCode,
        ),
      );
    }
  }

  @override
  ResultFuture<void> makeSubscription(Subscription subscription) async {
    try {
      await _remoteDataSrc.makeSubscription(subscription);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.message,
          statusCode: e.statusCode,
        ),
      );
    }
  }

  @override
  ResultFuture<void> hiringPayment(Hiring hiring) async {
    try {
      await _remoteDataSrc.hiringPayment(hiring);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.message,
          statusCode: e.statusCode,
        ),
      );
    }
  }
}
