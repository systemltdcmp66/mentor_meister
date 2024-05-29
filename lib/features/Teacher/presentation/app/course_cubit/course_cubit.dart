import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentormeister/features/Teacher/domain/entities/course.dart';
import 'package:mentormeister/features/Teacher/domain/usescases/create_course.dart';
import 'package:mentormeister/features/Teacher/domain/usescases/enrol_course.dart';
import 'package:mentormeister/features/Teacher/domain/usescases/get_courses.dart';
import 'package:mentormeister/features/Teacher/domain/usescases/get_enrolled_courses.dart';
import 'package:mentormeister/features/Teacher/presentation/app/course_cubit/course_state.dart';

class CourseCubit extends Cubit<CourseState> {
  CourseCubit({
    required CreateCourse createCourse,
    required GetCourses getCourses,
    required EnrollCourse enrollCourse,
    required GetEnrolledCourses getEnrolledCourses,
  })  : _createCourse = createCourse,
        _getCourses = getCourses,
        _enrollCourse = enrollCourse,
        _getEnrolledCourses = getEnrolledCourses,
        super(
          const CourseInitial(),
        );

  final CreateCourse _createCourse;
  final GetCourses _getCourses;
  final EnrollCourse _enrollCourse;
  final GetEnrolledCourses _getEnrolledCourses;

  Future<void> getEnrolledCourses() async {
    emit(
      const GettingEnrolledCourses(),
    );

    final result = await _getEnrolledCourses();

    result.fold(
      (failure) => emit(
        GettinngEnrolledCoursedError(
          failure.errorMessage,
        ),
      ),
      (enrolledCourses) => emit(
        EnrolledCoursesFetched(enrolledCourses),
      ),
    );
  }

  Future<void> enrollCourse(String courseId) async {
    emit(
      const EnrollingCourse(),
    );

    final result = await _enrollCourse(courseId);

    result.fold(
      (failure) => emit(
        CourseError(failure.errorMessage),
      ),
      (_) => emit(
        const CourseEnrolled(),
      ),
    );
  }

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
