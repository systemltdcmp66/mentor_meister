import 'package:mentormeister/core/utils/typedefs.dart';
import 'package:mentormeister/features/Onboarding&Authentication/domain/entities/user.dart';
import 'package:mentormeister/features/Teacher/domain/entities/course.dart';
import 'package:mentormeister/features/Teacher/domain/entities/teacher_info.dart';

abstract class TeacherSignUpRepository {
  const TeacherSignUpRepository();

  ResultFuture<void> postTeacherInformations(TeacherInfo teacherInfo);

  ResultFuture<TeacherInfo> getTeacherInformations(String id);

  ResultFuture<List<TeacherInfo>> getAllTeacherInformations();

  ResultFuture<void> hireATeacher(String teacherId);

  ResultFuture<List<TeacherInfo>> getHiredTeacherInfos();

  ResultFuture<List<LocaleUser>> getTeacherUsersData(String teacherId);

  ResultFuture<List<Course>> getTeacherCourses();
}
