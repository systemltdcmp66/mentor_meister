import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:mentormeister/core/services/injection_container.dart';
import 'package:mentormeister/features/Message/data/models/message_model.dart';

class ChatProvider extends ChangeNotifier {
  ChatProvider();

  final List<UserMessageModel> _messageList = [];

  List<UserMessageModel> get mesagelist => _messageList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loadAllMessages() async {
    _isLoading = true;
    Future.delayed(
      Duration.zero,
      notifyListeners,
    );
    var fromMessages = await sl<FirebaseFirestore>()
        .collection('messages')
        .where(
          'fromUid',
          isEqualTo: sl<FirebaseAuth>().currentUser!.uid,
        )
        .get();

    var toMessages = await sl<FirebaseFirestore>()
        .collection('messages')
        .where(
          'toUid',
          isEqualTo: sl<FirebaseAuth>().currentUser!.uid,
        )
        .get();
    mesagelist.clear();

    if (fromMessages.docs.isNotEmpty) {
      _messageList.addAll(
        fromMessages.docs
            .map((e) => UserMessageModel.fromMap(e.data()))
            .toList(),
      );
    }
    if (toMessages.docs.isNotEmpty) {
      _messageList.addAll(
        toMessages.docs.map((e) => UserMessageModel.fromMap(e.data())).toList(),
      );
    }
    _isLoading = false;
    notifyListeners();
  }
}
