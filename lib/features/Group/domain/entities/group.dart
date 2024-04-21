import 'package:equatable/equatable.dart';

class Group extends Equatable {
  const Group({
    required this.id,
    required this.title,
    required this.courseId,
    this.groupImageUrl,
    this.lastMessageSenderName,
    this.lastMessageSent,
    this.lastMessageTimestamp,
    required this.members,
  });
  final String id;
  final String title;
  final String courseId;
  final List<String> members;
  final String? lastMessageSent;
  final DateTime? lastMessageTimestamp;
  final String? lastMessageSenderName;
  final String? groupImageUrl;

  @override
  List<Object?> get props => [
        id,
        title,
        courseId,
        members,
        groupImageUrl,
        lastMessageSenderName,
        lastMessageSent,
        lastMessageSent,
      ];
}
