import 'package:mentormeister/core/utils/typedefs.dart';
import 'package:mentormeister/features/payment/domain/entities/course_payment.dart';
import 'package:mentormeister/features/payment/domain/entities/hiring.dart';
import 'package:mentormeister/features/payment/domain/entities/subscription.dart';

abstract class CoursePaymentRepository {
  CoursePaymentRepository();

  ResultFuture<void> paypalPayment(CoursePayment coursePayment);

  ResultFuture<void> makeSubscription(Subscription subscription);

  ResultFuture<void> hiringPayment(Hiring hiring);
}
