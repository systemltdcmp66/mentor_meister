import 'package:dartz/dartz.dart';
import 'package:mentormeister/core/errors/exceptions.dart';
import 'package:mentormeister/core/errors/failure.dart';
import 'package:mentormeister/core/utils/typedefs.dart';
import 'package:mentormeister/features/Teacher/data/datasources/teacher_sign_up_remote_data_src.dart';
import 'package:mentormeister/features/Teacher/domain/entities/teacher_info.dart';
import 'package:mentormeister/features/Teacher/domain/repositories/teacher_sign_up_repository.dart';

class TeacherSignUpRepoImpl implements TeacherSignUpRepository {
  const TeacherSignUpRepoImpl(this._remoteDataSrc);

  final TeacherSignUpRemoteDataSrc _remoteDataSrc;
  @override
  ResultFuture<TeacherInfo> getTeacherInformations(String params) async {
    try {
      final result = await _remoteDataSrc.getTeacherInformations(params);
      return Right(result);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.message,
          statusCode: e.statusCode,
        ),
      );
    }
  }

  @override
  ResultFuture<void> postTeacherInformations(TeacherInfo teacherInfo) async {
    try {
      await _remoteDataSrc.postTeacherInformations(teacherInfo);
      return const Right(null);
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
