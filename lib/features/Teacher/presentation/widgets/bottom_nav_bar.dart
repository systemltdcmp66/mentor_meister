import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:mentormeister/commons/app/providers/user_provider.dart';
import 'package:mentormeister/core/services/injection_container.dart';
import 'package:mentormeister/features/Contact/presentation/views/contact_page.dart';
import 'package:mentormeister/features/Onboarding&Authentication/presentation/app/authentication_bloc/authentication_bloc.dart';
import 'package:mentormeister/features/Subscription/presentation/cubit/subscription_cubit.dart';
import 'package:mentormeister/features/Teacher/my_courses/teacher_courses.dart';
import 'package:mentormeister/features/Teacher/presentation/app/course_cubit/course_cubit.dart';
import 'package:mentormeister/features/Teacher/presentation/app/feedback_cubit/feedback_state.dart';
import 'package:mentormeister/features/Teacher/presentation/app/teacher_sign_up_cubit/teacher_sign_up_cubit.dart';
import 'package:mentormeister/features/Teacher/presentation/views/messages_screen.dart';
import 'package:mentormeister/features/Teacher/presentation/views/teacher_home_page.dart';
import 'package:mentormeister/core/utils/basic_screen_imports.dart';
import '../../../../commons/widgets/LiveSession.dart';
import '../../../Student/student_home_page.dart';
import '../../../Student/teachers.dart';
import '../views/live_session.dart';
import '../views/my_account.dart';
import '../../my_courses/student_courses.dart';

class BottomNavBar extends StatefulWidget {
  final bool isStudent;

  const BottomNavBar({Key? key, required this.isStudent}) : super(key: key);

  static const routeName = '/dashboard';

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pageOptions = widget.isStudent
        ? [
            BlocProvider(
              create: (_) => sl<CourseCubit>(),
              child: const StudentHomePage(),
            ),
            BlocProvider(
              create: (_) => sl<AuthenticationBloc>(),
              child: const ContactPage(),
            ),
            const MsgScreen(),
            BlocProvider(
              create: (_) => sl<TeacherSignUpCubit>(),
              child: const TeachersPage(),
            ),
            BlocProvider(
              create: (_) => sl<CourseCubit>(),
              child: StudentCoursesScreen(
                isStudent: widget.isStudent,
              ),
            ),
            MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (_) => sl<FeedbackCubit>(),
                ),
                BlocProvider(
                  create: (_) => sl<SubscriptionCubit>(),
                ),
              ],
              child: MyAccountScreen(
                isStudent: widget.isStudent,
              ),
            ),
          ]
        : [
            MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (_) => sl<SubscriptionCubit>(),
                ),
                BlocProvider(
                  create: (_) => sl<CourseCubit>(),
                ),
              ],
              child: const TeacherHomePage(),
            ),
            BlocProvider(
              create: (_) => sl<AuthenticationBloc>(),
              child: const ContactPage(),
            ),
            const MsgScreen(),
            const LiveSessionPage(),
            BlocProvider(
              create: (_) => sl<TeacherSignUpCubit>(),
              child: TeacherCoursesScreen(
                isStudent: widget.isStudent,
              ),
            ),
            MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (_) => sl<FeedbackCubit>(),
                ),
                BlocProvider(
                  create: (_) => sl<SubscriptionCubit>(),
                ),
              ],
              child: MyAccountScreen(
                isStudent: widget.isStudent,
              ),
            ),
          ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: pageOptions[selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              selectedPage == 0 ? IconlyLight.home : IconlyBold.home,
              size: 24,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              selectedPage == 1 ? IconlyLight.profile : IconlyBold.profile,
              size: 24,
            ),
            label: 'Contacts',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              selectedPage == 2 ? IconlyLight.message : IconlyBold.message,
              size: 24,
            ),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              widget.isStudent
                  ? Icons.people_sharp
                  : (selectedPage == 3 ? IconlyLight.video : IconlyBold.video),
              size: 24,
            ),
            label: widget.isStudent ? 'Teachers' : 'Live Session',
          ),
          const BottomNavigationBarItem(
            icon: Icon(CustomIcon.frame, size: 24),
            label: 'My Courses',
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              foregroundImage:
                  context.read<UserProvider>().user!.profilePic == null
                      ? const AssetImage(
                          'assets/students/default_user.png',
                        ) as ImageProvider
                      : NetworkImage(
                          context.read<UserProvider>().user!.profilePic!,
                        ),
              backgroundColor: Colors.white,
            ),
            label: 'User',
          ),
        ],
        selectedItemColor: CustomColor.redColor,
        elevation: 5.0,
        unselectedItemColor: CustomColor.hintColor,
        currentIndex: selectedPage,
        backgroundColor: Colors.white,
        onTap: (index) {
          setState(() {
            selectedPage = index;
          });
        },
      ),
    );
  }
}
