import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentormeister/features/Teacher/domain/entities/assignment.dart';
import 'package:mentormeister/features/Teacher/domain/usescases/create_assignment.dart';
import 'package:mentormeister/features/Teacher/domain/usescases/get_assignments.dart';
import 'package:mentormeister/features/Teacher/presentation/app/assignment_cubit/assignment_state.dart';

class AssignmentCubit extends Cubit<AssignmentState> {
  AssignmentCubit({
    required CreateAssignment createAssignment,
    required GetAssignments getAssignments,
  })  : _createAssignment = createAssignment,
        _getAssignments = getAssignments,
        super(
          const AssignmentInitial(),
        );

  final CreateAssignment _createAssignment;
  final GetAssignments _getAssignments;

  Future<void> createAssignment(XAssignment assignment) async {
    emit(
      const CreatingAssignment(),
    );

    final result = await _createAssignment(assignment);

    result.fold(
      (failure) => emit(
        AssignmentError(
          failure.errorMessage,
        ),
      ),
      (_) => emit(
        const AssignmentCreated(),
      ),
    );
  }

  Future<void> getAssignments() async {
    emit(
      const GettingAssignments(),
    );

    final result = await _getAssignments();

    result.fold(
      (failure) => emit(
        AssignmentError(
          failure.errorMessage,
        ),
      ),
      (assignments) => emit(
        AssignmentsFetched(assignments),
      ),
    );
  }
}
