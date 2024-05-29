import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mentormeister/core/utils/typedefs.dart';
import 'package:mentormeister/features/Message/domain/entities/message_list.dart';

class MessageListModel extends MessageList {
  const MessageListModel({
    required super.addTime,
    required super.content,
    required super.uid,
    required super.isContentAnImage,
  });

  MessageListModel.empty()
      : this(
          addTime: Timestamp.now(),
          content: '',
          isContentAnImage: false,
          uid: '',
        );

  MessageListModel copyWith({
    String? uid,
    dynamic content,
    bool? isContentAnImage,
    Timestamp? addTime,
  }) =>
      MessageListModel(
        addTime: addTime ?? this.addTime,
        content: content ?? this.content,
        uid: uid ?? this.uid,
        isContentAnImage: isContentAnImage ?? this.isContentAnImage,
      );

  MessageListModel.fromMap(DataMap map)
      : super(
          uid: map['uid'] as String,
          content: map['content'] as dynamic,
          isContentAnImage: map['isContentAnImage'],
          addTime: map['addTime'] as Timestamp,
        );

  DataMap toMap() => {
        'uid': uid,
        'addTime': addTime,
        'content': content,
        'isContentAnImage': isContentAnImage,
      };
}
