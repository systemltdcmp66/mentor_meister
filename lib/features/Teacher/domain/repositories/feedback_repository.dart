import 'package:mentormeister/core/utils/typedefs.dart';
import 'package:mentormeister/features/Teacher/domain/entities/user_feedback.dart';

abstract class FeedbackRepository {
  const FeedbackRepository();

  ResultFuture<void> sendFeedback(UserFeedback userFeedback);
}
