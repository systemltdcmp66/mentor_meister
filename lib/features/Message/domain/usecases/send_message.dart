import 'package:equatable/equatable.dart';
import 'package:mentormeister/core/usecases/usecases.dart';
import 'package:mentormeister/core/utils/typedefs.dart';
import 'package:mentormeister/features/Message/domain/entities/message_list.dart';
import 'package:mentormeister/features/Message/domain/repositories/message_repository.dart';

class SendMessage extends UseCaseWithParams<void, MessageUseCases> {
  const SendMessage(this._repository);

  final MessageRepository _repository;

  @override
  ResultFuture<void> call(params) => _repository.sendMessage(
        messageList: params.messageList,
        documentId: params.documentId,
      );
}

class MessageUseCases extends Equatable {
  const MessageUseCases({
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
