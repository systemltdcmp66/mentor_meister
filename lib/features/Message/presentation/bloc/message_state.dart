import 'package:equatable/equatable.dart';

abstract class MessageState extends Equatable {
  const MessageState();

  @override
  List<Object> get props => [];
}

class MessageInitial extends MessageState {
  const MessageInitial();
}

class SendingMessage extends MessageState {
  const SendingMessage();
}

class MessageSent extends MessageState {
  const MessageSent();
}

class MessageError extends MessageState {
  const MessageError(this.message);

  final String message;

  @override
  List<String> get props => [message];
}
