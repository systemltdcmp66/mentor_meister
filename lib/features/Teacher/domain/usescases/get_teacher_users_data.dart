import 'package:mentormeister/core/usecases/usecases.dart';
import 'package:mentormeister/core/utils/typedefs.dart';
import 'package:mentormeister/features/Onboarding&Authentication/domain/entities/user.dart';
import 'package:mentormeister/features/Teacher/domain/repositories/teacher_sign_up_repository.dart';

class GetTeacherUsersData extends UseCaseWithParams<List<LocaleUser>, String> {
  const GetTeacherUsersData(this._repository);

  final TeacherSignUpRepository _repository;

  @override
  ResultFuture<List<LocaleUser>> call(String params) =>
      _repository.getTeacherUsersData(
        params,
      );
}
