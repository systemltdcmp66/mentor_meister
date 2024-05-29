import 'package:mentormeister/core/usecases/usecases.dart';
import 'package:mentormeister/core/utils/typedefs.dart';
import 'package:mentormeister/features/payment/domain/entities/hiring.dart';
import 'package:mentormeister/features/payment/domain/repositories/course_payment_repo.dart';

class HiringPayment extends UseCaseWithParams<void, Hiring> {
  const HiringPayment(this._repository);
  final CoursePaymentRepository _repository;

  @override
  ResultFuture<void> call(Hiring params) => _repository.hiringPayment(params);
}
