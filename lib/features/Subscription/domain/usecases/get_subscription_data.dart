import 'package:mentormeister/core/usecases/usecases.dart';
import 'package:mentormeister/core/utils/typedefs.dart';
import 'package:mentormeister/features/Subscription/domain/repositories/subscription_repo.dart';
import 'package:mentormeister/features/payment/domain/entities/subscription.dart';

class GetSubscriptionData extends UseCaseWithoutParams<List<Subscription>> {
  GetSubscriptionData(this._repository);

  final SubscriptionRepository _repository;

  @override
  ResultFuture<List<Subscription>> call() => _repository.getSubscriptionData();
}
