import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mentormeister/core/utils/typedefs.dart';
import 'package:mentormeister/features/Teacher/domain/entities/user_feedback.dart';

class FeedbackModel extends UserFeedback {
  const FeedbackModel({
    required super.userId,
    required super.numberOfStars,
    required super.text,
    required super.sendAt,
  });

  FeedbackModel.empty()
      : this(
          userId: '',
          numberOfStars: 1,
          text: '',
          sendAt: DateTime.now(),
        );

  FeedbackModel copyWith({
    String? userId,
    int? numberOfStars,
    String? text,
    DateTime? sendAt,
  }) =>
      FeedbackModel(
        userId: userId ?? this.userId,
        numberOfStars: numberOfStars ?? this.numberOfStars,
        text: text ?? this.text,
        sendAt: sendAt ?? this.sendAt,
      );

  FeedbackModel.fromMap(DataMap map)
      : super(
          userId: map['userId'] as String,
          numberOfStars: (map['numberOfStars'] as num).toInt(),
          text: map['text'] as String,
          sendAt: (map['sendAt'] as Timestamp).toDate(),
        );

  DataMap toMap() => {
        'userId': userId,
        'numberOfStars': numberOfStars,
        'text': text,
        'sendAt': FieldValue.serverTimestamp(),
      };
}
