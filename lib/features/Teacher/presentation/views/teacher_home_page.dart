import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentormeister/commons/app/providers/subscription_provider.dart';
import 'package:mentormeister/commons/app/providers/teacher_provider.dart';
import 'package:mentormeister/commons/widgets/no_found_text.dart';
import 'package:mentormeister/core/services/injection_container.dart';
import 'package:mentormeister/core/utils/core_utils.dart';
import 'package:mentormeister/features/Subscription/presentation/cubit/subscription_cubit.dart';
import 'package:mentormeister/features/Subscription/presentation/cubit/subscription_state.dart';
import 'package:mentormeister/features/Teacher/data/models/course_model.dart';
import 'package:mentormeister/features/Teacher/presentation/app/course_cubit/course_cubit.dart';
import 'package:mentormeister/features/Teacher/presentation/app/course_cubit/course_state.dart';
import 'package:mentormeister/features/Teacher/presentation/widgets/create_assignment.dart';
import 'package:mentormeister/features/Teacher/presentation/widgets/create_course.dart';
import 'package:mentormeister/features/Teacher/presentation/widgets/create_quiz.dart';
import 'package:mentormeister/core/utils/basic_screen_imports.dart';
import 'package:mentormeister/features/payment/data/models/subscription_model.dart';
import '../../../../models/upcoming_session_model.dart';

class TeacherHomePage extends StatefulWidget {
  const TeacherHomePage({Key? key}) : super(key: key);

  @override
  State<TeacherHomePage> createState() => _TeacherHomePageState();
}

