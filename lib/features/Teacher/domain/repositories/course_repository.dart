import 'package:mentormeister/core/utils/typedefs.dart';
import 'package:mentormeister/features/Teacher/domain/entities/course.dart';

abstract class CourseRepository {
  const CourseRepository();

  ResultFuture<void> createCourse(Course course);

  ResultFuture<List<Course>> getCourses();
}
