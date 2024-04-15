import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentormeister/features/Onboarding&Authentication/presentation/app/ask_page_cubit/ask_page_cubit.dart';
import 'package:mentormeister/features/Onboarding&Authentication/presentation/app/ask_page_cubit/ask_page_state.dart';
import 'package:mentormeister/features/Onboarding&Authentication/presentation/views/onboarding_screen.dart';
import 'package:mentormeister/features/Teacher/bottom_nav_bar.dart';
import 'package:mentormeister/core/utils/basic_screen_imports.dart';

import '../../../Teacher/tutor_signup.dart';

class AskPage extends StatefulWidget {
  const AskPage({super.key});

  @override
  State<AskPage> createState() => _AskPageState();

  static const routeName = '/ask-page';
}

class _AskPageState extends State<AskPage> {
  bool isTCardSelected = false;
  bool isSCardSelected = false;

  @override
  void initState() {
    super.initState();
    context.read<AskPageCubit>().checkingIfUserIsAStudent();
    context.read<AskPageCubit>().checkingIfUserIsATeacher();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColor.primaryBGColor,
        body: BlocConsumer<AskPageCubit, AskPageState>(
          listener: (context, state) {
            if (state is StudentCached || state is TeacherCached) {
              Navigator.of(context).pushReplacementNamed(
                OnboardingScreen.routeName,
              );
            }
          },
          builder: (context, state) {
            if (state is CheckingIfUserIsAStudent ||
                state is CheckingIfUserIsATeacher) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    CustomColor.redColor,
                  ),
                ),
              );
            }
            return Stack(
              children: <Widget>[
                Stack(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height * 0.6,
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
                      Center(
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
                                      color: isTCardSelected
                                          ? CustomColor.redColor
                                          : Colors.transparent,
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
                                            icon: const Icon(
                                                Icons.arrow_forward_ios),
                                            onPressed: () {
                                              context
                                                  .read<AskPageCubit>()
                                                  .isATeacher();
                                              // Navigator.push(
                                              //   context,
                                              //   MaterialPageRoute(
                                              //     builder: (context) =>
                                              //         const TutorSignUp(),
                                              //   ),
                                              // );
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
                                      color: isSCardSelected
                                          ? CustomColor.redColor
                                          : Colors.transparent,
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
                                            icon: const Icon(
                                              Icons.arrow_forward_ios,
                                            ),
                                            onPressed: () {
                                              context
                                                  .read<AskPageCubit>()
                                                  .isAStudent();
                                              // Navigator.push(
                                              //   context,
                                              //   MaterialPageRoute(
                                              //     builder: (context) =>
                                              //         const BottomNavBar(
                                              //       isStudent: true,
                                              //     ),
                                              //   ),
                                              // );
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
                    ],
                  ),
                  linestyle(),
                ]),
              ],
            );
          },
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

  Text askPagetext() =>
      Text('In what way you can want to proceed with the app?',
          style: CustomStyle.whiteh1);

  Image logo() => Image.asset(
        'assets/Login/logo.png',
        height: 100.h,
        width: 100.h,
      );

  SizedBox space() => SizedBox(height: Dimensions.heightSize);
}
