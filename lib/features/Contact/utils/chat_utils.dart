import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:mentormeister/core/services/injection_container.dart';

class ChatUtils {
  const ChatUtils._();

  static Stream<QuerySnapshot> getMessages(String documentId) {
    return sl<FirebaseFirestore>()
        .collection('messages')
        .doc(documentId)
        .collection('messageList')
        .orderBy(
          'addTime',
          descending: true,
        )
        .snapshots();
  }

  static String duTimeLineFormat(DateTime dt) {
    var now = DateTime.now();

    var difference = now.difference(dt);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} h ago';
    } else if (difference.inSeconds < 60) {
      return '${difference.inSeconds} s ago';
    } else if (difference.inDays < 30) {
      return '${difference.inDays} d ago';
    } else if (difference.inDays < 365) {
      final dtFormat = DateFormat('MM-dd');
      return dtFormat.format(dt);
    } else {
      final dtFormat = DateFormat('yyyy-MM-dd');
      return dtFormat.format(dt);
    }
  }

  static String toMyTime(DateTime dt) {
    final dtFormat = DateFormat('dd-MM-yyyy');
    return dtFormat.format(dt);
  }
}
