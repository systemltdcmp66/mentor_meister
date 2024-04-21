import 'package:mentormeister/core/utils/typedefs.dart';
import 'package:mentormeister/features/Group/domain/entities/group.dart';

class GroupModel extends Group {
  const GroupModel({
    required super.id,
    required super.title,
    required super.courseId,
    required super.members,
    super.lastMessageSenderName,
    super.lastMessageSent,
    super.lastMessageTimestamp,
    super.groupImageUrl,
  });

  GroupModel copyWith({
    String? id,
    String? title,
    String? courseId,
    List<String>? members,
    String? lastMessageSenderName,
    String? lastMessageSent,
    DateTime? lastMessageTimestamp,
    String? groupImageUrl,
  }) =>
      GroupModel(
        id: id ?? this.id,
        title: title ?? this.title,
        courseId: courseId ?? this.courseId,
        members: members ?? this.members,
        lastMessageSenderName:
            lastMessageSenderName ?? this.lastMessageSenderName,
        lastMessageSent: lastMessageSent ?? this.lastMessageSent,
        lastMessageTimestamp: lastMessageTimestamp ?? this.lastMessageTimestamp,
        groupImageUrl: groupImageUrl ?? this.groupImageUrl,
      );

  DataMap toMap() => {
        'id': id,
        'title': title,
        'courseId': courseId,
        'members': members,
        'groupImageUrl': groupImageUrl,
        'lastMessageSenderName': lastMessageSenderName,
        'lastMessageSent': lastMessageSent,
        'lastMessageTimestamp': lastMessageSenderName,
      };
}
