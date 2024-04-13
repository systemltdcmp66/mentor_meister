import 'package:mentormeister/screens/Teacher/bottom_nav_bar.dart';
import 'package:mentormeister/utils/basic_screen_imports.dart';

import '../Teacher/tutor_signup.dart';

class AskPage extends StatefulWidget {
  const AskPage({super.key});

  @override
  State<AskPage> createState() => _AskPageState();
}

class _AskPageState extends State<AskPage> {
  bool isTCardSelected = false;
  bool isSCardSelected = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColor.primaryBGColor,
        body: Stack(
          children: <Widget>[
            Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height*0.6,
                      color: CustomColor.blackColor,
                      child: Padding(
                        padding: EdgeInsets.all(Dimensions.paddingSize),
                        child: Column(
                          crossAxisAlignment: crossCenter,
                          mainAxisAlignment: mainCenter,
                          children: [
                            Expanded(child: logo()),
                            space(),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: askPagetext(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(Dimensions.paddingSize),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isTCardSelected = !isTCardSelected;
                                    isSCardSelected = false;
                                  });
                                },
                                child: Card(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(
                                      color: isTCardSelected ? CustomColor.redColor : Colors.transparent,
                                      width: 2.0,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      children: [
                                        // Image
                                        Image.asset(
                                          'assets/Login/teacher.png',
                                          height: 50,
                                          width: 50,
                                        ),
                                        const SizedBox(width: 10),
                                        // Text
                                        const Text(
                                          'As a teacher',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        const Spacer(),
                                        // Forward icon button
                                        Card(
                                          child: IconButton(
                                            icon: const Icon(Icons.arrow_forward_ios),
                                            onPressed: () {
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const TutorSignUp()));
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20), // Space between cards
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isSCardSelected = !isSCardSelected;
                                    isTCardSelected = false;
                                  });
                                },
                                child: Card(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(
                                      color: isSCardSelected ? CustomColor.redColor : Colors.transparent,
                                      width: 2.0,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      children: [
                                        // Image
                                        Image.asset(
                                          'assets/Login/student.png',
                                          height: 50.h,
                                          width: 50.w,
                                        ),
                                        const SizedBox(width: 10),
                                        // Text
                                        const Text(
                                          'As a student',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        const Spacer(),
                                        // Forward icon button
                                        Card(
                                          child: IconButton(
                                            icon: const Icon(Icons.arrow_forward_ios),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => const TeacherNavBar(isStudent: true),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                linestyle(),
        ]

            ),
          ],
        ),
      ),
    );
  }

  Positioned linestyle() {
    return Positioned(
                top: 0,
                right: 0,
                child: Image.asset('assets/Login/topdesign.png'),
              );
  }

  Text askPagetext() => Text('In what way you can want to proceed with the app?', style: CustomStyle.whiteh1);

  Image logo() => Image.asset('assets/Login/logo.png', height: 100.h,width: 100.h,);

  SizedBox space() => SizedBox(height: Dimensions.heightSize);
}
