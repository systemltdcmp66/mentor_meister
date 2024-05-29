import 'package:dartz/dartz.dart';
import 'package:mentormeister/core/errors/exceptions.dart';
import 'package:mentormeister/core/errors/failure.dart';
import 'package:mentormeister/core/utils/typedefs.dart';
import 'package:mentormeister/features/Message/data/datasources/message_remote_data_source.dart';
import 'package:mentormeister/features/Message/domain/entities/message_list.dart';
import 'package:mentormeister/features/Message/domain/repositories/message_repository.dart';

class MessageRepositoryImplementation extends MessageRepository {
  const MessageRepositoryImplementation(this._remoteDataSrc);

  final MessageRemoteDataSrc _remoteDataSrc;
  @override
  ResultFuture<void> sendMessage({
    required MessageList messageList,
    required String documentId,
  }) async {
    try {
      await _remoteDataSrc.sendMessage(
        messageList: messageList,
        documentId: documentId,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.message,
          statusCode: e.statusCode,
        ),
      );
    }
  }
}
