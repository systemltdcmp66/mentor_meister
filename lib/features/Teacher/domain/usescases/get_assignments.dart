import 'package:mentormeister/core/usecases/usecases.dart';
import 'package:mentormeister/core/utils/typedefs.dart';
import 'package:mentormeister/features/Teacher/domain/entities/assignment.dart';
import 'package:mentormeister/features/Teacher/domain/repositories/assignment_repository.dart';

class CreateAssignment extends UseCaseWithParams<void, XAssignment> {
  final AssignmentRepository _repository;
  const CreateAssignment(this._repository);

  @override
  ResultFuture<void> call(XAssignment params) =>
      _repository.createAssignment(params);
}
