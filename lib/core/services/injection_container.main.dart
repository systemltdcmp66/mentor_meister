part of 'injection_container.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _onBoardingInit();
  await _authenticationInit();
  await _askPageInit();
  await _teacherSignUpInit();
  await _courseInit();
  await _assignmentInit();
}

Future<void> _assignmentInit() async {
  sl
    ..registerFactory(
      () => AssignmentCubit(
        createAssignment: sl(),
        getAssignments: sl(),
      ),
    )
    ..registerLazySingleton(
      () => CreateAssignment(
        sl(),
      ),
    )
    ..registerLazySingleton(
      () => GetAssignments(
        sl(),
      ),
    )
    ..registerLazySingleton<AssignmentRepository>(
      () => AssignmentRepositoryImpl(
        sl(),
      ),
    )
    ..registerLazySingleton<AssignmentRemoteDataSrc>(
      () => AssignmentRemoteDataSrcImpl(
        auth: sl(),
        firestore: sl(),
        storage: sl(),
      ),
    );
}

Future<void> _courseInit() async {
  sl
    ..registerFactory(
      () => CourseCubit(
        createCourse: sl(),
        getCourses: sl(),
      ),
    )
    ..registerLazySingleton(
      () => CreateCourse(
        sl(),
      ),
    )
    ..registerLazySingleton(
      () => GetCourses(
        sl(),
      ),
    )
    ..registerLazySingleton<CourseRepository>(
      () => CourseRepositoryImpl(
        sl(),
      ),
    )
    ..registerLazySingleton<CourseRemoteDataSrc>(
      () => CourseRemoteDataSrcImpl(
        auth: sl(),
        firestore: sl(),
        storage: sl(),
      ),
    );
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

Future<void> _teacherSignUpInit() async {
  sl
    ..registerFactory(
      () => TeacherSignUpCubit(
        postTeacherInformations: sl(),
        getTeacherInformations: sl(),
      ),
    )
    ..registerLazySingleton(
      () => PostTeacherInformations(
        sl(),
      ),
    )
    ..registerLazySingleton(
      () => GetTeacherInformations(
        sl(),
      ),
    )
    ..registerLazySingleton<TeacherSignUpRepository>(
      () => TeacherSignUpRepoImpl(
        sl(),
      ),
    )
    ..registerLazySingleton<TeacherSignUpRemoteDataSrc>(
      () => TeacherSignUpRemoteDataSrcImpl(
        auth: sl(),
        firestore: sl(),
        storage: sl(),
      ),
    );
}
