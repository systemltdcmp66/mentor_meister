import 'package:mentormeister/core/enums/update_user.dart';
import 'package:mentormeister/core/utils/typedefs.dart';
import 'package:mentormeister/features/Onboarding&Authentication/domain/entities/user.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  ResultFuture<LocaleUser> signIn({
    required String email,
    required String password,
  });

  ResultFuture<void> signUp({
    required String name,
    required String email,
    required String phoneNumber,
    required String password,
  });

  ResultFuture<void> forgotPassword(String email);

  ResultFuture<void> updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  });
}
