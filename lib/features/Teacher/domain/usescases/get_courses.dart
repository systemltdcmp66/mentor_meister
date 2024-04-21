import 'package:mentormeister/core/usecases/usecases.dart';
import 'package:mentormeister/core/utils/typedefs.dart';
import 'package:mentormeister/features/Teacher/domain/entities/course.dart';
import 'package:mentormeister/features/Teacher/domain/repositories/course_repository.dart';

class CreateCourse extends UseCaseWithParams<void, Course> {
  CreateCourse(this._repository);

  final CourseRepository _repository;

  @override
  ResultFuture<void> call(Course params) => _repository.createCourse(params);
}
