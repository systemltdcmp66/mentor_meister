import 'package:equatable/equatable.dart';
import 'package:mentormeister/core/usecases/usecases.dart';
import 'package:mentormeister/core/utils/typedefs.dart';
import 'package:mentormeister/features/Onboarding&Authentication/domain/repositories/authentication_repository.dart';

class SignUp extends UseCaseWithParams<void, SignUpParams> {
  const SignUp(this._repository);

  final AuthenticationRepository _repository;
  @override
  ResultFuture<void> call(SignUpParams params) => _repository.signUp(
        name: params.name,
        email: params.email,
        phoneNumber: params.phoneNumber,
        password: params.password,
      );
}

class SignUpParams extends Equatable {
  const SignUpParams({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.password,
  });

  const SignUpParams.empty()
      : this(
          email: '',
          name: '',
          phoneNumber: '+919654361924',
          password: '',
        );

  final String name;
  final String email;
  final String phoneNumber;
  final String password;
  @override
  List<Object?> get props => [name, email, password];
}
