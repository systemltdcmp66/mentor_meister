import 'package:mentormeister/core/usecases/usecases.dart';
import 'package:mentormeister/core/utils/typedefs.dart';
import 'package:mentormeister/features/Onboarding&Authentication/domain/repositories/ask_page_repository.dart';

class CheckIfUserIsATeacher extends UseCaseWithoutParams<bool?> {
  const CheckIfUserIsATeacher(this._repository);

  final AskPageRepository _repository;

  @override
  ResultFuture<bool?> call() => _repository.checkIfUserIsATeacher();
}
