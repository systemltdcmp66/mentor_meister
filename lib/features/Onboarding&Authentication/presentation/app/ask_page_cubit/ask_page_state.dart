import 'package:equatable/equatable.dart';

abstract class AskPageState extends Equatable {
  const AskPageState();

  @override
  List<Object?> get props => [];
}

class AskPageInitial extends AskPageState {
  const AskPageInitial();
}

class CachingStudent extends AskPageState {
  const CachingStudent();
}

class CachingTeacher extends AskPageState {
  const CachingTeacher();
}

class StudentCached extends AskPageState {
  const StudentCached();
}

class TeacherCached extends AskPageState {
  const TeacherCached();
}

class CheckingIfUserIsAStudent extends AskPageState {
  const CheckingIfUserIsAStudent();
}

class CheckingIfUserIsATeacher extends AskPageState {
  const CheckingIfUserIsATeacher();
}

class StudentStatus extends AskPageState {
  const StudentStatus(this.isAStudent);

  final bool isAStudent;

  @override
  List<bool> get props => [isAStudent];
}

class TeacherStatus extends AskPageState {
  const TeacherStatus(this.isATeacher);

  final bool isATeacher;

  @override
  List<bool> get props => [isATeacher];
}

class AskPageError extends AskPageState {
  const AskPageError(this.message);

  final String message;

  @override
  List<String> get props => [message];
}
