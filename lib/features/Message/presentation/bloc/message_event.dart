import 'package:equatable/equatable.dart';
import 'package:mentormeister/features/Message/domain/entities/message_list.dart';

abstract class MessageEvent extends Equatable {
  const MessageEvent();
  @override
  List<Object?> get props => [];
}

class SendMessageEvent extends MessageEvent {
  const SendMessageEvent({
    required this.messageList,
    required this.documentId,
  });

  final MessageList messageList;
  final String documentId;

  @override
  List<Object> get props => [
        messageList,
        documentId,
      ];
}
