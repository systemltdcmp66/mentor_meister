import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentormeister/features/Teacher/domain/entities/user_feedback.dart';
import 'package:mentormeister/features/Teacher/domain/usescases/send_feedback.dart';
import 'package:mentormeister/features/Teacher/presentation/app/feedback_cubit/feedback_cubit.dart';

class FeedbackCubit extends Cubit<FeedbackState> {
  FeedbackCubit({
    required SendFeedback sendFeedback,
  })  : _sendFeedback = sendFeedback,
        super(
          const FeedbackInitial(),
        );

  final SendFeedback _sendFeedback;

  Future<void> sendFeedback(UserFeedback userFeedback) async {
    emit(
      const SendingFeedback(),
    );

    final result = await _sendFeedback(userFeedback);

    result.fold(
      (failure) => emit(
        FeedbackError(
          failure.errorMessage,
        ),
      ),
      (_) => emit(
        const FeedbackSent(),
      ),
    );
  }
}
