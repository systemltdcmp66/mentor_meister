import 'package:mentormeister/core/usecases/usecases.dart';
import 'package:mentormeister/core/utils/typedefs.dart';
import 'package:mentormeister/features/Onboarding&Authentication/domain/repositories/ask_page_repository.dart';

class CheckIfUserIsAStudent extends UseCaseWithoutParams<bool?> {
  const CheckIfUserIsAStudent(this._repository);

  final AskPageRepository _repository;

  @override
  ResultFuture<bool?> call() => _repository.checkIfUserIsAStudent();
}
