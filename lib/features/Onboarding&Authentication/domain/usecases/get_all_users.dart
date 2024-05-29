import 'package:mentormeister/core/usecases/usecases.dart';
import 'package:mentormeister/core/utils/typedefs.dart';
import 'package:mentormeister/features/Onboarding&Authentication/domain/entities/user.dart';
import 'package:mentormeister/features/Onboarding&Authentication/domain/repositories/authentication_repository.dart';

class GetAllUsers extends UseCaseWithoutParams<List<LocaleUser>> {
  const GetAllUsers(this._repository);

  final AuthenticationRepository _repository;
  @override
  ResultFuture<List<LocaleUser>> call() => _repository.getAllUsers();
}
