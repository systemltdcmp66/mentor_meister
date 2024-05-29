import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentormeister/features/Message/domain/usecases/send_message.dart';
import 'package:mentormeister/features/Message/presentation/bloc/message_event.dart';
import 'package:mentormeister/features/Message/presentation/bloc/message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageBloc({
    required SendMessage sendMessage,
  })  : _sendMessage = sendMessage,
        super(
          const MessageInitial(),
        ) {
    on<SendMessageEvent>(_sendMessageHandler);
  }

  final SendMessage _sendMessage;

  Future<void> _sendMessageHandler(
    SendMessageEvent event,
    Emitter<MessageState> emit,
  ) async {
    emit(
      const SendingMessage(),
    );

    final result = await _sendMessage(
      MessageUseCases(
        messageList: event.messageList,
        documentId: event.documentId,
      ),
    );

    result.fold(
      (failure) => emit(
        MessageError(
          failure.errorMessage,
        ),
      ),
      (_) => emit(
        const MessageSent(),
      ),
    );
  }
}
