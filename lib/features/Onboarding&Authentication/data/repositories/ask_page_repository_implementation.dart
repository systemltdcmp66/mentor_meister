import 'package:dartz/dartz.dart';
import 'package:mentormeister/core/errors/exceptions.dart';
import 'package:mentormeister/core/errors/failure.dart';
import 'package:mentormeister/core/utils/typedefs.dart';
import 'package:mentormeister/features/Onboarding&Authentication/data/datasources/ask_page_locale_data_source.dart';
import 'package:mentormeister/features/Onboarding&Authentication/domain/repositories/ask_page_repository.dart';

class AskPageRepositoryImplementation implements AskPageRepository {
  const AskPageRepositoryImplementation(this._localeDataSource);
  final AskPageLocaleDataSource _localeDataSource;
  @override
  ResultFuture<void> isAStudent() async {
    try {
      await _localeDataSource.isAStudent();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(
        CacheFailure(
          message: e.message,
          statusCode: e.statusCode,
        ),
      );
    }
  }

  @override
  ResultFuture<bool> checkIfUserIsAStudent() async {
    try {
      final result = await _localeDataSource.checkIfUserIsAStudent();
      return Right(result);
    } on CacheException catch (e) {
      return Left(
        CacheFailure(
          message: e.message,
          statusCode: e.statusCode,
        ),
      );
    }
  }

  @override
  ResultFuture<bool> checkIfUserIsATeacher() async {
    try {
      final result = await _localeDataSource.checkIfUserIsATeacher();
      return Right(result);
    } on CacheException catch (e) {
      return Left(
        CacheFailure(
          message: e.message,
          statusCode: e.statusCode,
        ),
      );
    }
  }

  @override
  ResultFuture<void> isATeacher() async {
    try {
      await _localeDataSource.isATeacher();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(
        CacheFailure(
          message: e.message,
          statusCode: e.statusCode,
        ),
      );
    }
  }
}
