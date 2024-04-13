
import 'package:mentormeister/screens/Student/quiz_page_student.dart';
import 'package:mentormeister/utils/basic_screen_imports.dart';
import '../../widget/custom_appbar.dart';
import '../Teacher/my_courses/my_courses.dart';
import 'assignment_page_stu.dart';
import 'lesson_page_stu.dart';

class CourseDetailStudent extends StatefulWidget {
  const CourseDetailStudent({Key? key}) : super(key: key);

  @override
  State<CourseDetailStudent> createState() => _CourseDetailStudentState();
}

class _CourseDetailStudentState extends State<CourseDetailStudent> with SingleTickerProviderStateMixin  {
  bool isEnrolled = false;
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
    if (isEnrolled) {
      return const MyCoursesScreen();
    }


    return Scaffold(
      backgroundColor: CustomColor.primaryBGColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.15),
        child: Center(
          child: CustomAppBar(title: 'Course Details',centerTitle: true, onBookmarkPressed: () {}, icon: Icons.favorite_border),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Dimensions.paddingSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'James',
                style: CustomStyle.interh3,
              ),
              SizedBox(height: Dimensions.heightSize),
              Card(
                child: Image.asset(
                  'assets/teacher/c1.png',
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.3,
                  fit: BoxFit.cover,

                ),
              ),
              SizedBox(height: Dimensions.heightSize),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'React.js from scratch',
                    style: CustomStyle.interh2,
                  ),
                  Text(
                    '\$30',
                    style: CustomStyle.fpStyle,
                  ),
                ],
              ),
              SizedBox(height: Dimensions.heightSize),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                style: CustomStyle.pStyle,
              ),
              SizedBox(height: Dimensions.heightSize),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildIconWithText(Icons.menu_book, '9 weeks'),
                  _buildIconWithText(Icons.chat, '6 quizzes'),
                  _buildIconWithText(Icons.file_copy_sharp, '5 assignments'),
                ],
              ),
              SizedBox(height: Dimensions.heightSize),

              Align(
                alignment: Alignment.topLeft,
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
                    LessonsPageStudent(),
                    QuizzesPageStudent(),
                    AssignmentsPageStudent(),
                  ],
                ),
              ),            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconWithText(IconData iconData, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          elevation: 0,
          color: CustomColor.redColor,
          child: Padding(
            padding: EdgeInsets.all(4.r),
            child: Icon(iconData, color: Colors.white, size: 12),
          ),
        ),
        SizedBox(width: 2.w),
        Text(
          text,
          style: CustomStyle.tabStyle,
        ),
      ],
    );
  }
}
