import 'package:mentormeister/core/usecases/usecases.dart';
import 'package:mentormeister/core/utils/typedefs.dart';
import 'package:mentormeister/features/Teacher/domain/repositories/teacher_sign_up_repository.dart';

class HireATeacher extends UseCaseWithParams<void, String> {
  const HireATeacher(this._repository);

  final TeacherSignUpRepository _repository;

  @override
  ResultFuture<void> call(String params) => _repository.hireATeacher(params);
}
