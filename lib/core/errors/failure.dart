import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure({
    required this.message,
    this.statusCode,
  }) : assert(
          statusCode is int || statusCode is String,
          'StatusCode cannot be ${statusCode.runtimeType}',
        );

  final String message;
  final dynamic statusCode;

  String get errorMessage => 'Error : $message, statusCode: $statusCode';

  @override
  List<dynamic> get props => [message, statusCode];
}

class ServerFailure extends Failure {
  ServerFailure({
    required super.message,
    required super.statusCode,
  });
}

class CacheFailure extends Failure {
  CacheFailure({
    required super.message,
    super.statusCode = 500,
  });
}
