import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentormeister/features/Teacher/domain/entities/course.dart';
import 'package:mentormeister/features/Teacher/domain/usescases/create_course.dart';
import 'package:mentormeister/features/Teacher/domain/usescases/get_courses.dart';
import 'package:mentormeister/features/Teacher/presentation/app/course_cubit/course_state.dart';

class CourseCubit extends Cubit<CourseState> {
  CourseCubit({
    required CreateCourse createCourse,
    required GetCourses getCourses,
  })  : _createCourse = createCourse,
        _getCourses = getCourses,
        super(
          const CourseInitial(),
        );

  final CreateCourse _createCourse;
  final GetCourses _getCourses;

  Future<void> createCourse(Course course) async {
    emit(
      const CreatingCourse(),
    );

    final result = await _createCourse(course);

    result.fold(
      (failure) => emit(
        CourseError(
          failure.errorMessage,
        ),
      ),
      (_) => emit(
        const CourseCreated(),
      ),
    );
  }

  Future<void> getCourses() async {
    emit(
      const GettingCourse(),
    );

    final result = await _getCourses();

    result.fold(
      (failure) => emit(
        CourseError(
          failure.errorMessage,
        ),
      ),
      (courses) => emit(
        CourseFetched(courses),
      ),
    );
  }
}
