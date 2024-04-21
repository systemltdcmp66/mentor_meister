import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentormeister/core/services/injection_container.dart';
import 'package:mentormeister/features/Teacher/presentation/app/course_cubit/course_cubit.dart';
import 'package:mentormeister/features/Teacher/presentation/views/messages_screen.dart';
import 'package:mentormeister/features/Teacher/presentation/views/teacher_home_page.dart';
import 'package:mentormeister/core/utils/basic_screen_imports.dart';

import '../../../../commons/widgets/LiveSession.dart';
import '../../../Student/course_enrollment.dart';
import '../../../Student/student_home_page.dart';
import '../../../Student/teachers.dart';
import '../views/live_session.dart';
import '../views/my_account.dart';
import '../../my_courses/my_courses.dart';

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
            const StudentHomePage(),
            const MsgScreen(),
            const TeachersPage(),
            const CourseEnrollment(),
            const MyAccountScreen(),
          ]
        : [
            BlocProvider(
              create: (_) => sl<CourseCubit>(),
              child: const TeacherHomePage(),
            ),
            const MsgScreen(),
            const LiveSessionPage(),
            const MyCoursesScreen(),
            const MyAccountScreen(),
          ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: pageOptions[selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              widget.isStudent ? CustomIcon.home_2 : CustomIcon.home_2,
              size: 24,
            ),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(CustomIcon.document_text, size: 24),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              widget.isStudent ? Icons.people_sharp : CustomIcon.video,
              size: 24,
            ),
            label: widget.isStudent ? 'Teachers' : 'Live Session',
          ),
          const BottomNavigationBarItem(
            icon: Icon(CustomIcon.frame, size: 24),
            label: 'My Courses',
          ),
          const BottomNavigationBarItem(
            icon: CircleAvatar(
              foregroundImage: AssetImage('assets/teacher/person.png'),
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
