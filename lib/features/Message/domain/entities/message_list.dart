import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MessageList extends Equatable {
  const MessageList({
    required this.addTime,
    required this.content,
    required this.uid,
    required this.isContentAnImage,
  });
  final Timestamp addTime;
  final dynamic content;
  final String uid;
  final bool isContentAnImage;

  @override
  List<Object?> get props => [
        addTime,
        content,
        uid,
        isContentAnImage,
      ];
}
