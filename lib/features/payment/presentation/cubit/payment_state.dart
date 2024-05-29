import 'package:equatable/equatable.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object?> get props => [];
}

class PaymentInitial extends PaymentState {
  const PaymentInitial();
}

class PaymentPending extends PaymentState {
  const PaymentPending();
}

class PaymentDone extends PaymentState {
  const PaymentDone();
}

class PaymentError extends PaymentState {
  const PaymentError(this.message);

  final String message;

  @override
  List<String> get props => [message];
}
