import 'package:mentormeister/core/usecases/usecases.dart';
import 'package:mentormeister/core/utils/typedefs.dart';
import 'package:mentormeister/features/Teacher/domain/entities/teacher_info.dart';
import 'package:mentormeister/features/Teacher/domain/repositories/teacher_sign_up_repository.dart';

class GetTeacherInformations extends UseCaseWithParams<TeacherInfo, String> {
  const GetTeacherInformations(this._repository);

  final TeacherSignUpRepository _repository;

  @override
  ResultFuture<TeacherInfo> call(String params) =>
      _repository.getTeacherInformations(params);
}
