import 'package:mentormeister/core/usecases/usecases.dart';
import 'package:mentormeister/core/utils/typedefs.dart';
import 'package:mentormeister/features/payment/domain/entities/subscription.dart';
import 'package:mentormeister/features/payment/domain/repositories/course_payment_repo.dart';

class MakeSubscription extends UseCaseWithParams<void, Subscription> {
  const MakeSubscription(this._repository);
  final CoursePaymentRepository _repository;

  @override
  ResultFuture<void> call(Subscription params) =>
      _repository.makeSubscription(params);
}
