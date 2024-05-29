import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mentormeister/core/errors/exceptions.dart';
import 'package:mentormeister/core/utils/basic_screen_imports.dart';
import 'package:mentormeister/features/payment/data/models/subscription_model.dart';

abstract class SubscriptionRemoteDataSrc {
  const SubscriptionRemoteDataSrc();

  Future<List<SubscriptionModel>> getSubscriptionData();
}

class SubscriptionRemoteDataSrcImpl implements SubscriptionRemoteDataSrc {
  const SubscriptionRemoteDataSrcImpl({
    required FirebaseAuth authClient,
    required FirebaseFirestore cloudStoreClient,
  })  : _authClient = authClient,
        _cloudStoreClient = cloudStoreClient;

  final FirebaseAuth _authClient;
  final FirebaseFirestore _cloudStoreClient;
  @override
  Future<List<SubscriptionModel>> getSubscriptionData() async {
    try {
      final user = _authClient.currentUser;
      if (user == null) {
        throw const ServerException(
          message: 'User is not authenticated',
          statusCode: '401',
        );
      }

      return await _cloudStoreClient.collection('subscriptions').get().then(
            (value) => value.docs
                .map(
                  (e) => SubscriptionModel.fromMap(
                    e.data(),
                  ),
                )
                .toList(),
          );
    } on ServerException {
      rethrow;
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        message: e.toString(),
        statusCode: e.code,
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: 'error-coming-from-us',
      );
    }
  }
}
