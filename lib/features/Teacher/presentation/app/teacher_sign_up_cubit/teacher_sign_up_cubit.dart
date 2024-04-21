import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentormeister/features/Teacher/domain/entities/teacher_info.dart';
import 'package:mentormeister/features/Teacher/domain/usescases/get_teacher_info.dart';
import 'package:mentormeister/features/Teacher/domain/usescases/post_teacher_info.dart';
import 'package:mentormeister/features/Teacher/presentation/app/teacher_sign_up_cubit/teacher_sign_up_state.dart';

class TeacherSignUpCubit extends Cubit<TeacherSignUpState> {
  TeacherSignUpCubit({
    required PostTeacherInformations postTeacherInformations,
    required GetTeacherInformations getTeacherInformations,
  })  : _postTeacherInformations = postTeacherInformations,
        _getTeacherInformations = getTeacherInformations,
        super(
          const TeacherSignUpInitial(),
        );

  final PostTeacherInformations _postTeacherInformations;
  final GetTeacherInformations _getTeacherInformations;

  Future<void> postTeacherInformations(
    TeacherInfo teacherInfo,
  ) async {
    emit(const PostingTeacherInfo());

    final result = await _postTeacherInformations(teacherInfo);

    result.fold(
      (failure) => emit(
        TeacherSignUpError(
          failure.errorMessage,
        ),
      ),
      (_) => emit(
        const TeacherInfoPosted(),
      ),
    );
  }

  Future<void> getTeacherInformations(
    String id,
  ) async {
    emit(const GettingTeacherInfo());

    final result = await _getTeacherInformations(id);

    result.fold(
      (failure) => emit(
        TeacherSignUpError(
          failure.errorMessage,
        ),
      ),
      (teacherInfo) => emit(
        TeacherInfoFetched(
          teacherInfo,
        ),
      ),
    );
  }
}
