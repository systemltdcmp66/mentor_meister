part of 'injection_container.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _onBoardingInit();
  await _authenticationInit();
  await _askPageInit();
  await _teacherSignUpInit();
  await _courseInit();
  await _assignmentInit();
  await _feedbackInit();
  await _messageInit();
  await _coursePaymentInit();
  await _subscriptionInit();
}

Future<void> _subscriptionInit() async {
  sl
    ..registerFactory(
      () => SubscriptionCubit(
        getSubscriptionData: sl(),
      ),
    )
    ..registerLazySingleton(
      () => GetSubscriptionData(
        sl(),
      ),
    )
    ..registerLazySingleton<SubscriptionRepository>(
      () => SubscriptionRepoImpl(
        sl(),
      ),
    )
    ..registerLazySingleton<SubscriptionRemoteDataSrc>(
      () => SubscriptionRemoteDataSrcImpl(
        authClient: sl(),
        cloudStoreClient: sl(),
      ),
    );
}

Future<void> _coursePaymentInit() async {
  sl
    ..registerFactory(
      () => PaymentCubit(
        paypalPayment: sl(),
        makeSubscription: sl(),
        hiringPayment: sl(),
      ),
    )
    ..registerLazySingleton(
      () => PaypalPayment(
        sl(),
      ),
    )
    ..registerLazySingleton(
      () => MakeSubscription(
        sl(),
      ),
    )
    ..registerLazySingleton(
      () => HiringPayment(
        sl(),
      ),
    )
    ..registerLazySingleton<CoursePaymentRepository>(
      () => CoursePaymentRepoImpl(
        sl(),
      ),
    )
    ..registerLazySingleton<CoursePaymentRemoteDataSrc>(
      () => CoursePaymentRemoteDataSrcImpl(
        authClient: sl(),
        cloudStoreClient: sl(),
      ),
    );
}

Future<void> _messageInit() async {
  sl
    ..registerFactory(
      () => MessageBloc(
        sendMessage: sl(),
      ),
    )
    ..registerLazySingleton(
      () => SendMessage(
        sl(),
      ),
    )
    ..registerLazySingleton<MessageRepository>(
      () => MessageRepositoryImplementation(
        sl(),
      ),
    )
    ..registerLazySingleton<MessageRemoteDataSrc>(
      () => MessageRemoteDataSrcImpl(
        auth: sl(),
        firestore: sl(),
        storage: sl(),
      ),
    );
}

Future<void> _feedbackInit() async {
  sl
    ..registerFactory(
      () => FeedbackCubit(
        sendFeedback: sl(),
      ),
    )
    ..registerLazySingleton(
      () => SendFeedback(
        sl(),
      ),
    )
    ..registerLazySingleton<FeedbackRepository>(
      () => FeedbackRepositoryImplementation(
        sl(),
      ),
    )
    ..registerLazySingleton<FeedbackRemoteDataSrc>(
      () => FeedbackRemoteDataSrcImpl(
        auth: sl(),
        firestore: sl(),
      ),
    );
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
        enrollCourse: sl(),
        getEnrolledCourses: sl(),
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
    ..registerLazySingleton(
      () => EnrollCourse(
        sl(),
      ),
    )
    ..registerLazySingleton(
      () => GetEnrolledCourses(
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
        getAllUsers: sl(),
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
    ..registerLazySingleton(
      () => GetAllUsers(
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
        getAllTeacherInformations: sl(),
        hireATeacher: sl(),
        getHiredTeacherInfos: sl(),
        getTeacherUsersData: sl(),
        getTeacherCourses: sl(),
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
    ..registerLazySingleton(
      () => GetAllTeacherInformations(
        sl(),
      ),
    )
    ..registerLazySingleton(
      () => HireATeacher(
        sl(),
      ),
    )
    ..registerLazySingleton(
      () => GetHiredTeacherInfos(
        sl(),
      ),
    )
    ..registerLazySingleton(
      () => GetTeacherUsersData(
        sl(),
      ),
    )
    ..registerLazySingleton(
      () => GetTeacherCourses(
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
