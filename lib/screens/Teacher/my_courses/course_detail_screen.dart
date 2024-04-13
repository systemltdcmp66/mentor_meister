import 'package:mentormeister/screens/Teacher/my_courses/quizes.dart';
import 'package:mentormeister/utils/basic_screen_imports.dart';

import 'assignments.dart';
import 'lessons.dart';

class CourseDetailScreen extends StatefulWidget {
  const CourseDetailScreen({super.key});

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_updateButtonVisibility);
  }

  @override
  void dispose() {
    _tabController.removeListener(_updateButtonVisibility);
    _tabController.dispose();
    super.dispose();
  }

  void _updateButtonVisibility() {
    setState(() {}); // Rebuild the widget tree when the tab controller index changes
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primaryBGColor,
      body:  Column(
      mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min, // Set mainAxisSize to min
        children: [
          SizedBox(height: 65.h,),
        Align(
          alignment: Alignment.topCenter,
          child: TabBar(
            indicator: null,
            padding: EdgeInsets.zero,
            labelPadding: EdgeInsets.only(left: 8.r, right: 8.r),
            indicatorColor: Colors.transparent,
            isScrollable: true,
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.black,
            labelStyle: CustomStyle.interh2,
            controller: _tabController,
            dividerColor: Colors.transparent,
            tabs: const [
              Tab(text: 'Lessons',),
              Tab(text: 'Quizzes',),
              Tab(text: 'Assignments',),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height*0.5,
          child: TabBarView(
            controller: _tabController,
            children: const [
              LessonsPage(),
              QuizzesPage(),
              AssignmentsPage(),
            ],
          ),
        ),
        SizedBox(height: Dimensions.heightSize),
      ],
          ),
    );
  }
}
