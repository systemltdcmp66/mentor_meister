import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentormeister/commons/widgets/no_found_text.dart';
import 'package:mentormeister/core/utils/core_utils.dart';
import 'package:mentormeister/features/Teacher/data/models/course_model.dart';
import 'package:mentormeister/features/Teacher/my_courses/course_detail_screen.dart';
import 'package:mentormeister/features/Teacher/my_courses/custom_app_bar.dart';
import 'package:mentormeister/features/Teacher/presentation/app/course_cubit/course_cubit.dart';
import 'package:mentormeister/features/Teacher/presentation/app/course_cubit/course_state.dart';
import 'package:mentormeister/core/utils/basic_screen_imports.dart';

class StudentCoursesScreen extends StatefulWidget {
  const StudentCoursesScreen({
    required this.isStudent,
    super.key,
  });

  final bool isStudent;

  @override
  State<StudentCoursesScreen> createState() => _StudentCoursesScreenState();

  static const routeName = 'my-courses';
}

class _StudentCoursesScreenState extends State<StudentCoursesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CourseCubit>().getEnrolledCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWithPop(
        text: 'My Courses',
      ),
      backgroundColor: CustomColor.primaryBGColor,
      body: BlocConsumer<CourseCubit, CourseState>(
        listener: (_, state) {
          if (state is GettinngEnrolledCoursedError) {
            CoreUtils.showSnackar(
              context: context,
              message: 'Error getting the courses',
            );
          }
        },
        builder: (context, state) {
          if (state is GettingEnrolledCourses) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(CustomColor.redColor),
              ),
            );
          } else if (state is EnrolledCoursesFetched &&
              state.enrolledCourses.isEmpty) {
            return const NoFoundtext(
              'No courses.Please enroll to a course first',
            );
          } else if (state is EnrolledCoursesFetched &&
              state.enrolledCourses.isNotEmpty) {
            return Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: state.enrolledCourses.length,
                        itemBuilder: (context, index) {
                          return _buildCourseCard(
                            state.enrolledCourses[index] as CourseModel,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildCourseCard(CourseModel courseModel) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.all(10),
      child: Container(
        height: 100.h,
        alignment: Alignment.center,
        child: ListTile(
          leading: Container(
            width: 55.w,
            height: 55.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.r)),
              image: DecorationImage(
                image: courseModel.image!
                        .contains('assets/defaults/default_course.png')
                    ? const AssetImage('assets/defaults/default_course.png')
                    : NetworkImage(courseModel.image!) as ImageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            courseModel.title,
            style: CustomStyle.hintTextStyle,
          ),
          subtitle: Text(
            courseModel.type,
            style: CustomStyle.hintTextStyle,
          ),
          trailing: !widget.isStudent
              ? ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      CourseDetailScreen.routeName,
                      arguments: courseModel,
                    );
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  child: Text(
                    'Show Content',
                    style: CustomStyle.pBStyle,
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}
