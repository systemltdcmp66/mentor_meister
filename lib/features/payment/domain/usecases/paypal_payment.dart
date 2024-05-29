import 'package:mentormeister/core/usecases/usecases.dart';
import 'package:mentormeister/core/utils/typedefs.dart';
import 'package:mentormeister/features/payment/domain/entities/course_payment.dart';
import 'package:mentormeister/features/payment/domain/repositories/course_payment_repo.dart';

class PaypalPayment extends UseCaseWithParams<void, CoursePayment> {
  const PaypalPayment(this._repository);
  final CoursePaymentRepository _repository;

  @override
  ResultFuture<void> call(CoursePayment params) =>
      _repository.paypalPayment(params);
}
