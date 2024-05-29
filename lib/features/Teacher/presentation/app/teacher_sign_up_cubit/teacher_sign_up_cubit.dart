import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentormeister/features/Teacher/domain/entities/teacher_info.dart';
import 'package:mentormeister/features/Teacher/domain/usescases/get_all_teacher_infos.dart';
import 'package:mentormeister/features/Teacher/domain/usescases/get_hired_teacher_infos.dart';
import 'package:mentormeister/features/Teacher/domain/usescases/get_teacher_courses.dart';
import 'package:mentormeister/features/Teacher/domain/usescases/get_teacher_info.dart';
import 'package:mentormeister/features/Teacher/domain/usescases/get_teacher_users_data.dart';
import 'package:mentormeister/features/Teacher/domain/usescases/hire_a_teacher.dart';
import 'package:mentormeister/features/Teacher/domain/usescases/post_teacher_info.dart';
import 'package:mentormeister/features/Teacher/presentation/app/teacher_sign_up_cubit/teacher_sign_up_state.dart';

class TeacherSignUpCubit extends Cubit<TeacherSignUpState> {
  TeacherSignUpCubit({
    required PostTeacherInformations postTeacherInformations,
    required GetTeacherInformations getTeacherInformations,
    required GetAllTeacherInformations getAllTeacherInformations,
    required HireATeacher hireATeacher,
    required GetHiredTeacherInfos getHiredTeacherInfos,
    required GetTeacherUsersData getTeacherUsersData,
    required GetTeacherCourses getTeacherCourses,
  })  : _postTeacherInformations = postTeacherInformations,
        _getTeacherInformations = getTeacherInformations,
        _getAllTeacherInformations = getAllTeacherInformations,
        _hireATeacher = hireATeacher,
        _getHiredTeacherInfos = getHiredTeacherInfos,
        _getTeacherUsersData = getTeacherUsersData,
        _getTeacherCourses = getTeacherCourses,
        super(
          const TeacherSignUpInitial(),
        );

  final PostTeacherInformations _postTeacherInformations;
  final GetTeacherInformations _getTeacherInformations;
  final GetAllTeacherInformations _getAllTeacherInformations;
  final HireATeacher _hireATeacher;
  final GetHiredTeacherInfos _getHiredTeacherInfos;
  final GetTeacherUsersData _getTeacherUsersData;
  final GetTeacherCourses _getTeacherCourses;

  Future<void> hireATeacher(String teacherId) async {
    emit(
      const HiringATeacher(),
    );
    final result = await _hireATeacher(teacherId);

    result.fold(
      (failure) => emit(
        HiringTeacherError(failure.errorMessage),
      ),
      (_) => emit(
        const TeacherHired(),
      ),
    );
  }

  Future<void> getTeacherCourses() async {
    emit(
      const GettingTeacherCourses(),
    );
    final result = await _getTeacherCourses();

    result.fold(
      (failure) => emit(
        TeacherCoursesError(failure.errorMessage),
      ),
      (teacherCourses) => emit(
        TeacherCoursesFetched(
          teacherCourses,
        ),
      ),
    );
  }

  Future<void> getHiredTeacherInfos() async {
    emit(
      const GettingHiredTeacherInfos(),
    );
    final result = await _getHiredTeacherInfos();

    result.fold(
      (failure) => emit(
        HiringTeacherError(failure.errorMessage),
      ),
      (hiredTeacherInfos) => emit(
        HiredTeacherInfosFetched(
          hiredTeacherInfos,
        ),
      ),
    );
  }

  Future<void> getAllTeacherInformations() async {
    emit(
      const GettingAllTeacherInformations(),
    );

    final result = await _getAllTeacherInformations();

    result.fold(
      (failure) => emit(
        TeacherInformationsError(failure.errorMessage),
      ),
      (allTeacherInfos) => emit(
        AllTeacherInformationsFetched(allTeacherInfos),
      ),
    );
  }

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

  Future<void> getTeacherUsersData(String teacherId) async {
    emit(const GettingTeacherUsersData());

    final result = await _getTeacherUsersData(teacherId);

    result.fold(
      (failure) => emit(
        TeacherUsersDataError(
          failure.errorMessage,
        ),
      ),
      (teacherUsersData) => emit(
        TeacherUsersDataFetched(
          teacherUsersData,
        ),
      ),
    );
  }
}
