import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentormeister/commons/app/providers/user_provider.dart';
import 'package:mentormeister/commons/views/page_under_construction.dart';
import 'package:mentormeister/core/services/injection_container.dart';
import 'package:mentormeister/core/utils/basic_screen_imports.dart';
import 'package:mentormeister/features/Onboarding&Authentication/data/datasources/ask_page_locale_data_source.dart';
import 'package:mentormeister/features/Onboarding&Authentication/data/datasources/on_boarding_local_data_source.dart';
import 'package:mentormeister/features/Onboarding&Authentication/data/models/user_model.dart';
import 'package:mentormeister/features/Onboarding&Authentication/presentation/app/ask_page_cubit/ask_page_cubit.dart';
import 'package:mentormeister/features/Onboarding&Authentication/presentation/app/authentication_bloc/authentication_bloc.dart';
import 'package:mentormeister/features/Onboarding&Authentication/presentation/app/on_boarding_cubit/on_boarding_cubit.dart';
import 'package:mentormeister/features/Onboarding&Authentication/presentation/views/create_account.dart';
import 'package:mentormeister/features/Onboarding&Authentication/presentation/views/login.dart';
import 'package:mentormeister/features/Onboarding&Authentication/presentation/views/onboarding_screen.dart';
import 'package:mentormeister/features/Onboarding&Authentication/presentation/widgets/ask_page.dart';
import 'package:mentormeister/features/Teacher/bottom_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
            bool isTeacher = prefs.getBool(kIsATeacher) ?? false;
            bool isStudent = prefs.getBool(kIsAStudent) ?? false;

            if (isStudent == false && isTeacher == false) {
              return BlocProvider(
                create: (_) => sl<AskPageCubit>(),
                child: const AskPage(),
              );
            } else if (isStudent && isTeacher == false) {
              return BottomNavBar(isStudent: isStudent);
            } else if (isTeacher && isStudent == false) {
              return BottomNavBar(isStudent: isStudent);
            }
          }
          return BlocProvider(
            create: (_) => sl<AuthenticationBloc>(),
            child: const LoginPage(),
          );
        },
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
