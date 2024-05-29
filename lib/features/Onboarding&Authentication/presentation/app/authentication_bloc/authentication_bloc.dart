import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mentormeister/core/enums/update_user.dart';
import 'package:mentormeister/features/Onboarding&Authentication/domain/entities/user.dart';
import 'package:mentormeister/features/Onboarding&Authentication/domain/usecases/forgot_password.dart';
import 'package:mentormeister/features/Onboarding&Authentication/domain/usecases/get_all_users.dart';
import 'package:mentormeister/features/Onboarding&Authentication/domain/usecases/sign_in.dart';
import 'package:mentormeister/features/Onboarding&Authentication/domain/usecases/sign_up.dart';
import 'package:mentormeister/features/Onboarding&Authentication/domain/usecases/update_user.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required SignIn signIn,
    required SignUp signUp,
    required ForgotPassword forgotPassword,
    required UpdateUser updateUser,
    required GetAllUsers getAllUsers,
  })  : _signIn = signIn,
        _signUp = signUp,
        _forgotPassword = forgotPassword,
        _updateUser = updateUser,
        _getAllUsers = getAllUsers,
        super(const AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) {
      emit(const AuthenticationLoading());
    });

    on<SignInEvent>(_signInHandler);

    on<SignUpEvent>(_signUpHandler);

    on<ForgotPasswordEvent>(_forgotPasswordHandler);

    on<UpdateUserEvent>(_updateUserHandler);

    on<GetAllUsersEvent>(_getAllUsersHandler);
  }

  final SignIn _signIn;
  final SignUp _signUp;
  final ForgotPassword _forgotPassword;
  final UpdateUser _updateUser;
  final GetAllUsers _getAllUsers;

  Future<void> _signInHandler(
    SignInEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    final result = await _signIn(
      SignInParams(
        email: event.email,
        password: event.password,
      ),
    );

    result.fold(
      (failure) => emit(AuthenticationError(failure.errorMessage)),
      (user) => emit(UserSignedIn(user)),
    );
  }

  Future<void> _signUpHandler(
    SignUpEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    final result = await _signUp(
      SignUpParams(
        name: event.name,
        email: event.email,
        phoneNumber: event.phoneNumber,
        password: event.password,
      ),
    );

    result.fold(
      (failure) => emit(AuthenticationError(failure.errorMessage)),
      (_) => emit(const UserSignedUp()),
    );
  }

  Future<void> _forgotPasswordHandler(
    ForgotPasswordEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    final result = await _forgotPassword(
      event.email,
    );

    result.fold(
      (failure) => emit(AuthenticationError(failure.errorMessage)),
      (_) => emit(const UserPasswordSent()),
    );
  }

  Future<void> _updateUserHandler(
    UpdateUserEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    final result = await _updateUser(
      UpdateUserParams(
        action: event.action,
        userData: event.userData,
      ),
    );

    result.fold(
      (failure) => emit(AuthenticationError(failure.errorMessage)),
      (_) => emit(const UserDataUpdated()),
    );
  }

  Future<void> _getAllUsersHandler(
    GetAllUsersEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    final result = await _getAllUsers();
    result.fold(
      (failure) => emit(AuthenticationError(failure.errorMessage)),
      (users) => emit(
        AllUsersFetched(users),
      ),
    );
  }
}