class _TeacherHomePageState extends State<TeacherHomePage> {
  @override
  void initState() {
    super.initState();
    context.read<TeacherProvider>().getTeacherInfo();
    if (!context.read<TeacherProvider>().isLoading2) {
      context.read<TeacherProvider>().getTeacherBalances(
            context.read<TeacherProvider>().teacherInfo![0].id,
          );
    }

    context.read<SubscriptionCubit>().getSubscriptionData();

    context.read<CourseCubit>().getCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomColor.primaryBGColor,
      body: BlocListener<SubscriptionCubit, SubscriptionState>(
        listener: (_, state) {
          if (state is SubscriptionError) {
            context.read<SubscriptionCubit>().getSubscriptionData();
          } else if (state is SubscriptionDataFetched &&
              state.subscriptions.isNotEmpty) {
            final data = state.subscriptions as List<SubscriptionModel>;

            for (SubscriptionModel subscriptionModel in data) {
              if (subscriptionModel.teacherId ==
                  context.read<TeacherProvider>().teacherInfo![0].id) {
                context.read<SubscriptionProvider>().isSubscribed = true;
                if (subscriptionModel.type == "free") {
                  context.read<SubscriptionProvider>().package = "Free";
                  context.read<SubscriptionProvider>().price = 0;
                  context.read<SubscriptionProvider>().validTill =
                      subscriptionModel.paidAt.add(
                    const Duration(days: 7),
                  );
                } else if (subscriptionModel.type == "monthly") {
                  context.read<SubscriptionProvider>().package = "Monthly";
                  context.read<SubscriptionProvider>().price = 50;
                  context.read<SubscriptionProvider>().validTill =
                      subscriptionModel.paidAt.add(
                    const Duration(
                      days: 31,
                    ),
                  );
                } else if (subscriptionModel.type == "annual") {
                  context.read<SubscriptionProvider>().package = "Annual";
                  context.read<SubscriptionProvider>().price = 50;
                  context.read<SubscriptionProvider>().validTill =
                      subscriptionModel.paidAt.add(
                    const Duration(
                      days: 365,
                    ),
                  );
                }
              }
            }
          }
        },
        child: BlocConsumer<CourseCubit, CourseState>(
          listener: (_, state) {
            if (state is CourseError) {
              CoreUtils.showSnackar(
                context: context,
                message: state.message,
              );
            }
          },
          builder: (context, state) {
            if (state is GettingCourse) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    CustomColor.redColor,
                  ),
                ),
              );
            } else if (state is CourseFetched &&
                state.courses
                    .where((element) =>
                        element.userId == sl<FirebaseAuth>().currentUser!.uid)
                    .toList()
                    .isEmpty) {
              return const NoFoundtext(
                'No courses found\nPlease contact teacher or if you are admin add courses',
              );
            } else if (state is CourseFetched) {
              final specificTeacherCourses = state.courses
                  .where(
                    (element) =>
                        element.userId == sl<FirebaseAuth>().currentUser!.uid,
                  )
                  .toList();
              final courses = specificTeacherCourses
                ..sort(
                  (a, b) => b.updatedAt.compareTo(
                    a.updatedAt,
                  ),
                );

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Black container with user's name
                  welcomeText(context),

                  SizedBox(height: Dimensions.heightSize),
                  // Card with available balance and language selection
                  Card(
                    elevation: 0,
                    margin: EdgeInsets.all(8.r),
                    child: Padding(
                      padding: EdgeInsets.all(8.r),
                      child: Row(
                        children: [
                          Text(
                            'Available Balance',
                            style: CustomStyle.pBStyle,
                          ),
                          SizedBox(width: 8.w),
                          context
                                  .read<TeacherProvider>()
                                  .teacherBalances
                                  .isEmpty
                              ? const Text(
                                  'No Balance',
                                  style: TextStyle(
                                    color: CustomColor.redColor,
                                  ),
                                )
                              : DropdownButton<String>(
                                  value: context
                                      .read<TeacherProvider>()
                                      .teacherBalances[0],
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                  ), // Default value
                                  items: context
                                      .read<TeacherProvider>()
                                      .teacherBalances
                                      .map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: const TextStyle(
                                          color: CustomColor.redColor,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    // Handle balance dropdown change
                                  },
                                ),
                          SizedBox(width: Dimensions.widthSize),
                          Expanded(
                            child: DropdownButton<String>(
                              value: 'English',
                              style: TextStyle(
                                fontSize: 12.sp,
                              ), // Default value
                              items: <String>['English', 'Urdu', 'French']
                                  .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                // Handle language dropdown change
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Row with "My Courses" text and "See All" button
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeHorizontalSize),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'My Courses',
                          style: CustomStyle.blackh1,
                        ),
                        if (courses.length > 3)
                          TextButton(
                            onPressed: () {
                              // Your logic here
                            },
                            child: Text(
                              'See All',
                              style: CustomStyle.fpStyle,
                            ),
                          ),
                      ],
                    ),
                  ),
                  // List of my courses Cards
                  SizedBox(
                    height: 200.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: courses.length,
                      itemBuilder: (BuildContext context, int index) {
                        return buildVideoCard(
                          courses[index] as CourseModel,
                        );
                      },
                    ),
                  ),
                  // Recent courses
                  Padding(
                    padding:
                        EdgeInsets.all(Dimensions.paddingSizeHorizontalSize),
                    child: Text(
                      'Upcoming Live Sessions',
                      style: CustomStyle.blackh1,
                    ),
                  ),
                  // List of recent courses Cards
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      itemCount: upcomingSessions.length,
                      itemBuilder: (BuildContext context, int index) {
                        return buildLiveSessionCard(upcomingSessions[index]);
                      },
                    ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Open bottom sheet
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            builder: (BuildContext context) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(Dimensions.paddingSizeHorizontalSize),
                  child: Column(
                    mainAxisSize: mainMin,
                    mainAxisAlignment: mainStart,
                    crossAxisAlignment: crossStart,
                    children: [
                      Text(
                        'Create Task',
                        style: CustomStyle.blackh1,
                      ),
                      Text(
                        'Please Select Your Task',
                        style: CustomStyle.hintStyle,
                      ),
                      ListTile(
                        leading: buildContainer(Icons.mode_edit_sharp),
                        title: const Text('Create Course'),
                        onTap: () {
                          if (context.read<SubscriptionProvider>().package ==
                              "Free") {
                            Navigator.of(context).pop();
                            CoreUtils.showSnackar(
                              context: context,
                              message:
                                  'You need to buy the app subscription(monthly or annual) '
                                  'in order to sell courses and make live',
                            );
                          } else {
                            Navigator.of(context).pushNamed(
                              CreateCourseScreen.routeName,
                            );
                          }
                        },
                      ),
                      ListTile(
                        leading: buildContainer(Icons.add_box),
                        title: const Text('Create Assignment'),
                        onTap: () {
                          if (context.read<SubscriptionProvider>().package ==
                              "Free") {
                            Navigator.of(context).pop();
                            CoreUtils.showSnackar(
                              context: context,
                              message:
                                  'You need to buy the app subscription(monthly or annual) '
                                  'in order to sell courses and make live',
                            );
                          } else {
                            Navigator.of(context).pushNamed(
                              CreateAssignmentScreen.routeName,
                            );
                          }
                        },
                      ),
                      ListTile(
                        leading: buildContainer(Icons.edit),
                        title: const Text('Create Quiz'),
                        onTap: () {
                          if (context.read<SubscriptionProvider>().package ==
                              "Free") {
                            Navigator.of(context).pop();
                            CoreUtils.showSnackar(
                              context: context,
                              message:
                                  'You need to buy the app subscription(monthly or annual) '
                                  'in order to sell courses and make live',
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CreateQuizScreen(),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        backgroundColor: Colors.black,
        shape: const CircleBorder(),
        child: const Icon(Icons.add,
            color: Colors.white), // Set the shape to CircleBorder
      ),
    );
  }

  Container welcomeText(BuildContext context) {
    return Container(
      color: Colors.black,
      height: MediaQuery.of(context).size.height * 0.25,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(Dimensions.paddingSize),
      child: Column(
        mainAxisAlignment: mainCenter,
        crossAxisAlignment: crossStart,
        children: [
          Text(
            'Welcome back!',
            style: CustomStyle.whiteh3,
          ),
          Text(
            '${context.watch<TeacherProvider>().teacherInfo![0].firstName} '
            '${context.read<TeacherProvider>().teacherInfo![0].lastName}',
            style: CustomStyle.whiteh1,
          ),
        ],
      ),
    );
  }

  Container buildContainer(IconData icon) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: const Color(0xffffdddd),
        borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius)),
      ),
      child: Icon(
        icon,
        color: CustomColor.redColor,
      ),
    );
  }

  Widget buildVideoCard(CourseModel courseModel) {
    return SizedBox(
      height: 100.h,
      width: 200.h,
      child: Card(
        elevation: 0,
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            courseModel.image!.contains('assets/defaults/default_course.png')
                ? Image.asset(
                    'assets/defaults/default_course.png',
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    courseModel.image!,
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
            const SizedBox(
              height: 10,
            ),
            Text(
              courseModel.title,
              style: CustomStyle.tabStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              courseModel.type,
              style: CustomStyle.fpStyle,
            ),
            const Divider(
              color: CustomColor.greyColor,
              height: 2,
            ),
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: Dimensions.iconSizeDefault,
                ),
                const SizedBox(width: 4.0),
                Text(
                  '4',
                  style: TextStyle(
                    color: CustomColor.blackColor,
                    fontFamily: "Inter",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  '|',
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: "Inter",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  courseModel.numberOfStudents.toString(),
                  style: TextStyle(
                    fontFamily: "inter",
                    fontSize: 12.sp,
                    color: Colors.grey,
                  ),
                ),
                Expanded(
                  child: Text(
                    courseModel.price.toString(),
                    textAlign: TextAlign.right,
                    style: CustomStyle.fpStyle,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLiveSessionCard(UpcomingSession session) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row 1: Image Circle Avatar, Title Name, Subtitle Student, Trailing Pending Button
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage(
                      'assets/teacher/person.png'), // Placeholder image
                  radius: 20,
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      session.studentName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Text('Student'),
                  ],
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    // Handle pending button press
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color(
                              0xffFCDDDD); // Light red by default
                        }
                        return const Color(0xffFCDDDD); // Light red by default
                      },
                    ),
                  ),
                  child: const Text(
                    'Pending',
                    style: TextStyle(color: CustomColor.redColor),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Row 2: Course Title
            Text(
              session.courseTitle,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // Row 3: Clock Icon, Timing, and Duration (red color)
            Row(
              children: [
                const Icon(
                  Icons.schedule,
                  color: Colors.red, // Red color for icon
                ),
                const SizedBox(width: 4),
                Text(
                  session.time,
                  style:
                      const TextStyle(color: Colors.red), // Red color for text
                ),
                Text(
                  ' ${session.duration}',
                  style:
                      const TextStyle(color: Colors.red), // Red color for text
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
