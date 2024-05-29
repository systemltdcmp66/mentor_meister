import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentormeister/commons/app/providers/teacher_provider.dart';
import 'package:mentormeister/features/Student/quiz_page_student.dart';
import 'package:mentormeister/core/utils/basic_screen_imports.dart';
import 'package:mentormeister/features/Teacher/data/models/assignment_model.dart';
import 'package:mentormeister/features/Teacher/data/models/course_model.dart';
import 'package:mentormeister/features/Teacher/presentation/app/assignment_cubit/assignment_cubit.dart';
import 'package:mentormeister/features/Teacher/presentation/app/assignment_cubit/assignment_state.dart';
import '../../commons/widgets/custom_appbar.dart';
import 'assignment_page_stu.dart';
import 'lesson_page_stu.dart';

class CourseDetailStudent extends StatefulWidget {
  final CourseModel courseModel;
  const CourseDetailStudent({
    required this.courseModel,
    Key? key,
  }) : super(key: key);

  @override
  State<CourseDetailStudent> createState() => _CourseDetailStudentState();

  static const routeName = 'course-details';
}

class _CourseDetailStudentState extends State<CourseDetailStudent>
    with SingleTickerProviderStateMixin {
  var numberOfAssignments = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_updateButtonVisibility);
    context.read<TeacherProvider>().getTeacherName(widget.courseModel.userId);
    context.read<AssignmentCubit>().getAssignments();
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
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.15),
        child: Center(
          child: CustomAppBar(
            title: 'Course Details',
            centerTitle: true,
            onBookmarkPressed: () {},
            icon: Icons.favorite_border,
          ),
        ),
      ),
      body: BlocConsumer<AssignmentCubit, AssignmentState>(
        listener: (_, state) {
          if (state is AssignmentsFetched) {
            for (AssignmentModel assignmentModel
                in state.assignments as List<AssignmentModel>) {
              if (widget.courseModel.id == assignmentModel.courseId) {
                numberOfAssignments += 1;
              }
            }
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(Dimensions.paddingSize),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.read<TeacherProvider>().teacherName ?? '',
                    style: CustomStyle.interh3,
                  ),
                  SizedBox(height: Dimensions.heightSize),
                  Card(
                    child: widget.courseModel.image!
                            .contains('assets/defaults/default_course.png')
                        ? Image.asset(
                            'assets/defaults/default_course.png',
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            widget.courseModel.image!,
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                          ),
                  ),
                  SizedBox(height: Dimensions.heightSize),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.courseModel.title,
                        style: CustomStyle.interh2,
                      ),
                      Text(
                        '\$${widget.courseModel.price}',
                        style: CustomStyle.fpStyle,
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.heightSize),
                  Text(
                    widget.courseModel.type,
                    style: CustomStyle.pStyle,
                  ),
                  SizedBox(height: Dimensions.heightSize),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildIconWithText(Icons.menu_book, '9 weeks'),
                      _buildIconWithText(Icons.chat, '6 quizzes'),
                      _buildIconWithText(
                        Icons.file_copy_sharp,
                        numberOfAssignments <= 1
                            ? '${numberOfAssignments.toString()} assignment'
                            : '${numberOfAssignments.toString()} assignments',
                      ),
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
                        LessonsPageStudent(),
                        QuizzesPageStudent(),
                        AssignmentsPageStudent(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
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
