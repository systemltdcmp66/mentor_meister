import 'package:mentormeister/core/usecases/usecases.dart';
import 'package:mentormeister/core/utils/typedefs.dart';
import 'package:mentormeister/features/Teacher/domain/entities/user_feedback.dart';
import 'package:mentormeister/features/Teacher/domain/repositories/feedback_repository.dart';

class SendFeedback extends UseCaseWithParams<void, UserFeedback> {
  const SendFeedback(this._repository);

  final FeedbackRepository _repository;

  @override
  ResultFuture<void> call(UserFeedback params) =>
      _repository.sendFeedback(params);
}
