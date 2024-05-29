import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentormeister/commons/app/providers/courses_provider.dart';
import 'package:mentormeister/commons/app/providers/teacher_provider.dart';
import 'package:mentormeister/commons/app/providers/user_provider.dart';
import 'package:mentormeister/core/utils/basic_screen_imports.dart';
import 'package:mentormeister/commons/widgets/custom_button.dart';
import 'package:mentormeister/core/utils/core_utils.dart';
import 'package:mentormeister/features/Student/course_detaiil.dart';
import 'package:mentormeister/features/Teacher/data/models/assignment_model.dart';
import 'package:mentormeister/features/Teacher/data/models/course_model.dart';
import 'package:mentormeister/features/Teacher/presentation/app/assignment_cubit/assignment_cubit.dart';
import 'package:mentormeister/features/Teacher/presentation/app/assignment_cubit/assignment_state.dart';
import 'package:mentormeister/features/Teacher/presentation/app/course_cubit/course_cubit.dart';
import 'package:mentormeister/features/Teacher/presentation/app/course_cubit/course_state.dart';
import 'package:mentormeister/features/payment/data/models/course_payment_model.dart';
import 'package:mentormeister/features/payment/presentation/views/course_payment_page.dart';
import 'package:provider/provider.dart';
import '../../commons/widgets/custom_appbar.dart';

class CourseEnrollment extends StatefulWidget {
  final CourseModel courseModel;
  const CourseEnrollment({
    required this.courseModel,
    Key? key,
  }) : super(key: key);

  @override
  State<CourseEnrollment> createState() => _CourseEnrollmentState();

  static const routeName = '/course-enrollement';
}

class _CourseEnrollmentState extends State<CourseEnrollment> {
  @override
  void initState() {
    super.initState();
    context.read<CourseCubit>().getEnrolledCourses();
    context.read<TeacherProvider>().getTeacherName(widget.courseModel.userId);
    context.read<AssignmentCubit>().getAssignments();
  }

  var numberOfAssignments = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.15),
        child: Center(
          child: CustomAppBar(
            title: 'Create Details',
            centerTitle: true,
            onBookmarkPressed: () {},
            icon: Icons.favorite_border,
          ),
        ),
      ),
      body: Consumer<CoursesProvider>(
        builder: (context, provider, child) {
          return BlocConsumer<CourseCubit, CourseState>(
            listener: (_, state) {
              if (state is CourseError) {
                CoreUtils.showSnackar(
                  context: context,
                  message: 'Course enrollment failed or checking if course'
                      ' has been enrolled or not. Try later',
                );
              } else if (state is CourseEnrolled) {
                Navigator.of(context).pushReplacementNamed(
                  CourseDetailStudent.routeName,
                  arguments: widget.courseModel,
                );
              } else if (state is EnrolledCoursesFetched) {
                final List<CourseModel> enrolledCourses =
                    state.enrolledCourses as List<CourseModel>;

                for (CourseModel courseModel in enrolledCourses) {
                  if (widget.courseModel.id == courseModel.id) {
                    Navigator.of(context).pushReplacementNamed(
                      CourseDetailStudent.routeName,
                      arguments: courseModel,
                    );
                  }
                }
              }
            },
            builder: (context, state) {
              if (state is EnrollingCourse) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(CustomColor.redColor),
                  ),
                );
              } else if (state is GettingEnrolledCourses) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(CustomColor.redColor),
                  ),
                );
              }
              return BlocConsumer<AssignmentCubit, AssignmentState>(
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
                          widget.courseModel.image!.contains(
                                  'assets/defaults/default_course.png')
                              ? Image.asset(
                                  'assets/defaults/default_course.png',
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  widget.courseModel.image!,
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                ),
                          SizedBox(height: Dimensions.heightSize),
                          Row(
                            mainAxisAlignment: mainSpaceBet,
                            children: [
                              Text(
                                widget.courseModel.title,
                                style: CustomStyle.p2Style,
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
                                numberOfAssignments.toString(),
                              ),
                            ],
                          ),
                          Center(
                            child: SizedBox(
                              width: 150.w,
                              child: CustomButton(
                                text: 'Enroll',
                                onPressed: () {
                                  final course = CoursePaymentModel(
                                    customerId: context
                                        .read<UserProvider>()
                                        .userInfo![0]
                                        .uid,
                                    customerEmail: context
                                        .read<UserProvider>()
                                        .userInfo![0]
                                        .email,
                                    paymentId: '',
                                    courseId: widget.courseModel.id,
                                    paymentType: 'Paypal',
                                    courseName: widget.courseModel.title,
                                    courseprice: widget.courseModel.price,
                                    paidAt: DateTime.now(),
                                  );
                                  Navigator.of(context).pushNamed(
                                    CoursePaymentPage.routeName,
                                    arguments: course,
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildIconWithText(IconData iconData, String text) {
    return Card(
      elevation: 0,
      child: Row(
        mainAxisSize: mainMin,
        children: [
          Card(
              elevation: 0,
              color: CustomColor.redColor,
              child: Padding(
                  padding: EdgeInsets.all(4.r),
                  child: Icon(
                    iconData,
                    color: Colors.white,
                    size: 12,
                  ))),
          SizedBox(width: 3.w),
          Text(
            text,
            style: CustomStyle.tabStyle,
          ),
        ],
      ),
    );
  }
}
