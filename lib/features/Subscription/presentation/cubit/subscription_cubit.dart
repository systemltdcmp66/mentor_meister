import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentormeister/features/Subscription/domain/usecases/get_subscription_data.dart';
import 'package:mentormeister/features/Subscription/presentation/cubit/subscription_state.dart';

class SubscriptionCubit extends Cubit<SubscriptionState> {
  SubscriptionCubit({
    required GetSubscriptionData getSubscriptionData,
  })  : _getSubscriptionData = getSubscriptionData,
        super(
          const SubscriptionInitial(),
        );

  final GetSubscriptionData _getSubscriptionData;

  Future<void> getSubscriptionData() async {
    emit(
      const GettingSubscriptionData(),
    );

    final result = await _getSubscriptionData();
    result.fold(
      (failure) => emit(
        SubscriptionError(
          failure.errorMessage,
        ),
      ),
      (subscriptions) => emit(
        SubscriptionDataFetched(subscriptions),
      ),
    );
  }
}
