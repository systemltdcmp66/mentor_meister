import 'package:mentormeister/core/utils/typedefs.dart';
import 'package:mentormeister/features/Message/domain/entities/message_list.dart';

abstract class MessageRepository {
  const MessageRepository();

  ResultFuture<void> sendMessage({
    required MessageList messageList,
    required String documentId,
  });
}
