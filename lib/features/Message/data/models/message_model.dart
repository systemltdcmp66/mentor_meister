import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mentormeister/core/utils/typedefs.dart';
import 'package:mentormeister/features/Message/domain/entities/message.dart';

class UserMessageModel extends UserMessage {
  const UserMessageModel({
    required super.fromName,
    required super.toName,
    required super.messageSendAt,
    required super.lastMessage,
    super.fromAvatar,
    super.toAvatar,
    required super.fromUid,
    required super.toUid,
    super.id,
  });

  UserMessageModel.empty()
      : this(
          fromName: '',
          toName: '',
          messageSendAt: DateTime.now(),
          lastMessage: '',
          fromUid: '',
          toUid: '',
        );

  UserMessageModel copyWith({
    String? fromAvatar,
    String? toAvatar,
    String? fromName,
    String? toName,
    String? fromUid,
    String? toUid,
    String? id,
    String? fromMessage,
    String? toMessage,
    String? lastMessage,
    DateTime? messageSendAt,
  }) =>
      UserMessageModel(
        fromName: fromName ?? this.fromName,
        toName: toName ?? this.toName,
        id: id ?? this.id,
        messageSendAt: messageSendAt ?? this.messageSendAt,
        lastMessage: lastMessage ?? this.lastMessage,
        fromUid: fromUid ?? this.fromUid,
        toUid: toUid ?? this.toUid,
      );

  UserMessageModel.fromMap(DataMap map)
      : super(
          fromName: map['fromName'] as String,
          toName: map['toName'] as String,
          messageSendAt: (map['messageSendAt'] as Timestamp).toDate(),
          lastMessage: map['lastMessage'] as String,
          fromUid: map['fromUid'] as String,
          id: map['id'] as String?,
          toUid: map['toUid'] as String,
          fromAvatar: map['fromAvatar'] as String?,
          toAvatar: map['toAvatar'] as String?,
        );

  DataMap toMap() => {
        'fromAvatar': fromAvatar,
        'toAvatar': toAvatar,
        'fromName': fromName,
        'toName': toName,
        'fromUid': fromUid,
        'toUid': toUid,
        'id': id,
        'lastMessage': lastMessage,
        'messageSendAt': FieldValue.serverTimestamp(),
      };
}
