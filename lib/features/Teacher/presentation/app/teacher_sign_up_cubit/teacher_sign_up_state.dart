import 'package:equatable/equatable.dart';
import 'package:mentormeister/features/Onboarding&Authentication/domain/entities/user.dart';
import 'package:mentormeister/features/Teacher/domain/entities/course.dart';
import 'package:mentormeister/features/Teacher/domain/entities/teacher_info.dart';

abstract class TeacherSignUpState extends Equatable {
  const TeacherSignUpState();

  @override
  List<Object?> get props => [];
}

class TeacherSignUpInitial extends TeacherSignUpState {
  const TeacherSignUpInitial();
}

class PostingTeacherInfo extends TeacherSignUpState {
  const PostingTeacherInfo();
}

class GettingTeacherInfo extends TeacherSignUpState {
  const GettingTeacherInfo();
}

class TeacherInfoPosted extends TeacherSignUpState {
  const TeacherInfoPosted();
}

class TeacherInfoFetched extends TeacherSignUpState {
  const TeacherInfoFetched(this.teacherInfo);

  final TeacherInfo teacherInfo;

  @override
  List<String> get props => [teacherInfo.id];
}

class TeacherSignUpError extends TeacherSignUpState {
  const TeacherSignUpError(this.message);

  final String message;

  @override
  List<String> get props => [message];
}

class AllTeacherInformationsFetched extends TeacherSignUpState {
  const AllTeacherInformationsFetched(this.allTeacherInfos);

  final List<TeacherInfo> allTeacherInfos;

  @override
  List<String> get props => allTeacherInfos.map((e) => e.id).toList();
}

class GettingAllTeacherInformations extends TeacherSignUpState {
  const GettingAllTeacherInformations();
}

class TeacherInformationsError extends TeacherSignUpState {
  const TeacherInformationsError(this.message);

  final String message;

  @override
  List<String> get props => [message];
}

class HiringATeacher extends TeacherSignUpState {
  const HiringATeacher();
}

class TeacherHired extends TeacherSignUpState {
  const TeacherHired();
}

class GettingHiredTeacherInfos extends TeacherSignUpState {
  const GettingHiredTeacherInfos();
}

class HiredTeacherInfosFetched extends TeacherSignUpState {
  const HiredTeacherInfosFetched(this.hiredTeacherInfos);

  final List<TeacherInfo> hiredTeacherInfos;

  @override
  List<String> get props => hiredTeacherInfos.map((e) => e.id).toList();
}

class HiringTeacherError extends TeacherSignUpState {
  const HiringTeacherError(this.message);

  final String message;

  @override
  List<String> get props => [message];
}

class TeacherUsersDataError extends TeacherSignUpState {
  const TeacherUsersDataError(this.message);

  final String message;

  @override
  List<String> get props => [message];
}

class GettingTeacherUsersData extends TeacherSignUpState {
  const GettingTeacherUsersData();
}

class TeacherUsersDataFetched extends TeacherSignUpState {
  const TeacherUsersDataFetched(this.teacherUsersData);

  final List<LocaleUser> teacherUsersData;

  @override
  List<String> get props => teacherUsersData
      .map(
        (e) => e.uid,
      )
      .toList();
}

class GettingTeacherCourses extends TeacherSignUpState {
  const GettingTeacherCourses();
}

class TeacherCoursesFetched extends TeacherSignUpState {
  const TeacherCoursesFetched(this.teacherCourses);

  final List<Course> teacherCourses;

  @override
  List<String> get props => teacherCourses
      .map(
        (e) => e.id,
      )
      .toList();
}

class TeacherCoursesError extends TeacherSignUpState {
  const TeacherCoursesError(this.message);

  final String message;

  @override
  List<String> get props => [message];
}
