import 'package:equatable/equatable.dart';
import 'package:mentormeister/features/Teacher/domain/entities/assignment.dart';

abstract class AssignmentState extends Equatable {
  const AssignmentState();

  @override
  List<Object?> get props => [];
}

class AssignmentInitial extends AssignmentState {
  const AssignmentInitial();
}

class CreatingAssignment extends AssignmentState {
  const CreatingAssignment();
}

class GettingAssignments extends AssignmentState {
  const GettingAssignments();
}

class AssignmentCreated extends AssignmentState {
  const AssignmentCreated();
}

class AssignmentsFetched extends AssignmentState {
  const AssignmentsFetched(this.assignments);
  final List<XAssignment> assignments;

  @override
  List<String> get props => assignments.map((e) => e.id).toList();
}

class AssignmentError extends AssignmentState {
  final String message;
  const AssignmentError(this.message);

  @override
  List<String> get props => [message];
}
