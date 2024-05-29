import 'package:equatable/equatable.dart';
import 'package:mentormeister/features/payment/domain/entities/subscription.dart';

abstract class SubscriptionState extends Equatable {
  const SubscriptionState();
  @override
  List<Object?> get props => [];
}

class SubscriptionInitial extends SubscriptionState {
  const SubscriptionInitial();
}

class GettingSubscriptionData extends SubscriptionState {
  const GettingSubscriptionData();
}

class SubscriptionDataFetched extends SubscriptionState {
  const SubscriptionDataFetched(
    this.subscriptions,
  );

  final List<Subscription> subscriptions;

  @override
  List<String> get props => subscriptions.map((e) => e.paymentId).toList();
}

class SubscriptionError extends SubscriptionState {
  const SubscriptionError(this.message);

  final String message;

  @override
  List<String> get props => [message];
}
