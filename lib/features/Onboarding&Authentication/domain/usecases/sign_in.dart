import 'package:equatable/equatable.dart';
import 'package:mentormeister/core/usecases/usecases.dart';
import 'package:mentormeister/core/utils/typedefs.dart';
import 'package:mentormeister/features/Onboarding&Authentication/domain/entities/user.dart';
import 'package:mentormeister/features/Onboarding&Authentication/domain/repositories/authentication_repository.dart';

class SignIn extends UseCaseWithParams<LocaleUser, SignInParams> {
  const SignIn(this._repository);

  final AuthenticationRepository _repository;
  @override
  ResultFuture<LocaleUser> call(SignInParams params) => _repository.signIn(
        email: params.email,
        password: params.password,
      );
}

class SignInParams extends Equatable {
  const SignInParams({
    required this.email,
    required this.password,
  });

  const SignInParams.empty()
      : this(
          email: '',
          password: '',
        );

  final String email;
  final String password;
  @override
  List<Object?> get props => [email, password];
}
