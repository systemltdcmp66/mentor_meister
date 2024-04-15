import 'package:mentormeister/core/utils/typedefs.dart';

abstract class AskPageRepository {
  const AskPageRepository();

  ResultFuture<void> isAStudent();
  ResultFuture<void> isATeacher();

  ResultFuture<bool> checkIfUserIsAStudent();
  ResultFuture<bool> checkIfUserIsATeacher();
}
