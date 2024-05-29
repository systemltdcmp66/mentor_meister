part of 'router.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case OnboardingScreen.routeName:
      final prefs = sl<SharedPreferences>();
      return _pageBuilder(
        (context) {
          if (prefs.getBool(kFirstTimer) ?? true) {
            return BlocProvider(
              create: (_) => sl<OnBoardingCubit>(),
              child: const OnboardingScreen(),
            );
          } else if (sl<FirebaseAuth>().currentUser != null) {
            final user = sl<FirebaseAuth>().currentUser!;
            final localeUser = LocalUserModel(
              uid: user.uid,
              name: user.displayName ?? '',
              email: user.email ?? '',
              phoneNumber: user.phoneNumber ?? '',
            );
            context.read<UserProvider>().initUser(localeUser);

            return BlocProvider(
              create: (_) => sl<AskPageCubit>(),
              child: const AskPage(),
            );
          }
          return BlocProvider(
            create: (_) => sl<AuthenticationBloc>(),
            child: const LoginPage(),
          );
        },
        settings: settings,
      );

    case HiringPaymentPage.routeName:
      return _pageBuilder(
        (context) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => sl<PaymentCubit>(),
            ),
            BlocProvider(
              create: (_) => sl<TeacherSignUpCubit>(),
            ),
          ],
          child: HiringPaymentPage(
            hiringModel: settings.arguments as HiringModel,
          ),
        ),
        settings: settings,
      );

    case CourseDetailStudent.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<AssignmentCubit>(),
          child: CourseDetailStudent(
            courseModel: settings.arguments as CourseModel,
          ),
        ),
        settings: settings,
      );

    case ChatPage.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<MessageBloc>(),
          child: ChatPage(
            chatData: settings.arguments as Map<String, dynamic>,
          ),
        ),
        settings: settings,
      );

    case PhotoView.routeName:
      return _pageBuilder(
        (_) => PhotoView(
          arguments: settings.arguments as DataMap,
        ),
        settings: settings,
      );

    case RateUs.routeName:
      return _pageBuilder(
        (context) => BlocProvider(
          create: (_) => sl<FeedbackCubit>(),
          child: const RateUs(),
        ),
        settings: settings,
      );

    case MsgTeacher.routeName:
      return _pageBuilder(
        (_) => MsgTeacher(
          teacherInfoModel: settings.arguments as TeacherInfoModel,
        ),
        settings: settings,
      );

    case SubscriptionPaymentPage.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<PaymentCubit>(),
          child: SubscriptionPaymentPage(
            subscription: settings.arguments as SubscriptionModel,
          ),
        ),
        settings: settings,
      );

    case CoursePaymentPage.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<PaymentCubit>(),
          child: CoursePaymentPage(
            coursePaymentModel: settings.arguments as CoursePaymentModel,
          ),
        ),
        settings: settings,
      );

    case BottomNavBar.routeName:
      return _pageBuilder(
        (_) => BottomNavBar(
          isStudent: settings.arguments as bool,
        ),
        settings: settings,
      );

    case PaymentSuccessPage.routeName:
      return _pageBuilder(
        (_) => PaymentSuccessPage(
          isCoursePayment: settings.arguments as bool,
        ),
        settings: settings,
      );

    case HiringPaymentSuccessPage.routeName:
      return _pageBuilder(
        (_) => const HiringPaymentSuccessPage(),
        settings: settings,
      );

    case CourseEnrollment.routeName:
      return _pageBuilder(
        (_) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => sl<CourseCubit>(),
            ),
            BlocProvider(
              create: (_) => sl<AssignmentCubit>(),
            ),
          ],
          child: CourseEnrollment(
            courseModel: settings.arguments as CourseModel,
          ),
        ),
        settings: settings,
      );
    // case EnrolledCoursesScreen.routeName:
    //   return _pageBuilder(
    //     (_) => BlocProvider(
    //       create: (_) => sl<AssignmentCubit>(),
    //       child: EnrolledCoursesScreen(
    //         courseModel: settings.arguments as CourseModel,
    //       ),
    //     ),
    //     settings: settings
    //   );

    case CourseDetailScreen.routeName:
      return _pageBuilder(
        (_) => CourseDetailScreen(
          courseModel: settings.arguments as CourseModel,
        ),
        settings: settings,
      );

    // case MyCoursesScreen.routeName:
    //   return _pageBuilder(
    //     (_) => const MyCoursesScreen(),
    //     settings: settings,
    //   );

    case TutorSignUp.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<TeacherSignUpCubit>(),
          child: const TutorSignUp(),
        ),
        settings: settings,
      );

    case LoginPage.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<AuthenticationBloc>(),
          child: const LoginPage(),
        ),
        settings: settings,
      );
    case SignupPage.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<AuthenticationBloc>(),
          child: const SignupPage(),
        ),
        settings: settings,
      );
    case AskPage.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<AskPageCubit>(),
          child: const AskPage(),
        ),
        settings: settings,
      );
    case BottomNavBar.routeName:
      return _pageBuilder(
        (_) => BottomNavBar(
          isStudent: settings.arguments as bool,
        ),
        settings: settings,
      );
    // case ForgotPasswordScreen.routeName:
    //   return _pageBuilder(
    //     (_) => const ForgotPasswordScreen(),
    //     settings: settings,
    //   );

    case CreateCourseScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<CourseCubit>(),
          child: const CreateCourseScreen(),
        ),
        settings: settings,
      );
    case CreateAssignmentScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<AssignmentCubit>(),
          child: const CreateAssignmentScreen(),
        ),
        settings: settings,
      );
    default:
      return _pageBuilder(
        (_) => const PageUnderConstruction(),
        settings: settings,
      );
  }
}

PageRouteBuilder<dynamic> _pageBuilder(
  Widget Function(BuildContext context) page, {
  required RouteSettings settings,
}) {
  return PageRouteBuilder(
    pageBuilder: (context, _, __) => page(context),
    transitionsBuilder: (context, animation, _, child) => FadeTransition(
      opacity: animation,
      child: child,
    ),
    settings: settings,
  );
}
