import 'package:equatable/equatable.dart';
import 'package:mentormeister/features/Teacher/domain/entities/course.dart';

abstract class CourseState extends Equatable {
  const CourseState();

  @override
  List<Object?> get props => [];
}

class CourseInitial extends CourseState {
  const CourseInitial();
}

class CreatingCourse extends CourseState {
  const CreatingCourse();
}

class GettingCourse extends CourseState {
  const GettingCourse();
}

class CourseCreated extends CourseState {
  const CourseCreated();
}

class CourseFetched extends CourseState {
  const CourseFetched(this.courses);
  final List<Course> courses;

  @override
  List<String> get props => courses.map((e) => e.id).toList();
}

class EnrollingCourse extends CourseState {
  const EnrollingCourse();
}

class GettingEnrolledCourses extends CourseState {
  const GettingEnrolledCourses();
}

class EnrolledCoursesFetched extends CourseState {
  const EnrolledCoursesFetched(this.enrolledCourses);

  final List<Course> enrolledCourses;

  @override
  List<String> get props => enrolledCourses.map((e) => e.id).toList();
}

class CourseEnrolled extends CourseState {
  const CourseEnrolled();
}

class GettinngEnrolledCoursedError extends CourseState {
  final String message;
  const GettinngEnrolledCoursedError(this.message);

  @override
  List<String> get props => [message];
}

class CourseError extends CourseState {
  final String message;
  const CourseError(this.message);

  @override
  List<String> get props => [message];
}
