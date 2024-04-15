import 'package:mentormeister/features/Student/student_enrolled_courses.dart';
import 'package:mentormeister/core/utils/basic_screen_imports.dart';
import 'package:mentormeister/commons/widgets/custom_button.dart';
import '../../commons/widgets/custom_appbar.dart';

class CourseEnrollment extends StatefulWidget {
  const CourseEnrollment({Key? key}) : super(key: key);

  @override
  State<CourseEnrollment> createState() => _CourseEnrollmentState();
}

class _CourseEnrollmentState extends State<CourseEnrollment> {
  bool isEnrolled = false;
  @override
  Widget build(BuildContext context) {
    if (isEnrolled) {
      return const EnrolledCoursesScreen();
    }
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.15),
        child: Center(
          child: CustomAppBar(
              title: 'Create Details',
              centerTitle: true,
              onBookmarkPressed: () {},
              icon: Icons.favorite_border),
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
              Image.asset(
                'assets/teacher/c1.png',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.3,
                fit: BoxFit.cover,
              ),
              SizedBox(height: Dimensions.heightSize),
              Row(
                mainAxisAlignment: mainSpaceBet,
                children: [
                  Text(
                    'React.js from scratch',
                    style: CustomStyle.p2Style,
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
              Center(
                child: SizedBox(
                    width: 150.w,
                    child: CustomButton(
                        text: 'Enroll',
                        onPressed: () {
                          setState(() {
                            isEnrolled = true;
                          });
                        })),
              )
            ],
          ),
        ),
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
