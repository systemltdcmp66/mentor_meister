import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:mentormeister/features/Onboarding&Authentication/data/datasources/ask_page_locale_data_source.dart';
import 'package:mentormeister/features/Onboarding&Authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:mentormeister/features/Onboarding&Authentication/data/datasources/on_boarding_local_data_source.dart';
import 'package:mentormeister/features/Onboarding&Authentication/data/repositories/ask_page_repository_implementation.dart';
import 'package:mentormeister/features/Onboarding&Authentication/data/repositories/authentication_repository_implementation.dart';
import 'package:mentormeister/features/Onboarding&Authentication/data/repositories/on_boarding_repository_implementation.dart';
import 'package:mentormeister/features/Onboarding&Authentication/domain/repositories/ask_page_repository.dart';
import 'package:mentormeister/features/Onboarding&Authentication/domain/repositories/authentication_repository.dart';
import 'package:mentormeister/features/Onboarding&Authentication/domain/repositories/on_boarding_repository.dart';
import 'package:mentormeister/features/Onboarding&Authentication/domain/usecases/cache_first_timer.dart';
import 'package:mentormeister/features/Onboarding&Authentication/domain/usecases/check_if_user_is_a_student.dart';
import 'package:mentormeister/features/Onboarding&Authentication/domain/usecases/check_if_user_is_first_timer.dart';
import 'package:mentormeister/features/Onboarding&Authentication/domain/usecases/chek_if_user_is_a_teacher.dart';
import 'package:mentormeister/features/Onboarding&Authentication/domain/usecases/forgot_password.dart';
import 'package:mentormeister/features/Onboarding&Authentication/domain/usecases/is_a_student.dart';
import 'package:mentormeister/features/Onboarding&Authentication/domain/usecases/is_a_teacher.dart';
import 'package:mentormeister/features/Onboarding&Authentication/domain/usecases/sign_in.dart';
import 'package:mentormeister/features/Onboarding&Authentication/domain/usecases/sign_up.dart';
import 'package:mentormeister/features/Onboarding&Authentication/domain/usecases/update_user.dart';
import 'package:mentormeister/features/Onboarding&Authentication/presentation/app/ask_page_cubit/ask_page_cubit.dart';
import 'package:mentormeister/features/Onboarding&Authentication/presentation/app/authentication_bloc/authentication_bloc.dart';
import 'package:mentormeister/features/Onboarding&Authentication/presentation/app/on_boarding_cubit/on_boarding_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _onBoardingInit();
  await _authenticationInit();
  await _askPageInit();
}

Future<void> _onBoardingInit() async {
  final prefs = await SharedPreferences.getInstance();
  sl

    // App Logic
    ..registerFactory(
      () => OnBoardingCubit(
        cacheFirstTimer: sl(),
        checkIfUserIsFirstTimer: sl(),
      ),
    )

    // Usecases
    ..registerLazySingleton(
      () => CacheFirstTimer(
        sl(),
      ),
    )
    ..registerLazySingleton(
      () => CheckIfUserIsFirstTimer(
        sl(),
      ),
    )

    // Repositories
    ..registerLazySingleton<OnBoardingRepository>(
      () => OnBoardingRepositoryImplementation(
        sl(),
      ),
    )

    // Datasources
    ..registerLazySingleton<OnBoardingLocalDataSource>(
      () => OnBoardingLocalDataSourceImplementation(
        sl(),
      ),
    )

    // External dependencies
    ..registerLazySingleton(
      () => prefs,
    );
}

Future<void> _authenticationInit() async {
  sl

    // App Logic
    ..registerFactory(
      () => AuthenticationBloc(
        signIn: sl(),
        signUp: sl(),
        forgotPassword: sl(),
        updateUser: sl(),
      ),
    )

    // Usecases
    ..registerLazySingleton(
      () => SignIn(
        sl(),
      ),
    )
    ..registerLazySingleton(
      () => SignUp(
        sl(),
      ),
    )
    ..registerLazySingleton(
      () => ForgotPassword(
        sl(),
      ),
    )
    ..registerLazySingleton(
      () => UpdateUser(
        sl(),
      ),
    )

    // Repositories
    ..registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImplementation(
        sl(),
      ),
    )

    // Datasources
    ..registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSourceImplementation(
        authClient: sl(),
        cloudStoreClient: sl(),
        dbClient: sl(),
      ),
    )

    // External dependencies
    ..registerLazySingleton(
      () => FirebaseAuth.instance,
    )
    ..registerLazySingleton(
      () => FirebaseFirestore.instance,
    )
    ..registerLazySingleton(
      () => FirebaseStorage.instance,
    );
}

Future<void> _askPageInit() async {
  sl
    ..registerFactory(
      () => AskPageCubit(
        isAStudent: sl(),
        isATeacher: sl(),
        checkIfUserIsAStudent: sl(),
        checkIfUserIsATeacher: sl(),
      ),
    )
    ..registerLazySingleton(
      () => IsAStudent(
        sl(),
      ),
    )
    ..registerLazySingleton(
      () => IsATeacher(
        sl(),
      ),
    )
    ..registerLazySingleton(
      () => CheckIfUserIsAStudent(
        sl(),
      ),
    )
    ..registerLazySingleton(
      () => CheckIfUserIsATeacher(
        sl(),
      ),
    )
    ..registerLazySingleton<AskPageRepository>(
      () => AskPageRepositoryImplementation(
        sl(),
      ),
    )
    ..registerLazySingleton<AskPageLocaleDataSource>(
      () => AskPageLocaleDataSourceImplementation(
        sl(),
      ),
    );
}
