import 'package:equatable/equatable.dart';

class UserMessage extends Equatable {
  const UserMessage({
    required this.fromName,
    required this.toName,
    required this.messageSendAt,
    required this.lastMessage,
    this.fromAvatar,
    this.toAvatar,
    required this.fromUid,
    required this.toUid,
    required this.id,
  });
  final String fromUid;
  final String toUid;
  final String? id;
  final String fromName;
  final String toName;

  final DateTime messageSendAt;
  final String lastMessage;
  final String? fromAvatar;
  final String? toAvatar;

  @override
  List<Object?> get props => [
        fromName,
        toName,
        fromAvatar,
        id,
        toAvatar,
        fromUid,
        toUid,
        lastMessage,
        messageSendAt,
      ];
}
