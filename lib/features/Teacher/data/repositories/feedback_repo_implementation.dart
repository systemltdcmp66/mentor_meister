import 'package:dartz/dartz.dart';
import 'package:mentormeister/core/errors/exceptions.dart';
import 'package:mentormeister/core/errors/failure.dart';
import 'package:mentormeister/core/utils/typedefs.dart';
import 'package:mentormeister/features/Teacher/data/datasources/feedback_remote_data_soruce.dart';
import 'package:mentormeister/features/Teacher/domain/entities/user_feedback.dart';
import 'package:mentormeister/features/Teacher/domain/repositories/feedback_repository.dart';

class FeedbackRepositoryImplementation extends FeedbackRepository {
  const FeedbackRepositoryImplementation(this._remoteDataSrc);

  final FeedbackRemoteDataSrc _remoteDataSrc;
  @override
  ResultFuture<void> sendFeedback(UserFeedback userFeedback) async {
    try {
      await _remoteDataSrc.sendFeedback(userFeedback);
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
