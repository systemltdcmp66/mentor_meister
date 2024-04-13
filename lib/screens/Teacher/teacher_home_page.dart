import 'package:mentormeister/screens/Teacher/create_assignment.dart';
import 'package:mentormeister/screens/Teacher/create_course.dart';
import 'package:mentormeister/screens/Teacher/create_quiz.dart';
import 'package:mentormeister/utils/basic_screen_imports.dart';
import '../../models/upcoming_session_model.dart';
import '../../models/video_cardmodel.dart';

class TeacherHomePage extends StatelessWidget {
  const TeacherHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomColor.primaryBGColor,
      body: Column(
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
                  DropdownButton<String>(

                    value: '\$30.00 USD',
                    style: TextStyle(
                      fontSize: 12.sp,
                    ),// Default value
                    items: <String>[
                      '\$30.00 USD',
                      '\$40.00 USD',
                      '\$50.00 USD'
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: const TextStyle(color: CustomColor.redColor),),
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
                      ),// Default value
                      items: <String>[
                        'English',
                        'Urdu',
                        'French'
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: const TextStyle(color: Colors.grey),),
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
            padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeHorizontalSize),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My Courses',
                  style: CustomStyle.blackh1,
                ),
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
              itemCount: videoCards.length,
              itemBuilder: (BuildContext context, int index) {
                return buildVideoCard(videoCards[index]);
              },
            ),
          ),
          // Recent courses
          Padding(
            padding: EdgeInsets.all(Dimensions.paddingSizeHorizontalSize),
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
                  
                      Text('Create Task', style: CustomStyle.blackh1,),
                      Text('Please Select Your Task', style: CustomStyle.hintStyle,),
                  
                      ListTile(
                        leading: buildContainer(Icons.mode_edit_sharp ),
                        title: const Text('Create Course'),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const CreateCourseScreen()));
                        },
                      ),
                      ListTile(
                        leading: buildContainer(Icons.add_box ),
                        title: const Text('Create Assignment'),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const CreateAssignmentScreen()));
                        },
                      ),
                      ListTile(
                        leading: buildContainer(Icons.edit ),
                        title: const Text('Create Quiz'),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const CreateQuizScreen()));
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
        child: const Icon(Icons.add, color: Colors.white), // Set the shape to CircleBorder
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
                'Jane Cooper',
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
                          child: Icon(icon,color: CustomColor.redColor,), );
  }

  Widget buildVideoCard(VideoCard videoCard) {
    return SizedBox(
      height: 100.h,
      width: 200.h,
      child: Card(
        elevation: 0,
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              videoCard.imageUrl,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Text(
              videoCard.title,
              style: CustomStyle.tabStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              videoCard.subtitle,
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
                  videoCard.rating,
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
                  '${videoCard.numberOfStudents}',
                  style: TextStyle(
                    fontFamily: "inter",
                    fontSize: 12.sp,
                    color: Colors.grey,
                  ),
                ),
                Expanded(
                  child: Text(
                    videoCard.price,
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
                  backgroundImage: AssetImage('assets/teacher/person.png'), // Placeholder image
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
                          return const Color(0xffFCDDDD); // Light red by default
                        }
                        return const Color(0xffFCDDDD); // Light red by default
                      },
                    ),
                  ),
                  child: const Text('Pending', style: TextStyle(color: CustomColor.redColor),),
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
                  style: const TextStyle(color: Colors.red), // Red color for text
                ),
                Text(
                  ' ${session.duration}',
                  style: const TextStyle(color: Colors.red), // Red color for text
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
