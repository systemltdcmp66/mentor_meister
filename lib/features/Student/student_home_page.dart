import 'package:mentormeister/core/utils/basic_screen_imports.dart';
import '../../models/video_cardmodel.dart';
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
  List<VideoCard> allVideoCards = [
    VideoCard(
      title: 'Learn 3D Modeling',
      subtitle: 'Conception',
      rating: '4.0',
      price: '\$30.00',
      imageUrl: 'assets/teacher/c1.png',
      numberOfStudents: 6000,
    ),
    VideoCard(
      title: 'Learn React.js for Beginners',
      subtitle: 'Programming',
      rating: '4.0',
      price: '\$30.00',
      imageUrl: 'assets/teacher/c2.png',
      numberOfStudents: 6000,
    ),
    // Add more video cards as needed
  ];

  List<VideoCard> filteredVideoCards = [];
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    filteredVideoCards = allVideoCards; // Initially show all video cards
  }

  void filterCourses(String query) {
    setState(() {
      filteredVideoCards = allVideoCards
          .where((videoCard) =>
              videoCard.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
      searchQuery = query; // Update search query
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomColor.primaryBGColor,
      body: Stack(
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
                      'Jane Cooper',
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
                    itemCount: allVideoCards
                        .length, // Use allVideoCards instead of filteredVideoCards
                    itemBuilder: (BuildContext context, int index) {
                      return buildVideoCard(allVideoCards[
                          index]); // Use allVideoCards instead of filteredVideoCards
                    },
                  ),
                ),

                //recent courses
                Padding(
                  padding: EdgeInsets.all(Dimensions.paddingSizeHorizontalSize),
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
                    itemCount: allVideoCards.length,
                    itemBuilder: (BuildContext context, int index) {
                      return buildRecentCoursesCard(allVideoCards[index]);
                    },
                  ),
                ),
              ],

              ///when user search the  search courses  will be displayed
              if (isSearching) ...[
                Padding(
                  padding: EdgeInsets.all(Dimensions.paddingSizeHorizontalSize),
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
                      return buildSearchedCourses(filteredVideoCards[index]);
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
                    padding: EdgeInsets.only(left: Dimensions.paddingSize),
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
                    padding: EdgeInsets.only(left: Dimensions.paddingSize),
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
      ),
    );
  }

  Widget buildSearchedCourses(VideoCard videoCard) {
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
                    image: AssetImage(videoCard.imageUrl),
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
                    videoCard.title,
                    style: CustomStyle.tabStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // Subtitle
                  Text(
                    videoCard.subtitle,
                    style: CustomStyle.pStyle,
                  ),
                  // Rating and Number of Students Row

                  SizedBox(height: 8.h),
                  // Amount
                  Text(
                    videoCard.price,
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CourseDetailStudent()));
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

  Widget buildRecentCoursesCard(VideoCard videoCard) {
    return SizedBox(
      height: 92.h,
      child: Card(
        elevation: 0,
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Leading Image
            Image.asset(
              videoCard.imageUrl,
              width: 100.w,
              height: double.infinity,
              fit: BoxFit.fitHeight,
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
                    videoCard.title,
                    style: CustomStyle.tabStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // Subtitle
                  Text(
                    videoCard.subtitle,
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
                        videoCard.rating,
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
                        '${videoCard.numberOfStudents}',
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
                  videoCard.price,
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
