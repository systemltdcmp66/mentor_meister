import 'package:mentormeister/core/usecases/usecases.dart';
import 'package:mentormeister/core/utils/typedefs.dart';
import 'package:mentormeister/features/Teacher/domain/entities/course.dart';
import 'package:mentormeister/features/Teacher/domain/repositories/teacher_sign_up_repository.dart';

class GetTeacherCourses extends UseCaseWithoutParams<List<Course>> {
  const GetTeacherCourses(this._repository);

  final TeacherSignUpRepository _repository;

  @override
  ResultFuture<List<Course>> call() => _repository.getTeacherCourses();
}
