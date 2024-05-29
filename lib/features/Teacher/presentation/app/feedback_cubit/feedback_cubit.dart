import 'package:equatable/equatable.dart';

abstract class FeedbackState extends Equatable {
  const FeedbackState();
  @override
  List<Object?> get props => [];
}

class FeedbackInitial extends FeedbackState {
  const FeedbackInitial();
}

class SendingFeedback extends FeedbackState {
  const SendingFeedback();
}

class FeedbackSent extends FeedbackState {
  const FeedbackSent();
}

class FeedbackError extends FeedbackState {
  const FeedbackError(this.message);

  final String message;

  @override
  List<String> get props => [message];
}
