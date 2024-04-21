import 'package:equatable/equatable.dart';
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
