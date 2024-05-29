import 'package:mentormeister/core/utils/typedefs.dart';
import 'package:mentormeister/features/payment/domain/entities/subscription.dart';

abstract class SubscriptionRepository {
  const SubscriptionRepository();

  ResultFuture<List<Subscription>> getSubscriptionData();
}
