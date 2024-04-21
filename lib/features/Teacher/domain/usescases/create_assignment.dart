import 'package:mentormeister/core/usecases/usecases.dart';
import 'package:mentormeister/core/utils/typedefs.dart';
import 'package:mentormeister/features/Teacher/domain/entities/assignment.dart';
import 'package:mentormeister/features/Teacher/domain/repositories/assignment_repository.dart';

class GetAssignments extends UseCaseWithoutParams<List<XAssignment>> {
  final AssignmentRepository _repository;
  const GetAssignments(this._repository);

  @override
  ResultFuture<List<XAssignment>> call() => _repository.getAssignments();
}
