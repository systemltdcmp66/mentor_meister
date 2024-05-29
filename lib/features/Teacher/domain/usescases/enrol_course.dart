import 'package:mentormeister/core/usecases/usecases.dart';
import 'package:mentormeister/core/utils/typedefs.dart';
import 'package:mentormeister/features/Teacher/domain/repositories/course_repository.dart';

class EnrollCourse extends UseCaseWithParams<void, String> {
  const EnrollCourse(this._repository);

  final CourseRepository _repository;

  @override
  ResultFuture<void> call(String params) => _repository.enrolCourse(params);
}
