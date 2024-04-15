import '../../../models/video_cardmodel.dart';

import 'package:mentormeister/core/utils/basic_screen_imports.dart';

import 'course_detail_screen.dart';

class MyCoursesScreen extends StatefulWidget {
  const MyCoursesScreen({super.key});

  @override
  State<MyCoursesScreen> createState() => _MyCoursesScreenState();
}

class _MyCoursesScreenState extends State<MyCoursesScreen> {
  bool isShowContent = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColor.primaryBGColor,
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  color: Colors.black,
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(Dimensions.paddingSize),
                  child: Row(
                    mainAxisAlignment: mainStart,
                    crossAxisAlignment: crossCenter,
                    children: [
                      IconButton(
                        icon: Container(
                          padding: const EdgeInsets.only(left: 6),
                          height: 38,
                          width: 38,
                          decoration: BoxDecoration(
                            color: CustomColor.whiteColor.withOpacity(0.1),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                          ),
                          child: const Align(
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: CustomColor.whiteColor,
                            ),
                          ),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      SizedBox(
                        width: Dimensions.widthSize * 8,
                      ),
                      Text(
                        'My Courses',
                        style: CustomStyle.whiteh1,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Dimensions.heightSize),
                isShowContent
                    ? const Expanded(child: CourseDetailScreen())
                    : Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: videoCards.length,
                          itemBuilder: (context, index) {
                            return _buildCourseCard(videoCards[index]);
                          },
                        ),
                      ),
              ],
            ),
            if (isShowContent)
              Positioned(
                left: 10,
                right: 10,
                top: MediaQuery.of(context).size.height * 0.16,
                child: Card(
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
                            image: const DecorationImage(
                              image: AssetImage('assets/students/student.png'),
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
                                'React.js from scratch',
                                style: CustomStyle.interh2,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '15 Lessons | 5 Assignments | 5 Quizzes',
                                style: CustomStyle.fpStyle,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
          ],
        ));
  }

  Widget _buildCourseCard(VideoCard videoCard) {
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
                  image: AssetImage(videoCard.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(
              videoCard.title,
              style: CustomStyle.hintTextStyle,
            ),
            trailing: ElevatedButton(
              onPressed: () {
                setState(() {
                  isShowContent = !isShowContent;
                });
                // Handle button press
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
            )),
      ),
    );
  }
}
