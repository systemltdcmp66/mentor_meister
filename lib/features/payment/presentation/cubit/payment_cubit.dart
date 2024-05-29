import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentormeister/features/payment/domain/entities/course_payment.dart';
import 'package:mentormeister/features/payment/domain/entities/hiring.dart';
import 'package:mentormeister/features/payment/domain/entities/subscription.dart';
import 'package:mentormeister/features/payment/domain/usecases/hiring_payment.dart';
import 'package:mentormeister/features/payment/domain/usecases/make_subscription.dart';
import 'package:mentormeister/features/payment/domain/usecases/paypal_payment.dart';
import 'package:mentormeister/features/payment/presentation/cubit/payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit({
    required PaypalPayment paypalPayment,
    required MakeSubscription makeSubscription,
    required HiringPayment hiringPayment,
  })  : _paypalPayment = paypalPayment,
        _makeSubscription = makeSubscription,
        _hiringPayment = hiringPayment,
        super(
          const PaymentInitial(),
        );

  final PaypalPayment _paypalPayment;
  final MakeSubscription _makeSubscription;
  final HiringPayment _hiringPayment;

  Future<void> paypalPayment({
    required CoursePayment coursePayment,
  }) async {
    emit(const PaymentPending());

    final result = await _paypalPayment(
      coursePayment,
    );

    result.fold(
      (failure) => emit(
        PaymentError(
          failure.errorMessage,
        ),
      ),
      (_) => emit(
        const PaymentDone(),
      ),
    );
  }

  Future<void> makeSubscription({
    required Subscription subscription,
  }) async {
    emit(
      const PaymentPending(),
    );

    final result = await _makeSubscription(
      subscription,
    );

    result.fold(
      (failure) => emit(
        PaymentError(
          failure.errorMessage,
        ),
      ),
      (_) => emit(
        const PaymentDone(),
      ),
    );
  }

  Future<void> hiringPayment({
    required Hiring hiring,
  }) async {
    emit(
      const PaymentPending(),
    );

    final result = await _hiringPayment(hiring);

    result.fold(
      (failure) => emit(
        PaymentError(
          failure.errorMessage,
        ),
      ),
      (_) => emit(
        const PaymentDone(),
      ),
    );
  }
}
