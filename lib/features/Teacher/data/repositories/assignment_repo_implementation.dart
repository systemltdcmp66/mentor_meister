import 'package:dartz/dartz.dart';
import 'package:mentormeister/core/errors/exceptions.dart';
import 'package:mentormeister/core/errors/failure.dart';
import 'package:mentormeister/core/utils/typedefs.dart';
import 'package:mentormeister/features/Teacher/data/datasources/assignment_remote_data_src.dart';
import 'package:mentormeister/features/Teacher/domain/entities/assignment.dart';
import 'package:mentormeister/features/Teacher/domain/repositories/assignment_repository.dart';

class AssignmentRepositoryImpl implements AssignmentRepository {
  const AssignmentRepositoryImpl(this._remoteDataSrc);
  final AssignmentRemoteDataSrc _remoteDataSrc;
  @override
  ResultFuture<void> createAssignment(XAssignment assignment) async {
    try {
      await _remoteDataSrc.createAssignment(assignment);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(message: e.message, statusCode: e.statusCode),
      );
    }
  }

  @override
  ResultFuture<List<XAssignment>> getAssignments() async {
    try {
      final assignments = await _remoteDataSrc.getAssignments();
      return Right(assignments);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(message: e.message, statusCode: e.statusCode),
      );
    }
  }
}
