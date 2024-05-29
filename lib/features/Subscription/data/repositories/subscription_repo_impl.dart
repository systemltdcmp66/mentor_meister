import 'package:dartz/dartz.dart';
import 'package:mentormeister/core/errors/exceptions.dart';
import 'package:mentormeister/core/errors/failure.dart';
import 'package:mentormeister/core/utils/typedefs.dart';
import 'package:mentormeister/features/Subscription/data/datasources/subscription_remote_data_src.dart';
import 'package:mentormeister/features/Subscription/domain/repositories/subscription_repo.dart';
import 'package:mentormeister/features/payment/domain/entities/subscription.dart';

class SubscriptionRepoImpl implements SubscriptionRepository {
  const SubscriptionRepoImpl(this._remoteDataSrc);
  final SubscriptionRemoteDataSrc _remoteDataSrc;
  @override
  ResultFuture<List<Subscription>> getSubscriptionData() async {
    try {
      final subscriptions = await _remoteDataSrc.getSubscriptionData();
      return Right(subscriptions);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.message,
          statusCode: e.statusCode,
        ),
      );
    }
  }
}
