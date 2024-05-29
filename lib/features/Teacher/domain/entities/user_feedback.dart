import 'package:equatable/equatable.dart';

class UserFeedback extends Equatable {
  const UserFeedback({
    required this.userId,
    required this.numberOfStars,
    required this.text,
    required this.sendAt,
  });

  final String userId;
  final int numberOfStars;
  final String text;
  final DateTime sendAt;

  @override
  List<Object?> get props => [
        userId,
        numberOfStars,
        text,
        sendAt,
      ];
}
