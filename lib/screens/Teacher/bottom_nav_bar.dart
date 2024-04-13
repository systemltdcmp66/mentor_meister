import 'package:mentormeister/screens/Teacher/messages_screen.dart';
import 'package:mentormeister/screens/Teacher/teacher_home_page.dart';
import 'package:mentormeister/utils/basic_screen_imports.dart';

import '../../widget/LiveSession.dart';
import '../Student/course_enrollment.dart';
import '../Student/student_home_page.dart';
import '../Student/teachers.dart';
import 'live_session.dart';
import 'my_account.dart';
import 'my_courses/my_courses.dart';

class TeacherNavBar extends StatefulWidget {
  final bool isStudent;

  const TeacherNavBar({Key? key, required this.isStudent}) : super(key: key);

  @override
  _TeacherNavBarState createState() => _TeacherNavBarState();
}

class _TeacherNavBarState extends State<TeacherNavBar> {
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
      const TeacherHomePage(),
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
            label: widget.isStudent? 'Teachers': 'Live Session',
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
