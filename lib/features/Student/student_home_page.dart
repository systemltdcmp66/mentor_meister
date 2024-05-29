import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentormeister/commons/app/providers/courses_provider.dart';
import 'package:mentormeister/commons/app/providers/user_provider.dart';
import 'package:mentormeister/commons/widgets/no_found_text.dart';
import 'package:mentormeister/core/utils/basic_screen_imports.dart';
import 'package:mentormeister/core/utils/core_utils.dart';
import 'package:mentormeister/features/Student/course_enrollment.dart';
import 'package:mentormeister/features/Teacher/data/models/course_model.dart';
import 'package:mentormeister/features/Teacher/presentation/app/course_cubit/course_cubit.dart';
import 'package:mentormeister/features/Teacher/presentation/app/course_cubit/course_state.dart';
import 'course_detaiil.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({Key? key}) : super(key: key);

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  bool isSearching = false;
  String selectedBalance = '\$30.00 USD'; // Default selected value
  String selectedLanguage = 'English';

  List<CourseModel> filteredVideoCards = [];
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    context.read<UserProvider>().getUserInfo();
    context.read<CourseCubit>().getCourses();
    context.read<CoursesProvider>().getAllCourses();
    filteredVideoCards = context.read<CoursesProvider>().courses ??
        []; // Initially show all video cards
  }

  void filterCourses(String query) {
    setState(() {
      filteredVideoCards = context
          .read<CoursesProvider>()
          .courses!
          .where((courseModel) =>
              courseModel.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
      searchQuery = query; // Update search query
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomColor.primaryBGColor,
      body: BlocConsumer<CourseCubit, CourseState>(
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
          } else if (state is CourseFetched && state.courses.isEmpty) {
            return const NoFoundtext(
              'No courses found\nPlease contact teacher or if you are admin add courses',
            );
          } else if (state is CourseFetched) {
            final courses = state.courses
              ..sort(
                (a, b) => b.updatedAt.compareTo(
                  a.updatedAt,
                ),
              );
            return Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Black container with user's name
                    Container(
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
                            context.read<UserProvider>().userInfo![0].name,
                            style: CustomStyle.whiteh1,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: Dimensions.heightSize),
                    // Card with available balance and language selection
                    ///when user is not searching these widget will shown
                    if (!isSearching) ...[
                      // Row with "My Courses" text and "See All" button
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeHorizontalSize),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'My Courses',
                              style: CustomStyle.blackh2,
                            ),
                            courses.length > 3
                                ? TextButton(
                                    onPressed: () {
                                      // Your logic here
                                    },
                                    child: Text(
                                      'See All',
                                      style: CustomStyle.fpStyle,
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ],
                        ),
                      ),
                      // List of my courses Cards
                      SizedBox(
                        height: 200.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: courses
                              .length, // Use allVideoCards instead of filteredVideoCards
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  CourseEnrollment.routeName,
                                  arguments: courses[index] as CourseModel,
                                );
                              },
                              child: buildVideoCard(
                                courses[index] as CourseModel,
                              ),
                            ); // Use allVideoCards instead of filteredVideoCards
                          },
                        ),
                      ),

                      //recent courses
                      Padding(
                        padding: EdgeInsets.all(
                            Dimensions.paddingSizeHorizontalSize),
                        child: Text(
                          'Recent Courses',
                          style: CustomStyle.blackh2,
                        ),
                      ),
                      // List of recent courses Cards
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          itemCount: courses.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  CourseEnrollment.routeName,
                                  arguments: courses[index] as CourseModel,
                                );
                              },
                              child: buildRecentCoursesCard(
                                  courses[index] as CourseModel),
                            );
                          },
                        ),
                      ),
                    ],

                    ///when user search the  search courses  will be displayed
                    if (isSearching) ...[
                      Padding(
                        padding: EdgeInsets.all(
                          Dimensions.paddingSizeHorizontalSize,
                        ),
                        child: Text(
                          'Searched Courses',
                          style: CustomStyle.blackh2,
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          itemCount: filteredVideoCards.length,
                          itemBuilder: (BuildContext context, int index) {
                            return buildSearchedCourses(
                                filteredVideoCards[index]);
                          },
                        ),
                      ),
                    ]
                  ],
                ),
                Positioned(
                  left: 10,
                  right: 10,
                  top: MediaQuery.of(context).size.height * 0.21,
                  child: Card(
                    elevation: 0,
                    child: Row(
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(left: Dimensions.paddingSize),
                          child: IconButton(
                            icon: Icon(
                              Icons.search,
                              size: Dimensions.iconSizeLarge,
                            ),
                            onPressed: () {
                              setState(() {
                                isSearching = !isSearching;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: Dimensions.widthSize,
                        ),
                        Expanded(
                          child: TextField(
                            onChanged: (value) => filterCourses(value),
                            decoration: InputDecoration(
                              hintText: 'Search',
                              hintStyle: CustomStyle.blackh2,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: Dimensions.paddingSize),
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.filter_list,
                                size: Dimensions.iconSizeLarge,
                              )),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget buildSearchedCourses(CourseModel courseModel) {
    return SizedBox(
      height: 100.h,
      child: Card(
        elevation: 0,
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Leading Image
            Center(
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                ),
                foregroundDecoration: BoxDecoration(
                  image: DecorationImage(
                    image: courseModel.image!
                            .contains('assets/defaults/default_course.png')
                        ? const AssetImage(
                            'assets/defaults/default_course.png',
                          ) as ImageProvider
                        : NetworkImage(courseModel.image!),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),

            SizedBox(width: 8.w), // Adding spacing between image and text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5.h),
                  // Title
                  Text(
                    courseModel.title,
                    style: CustomStyle.tabStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // Subtitle
                  Text(
                    courseModel.type,
                    style: CustomStyle.pStyle,
                  ),
                  // Rating and Number of Students Row

                  SizedBox(height: 8.h),
                  // Amount
                  Text(
                    courseModel.price.toString(),
                    style: CustomStyle.fpStyle,
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            // Enroll Button
            Container(
              padding: EdgeInsets.all(5.r),
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    CourseDetailStudent.routeName,
                    arguments: courseModel,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Text(
                  'Enroll',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Inter",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
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
                  '${courseModel.numberOfStudents}',
                  style: TextStyle(
                    fontFamily: "inter",
                    fontSize: 12.sp,
                    color: Colors.grey,
                  ),
                ),
                Expanded(
                  child: Text(
                    '\$${courseModel.price.toString()}',
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

  Widget buildRecentCoursesCard(CourseModel courseModel) {
    return SizedBox(
      height: 92.h,
      child: Card(
        elevation: 0,
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Leading Image
            courseModel.image!.contains('assets/defaults/default_course.png')
                ? Image.asset(
                    'assets/defaults/default_course.png',
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    courseModel.image!,
                    height: 100,
                    width: 100, //double.infinity,
                    fit: BoxFit.cover,
                  ),
            SizedBox(width: 12.w), // Adding spacing between image and text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5.h,
                  ),
                  // Title
                  Text(
                    courseModel.title,
                    style: CustomStyle.tabStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // Subtitle
                  Text(
                    courseModel.type,
                    style: CustomStyle.fpStyle,
                  ),
                  // Rating and Number of Students Row
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
                      const SizedBox(
                          width:
                              8.0), // Adding spacing between rating and student number
                      Text(
                        '${courseModel.numberOfStudents}',
                        style: TextStyle(
                          fontFamily: "inter",
                          fontSize: 12.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Trailing Price
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.all(12.r),
                child: Text(
                  '\$${courseModel.price.toString()}',
                  style: CustomStyle.fpStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
