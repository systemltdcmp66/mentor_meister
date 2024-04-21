import 'package:mentormeister/core/utils/typedefs.dart';
import 'package:mentormeister/features/Teacher/domain/entities/assignment.dart';

abstract class AssignmentRepository {
  const AssignmentRepository();

  ResultFuture<void> createAssignment(XAssignment assignment);

  ResultFuture<List<XAssignment>> getAssignments();
}
