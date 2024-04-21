import 'package:mentormeister/core/usecases/usecases.dart';
import 'package:mentormeister/core/utils/typedefs.dart';
import 'package:mentormeister/features/Teacher/domain/entities/course.dart';
import 'package:mentormeister/features/Teacher/domain/repositories/course_repository.dart';

class GetCourses extends UseCaseWithoutParams<List<Course>> {
  const GetCourses(this._repository);
  final CourseRepository _repository;

  @override
  ResultFuture<List<Course>> call() => _repository.getCourses();
}
