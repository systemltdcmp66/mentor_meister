import 'package:mentormeister/core/usecases/usecases.dart';
import 'package:mentormeister/core/utils/typedefs.dart';
import 'package:mentormeister/features/Onboarding&Authentication/domain/repositories/authentication_repository.dart';

class ForgotPassword extends UseCaseWithParams<void, String> {
  const ForgotPassword(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultFuture<void> call(String params) => _repository.forgotPassword(params);
}
