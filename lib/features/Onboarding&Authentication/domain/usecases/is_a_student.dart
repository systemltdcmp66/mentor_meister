import 'package:mentormeister/core/usecases/usecases.dart';
import 'package:mentormeister/core/utils/typedefs.dart';
import 'package:mentormeister/features/Onboarding&Authentication/domain/repositories/ask_page_repository.dart';

class IsAStudent extends UseCaseWithoutParams<void> {
  const IsAStudent(this._repository);

  final AskPageRepository _repository;

  @override
  ResultFuture<void> call() => _repository.isAStudent();
}
