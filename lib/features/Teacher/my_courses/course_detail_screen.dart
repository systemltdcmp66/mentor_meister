import 'package:mentormeister/features/Contact/presentation/widgets/pop_app_bar.dart';
import 'package:mentormeister/features/Teacher/data/models/course_model.dart';
import 'package:mentormeister/features/Teacher/my_courses/quizes.dart';
import 'package:mentormeister/core/utils/basic_screen_imports.dart';
import 'assignments.dart';
import 'lessons.dart';

class CourseDetailScreen extends StatefulWidget {
  const CourseDetailScreen({
    required this.courseModel,
    super.key,
  });

  final CourseModel courseModel;

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();

  static const routeName = 'course-detail';
}

class _CourseDetailScreenState extends State<CourseDetailScreen>
    with SingleTickerProviderStateMixin {
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
    setState(
        () {}); // Rebuild the widget tree when the tab controller index changes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primaryBGColor,
      appBar: const AppBarWithPop(
        text: 'Course Detail',
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min, // Set mainAxisSize to min
        children: [
          Card(
            elevation: 0,
            child: Padding(
              padding: EdgeInsets.all(Dimensions.paddingSize),
              child: Row(
                children: [
                  Container(
                    width: 55.w,
                    height: 55.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: widget.courseModel.image!
                                .contains('assets/defaults/default_course.png')
                            ? const AssetImage(
                                'assets/defaults/default_course.png')
                            : NetworkImage(widget.courseModel.image!)
                                as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: Dimensions.widthSize),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.courseModel.title,
                          style: CustomStyle.interh2,
                        ),
                        const SizedBox(height: 4),
                        widget.courseModel.numberOfAssignments <= 1
                            ? Text(
                                '15 Lessons | ${widget.courseModel.numberOfAssignments} Assignment | 5 Quizzes',
                                style: CustomStyle.fpStyle,
                              )
                            : Text(
                                '15 Lessons | ${widget.courseModel.numberOfAssignments} Assignments | 5 Quizzes',
                                style: CustomStyle.fpStyle,
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
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
                Tab(
                  text: 'Lessons',
                ),
                Tab(
                  text: 'Quizzes',
                ),
                Tab(
                  text: 'Assignments',
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
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
