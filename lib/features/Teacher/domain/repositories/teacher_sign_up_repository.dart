import 'package:mentormeister/core/utils/typedefs.dart';
import 'package:mentormeister/features/Teacher/domain/entities/teacher_info.dart';

abstract class TeacherSignUpRepository {
  const TeacherSignUpRepository();

  ResultFuture<void> postTeacherInformations(TeacherInfo teacherInfo);

  ResultFuture<TeacherInfo> getTeacherInformations(String id);
}
