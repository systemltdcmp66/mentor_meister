import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mentormeister/core/errors/exceptions.dart';
import 'package:mentormeister/core/utils/basic_screen_imports.dart';
import 'package:mentormeister/features/Message/data/models/message_list_model.dart';
import 'package:mentormeister/features/Message/domain/entities/message_list.dart';

abstract class MessageRemoteDataSrc {
  const MessageRemoteDataSrc();

  Future<void> sendMessage({
    required MessageList messageList,
    required String documentId,
  });
}

class MessageRemoteDataSrcImpl extends MessageRemoteDataSrc {
  const MessageRemoteDataSrcImpl({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
    required FirebaseStorage storage,
  })  : _auth = auth,
        _firestore = firestore,
        _storage = storage;

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;
  @override
  Future<void> sendMessage({
    required MessageList messageList,
    required String documentId,
  }) async {
    try {
      final user = _auth.currentUser;

      if (user == null) {
        throw const ServerException(
          message: 'User is not authenticated',
          statusCode: '401',
        );
      }

      var message = (messageList as MessageListModel).copyWith(
        uid: _auth.currentUser!.uid,
      );

      final messageRef = _firestore
          .collection('messages')
          .doc(documentId)
          .collection('messageList')
          .doc();

      if (message.isContentAnImage) {
        final ref = _storage.ref().child('messages/images/${messageRef.id}');

        await ref.putFile(File(message.content)).then((value) async {
          final url = await value.ref.getDownloadURL();
          message = message.copyWith(
            content: url,
          );
        });
      }

      await messageRef.set(
        message.toMap(),
      );
      await _firestore.collection('messages').doc(documentId).update({
        'lastMessage': message.content,
        'messageSendAt': DateTime.now(),
        'id': documentId,
      });
    } on ServerException {
      rethrow;
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: e.code,
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: '505',
      );
    }
  }
}
