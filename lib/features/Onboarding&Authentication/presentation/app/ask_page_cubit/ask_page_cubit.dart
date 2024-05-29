import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentormeister/features/Onboarding&Authentication/domain/usecases/check_if_user_is_a_student.dart';
import 'package:mentormeister/features/Onboarding&Authentication/domain/usecases/chek_if_user_is_a_teacher.dart';
import 'package:mentormeister/features/Onboarding&Authentication/domain/usecases/is_a_student.dart';
import 'package:mentormeister/features/Onboarding&Authentication/domain/usecases/is_a_teacher.dart';
import 'package:mentormeister/features/Onboarding&Authentication/presentation/app/ask_page_cubit/ask_page_state.dart';

class AskPageCubit extends Cubit<AskPageState> {
  AskPageCubit({
    required IsAStudent isAStudent,
    required IsATeacher isATeacher,
    required CheckIfUserIsAStudent checkIfUserIsAStudent,
    required CheckIfUserIsATeacher checkIfUserIsATeacher,
  })  : _isAStudent = isAStudent,
        _isATeacher = isATeacher,
        _checkIfUserIsAStudent = checkIfUserIsAStudent,
        _checkIfUserIsATeacher = checkIfUserIsATeacher,
        super(
          const AskPageInitial(),
        );

  final IsAStudent _isAStudent;
  final IsATeacher _isATeacher;
  final CheckIfUserIsAStudent _checkIfUserIsAStudent;
  final CheckIfUserIsATeacher _checkIfUserIsATeacher;

  Future<void> isAStudent() async {
    emit(const CachingStudent());

    final result = await _isAStudent();

    result.fold(
      (failure) => emit(
        AskPageError(failure.errorMessage),
      ),
      (_) => emit(
        const StudentCached(),
      ),
    );
  }

  Future<void> isATeacher() async {
    emit(const CachingTeacher());

    final result = await _isATeacher();

    result.fold(
      (failure) => emit(
        AskPageError(failure.errorMessage),
      ),
      (_) => emit(
        const TeacherCached(),
      ),
    );
  }

  Future<void> checkingIfUserIsAStudent() async {
    emit(const CheckingIfUserIsAStudent());

    final result = await _checkIfUserIsAStudent();

    result.fold(
      (failure) => emit(
        const StudentStatus(false),
      ),
      (isAStudent) => emit(
        StudentStatus(isAStudent!),
      ),
    );
  }

  Future<void> checkingIfUserIsATeacher() async {
    emit(const CheckingIfUserIsATeacher());

    final result = await _checkIfUserIsATeacher();

    result.fold(
      (failure) => emit(
        const StudentStatus(false),
      ),
      (isAStudent) => emit(
        TeacherStatus(isAStudent!),
      ),
    );
  }
}
