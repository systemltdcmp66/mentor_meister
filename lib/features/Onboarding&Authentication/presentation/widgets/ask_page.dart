import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentormeister/core/services/injection_container.dart';
import 'package:mentormeister/features/Onboarding&Authentication/data/models/user_model.dart';
import 'package:mentormeister/features/Onboarding&Authentication/presentation/app/ask_page_cubit/ask_page_cubit.dart';
import 'package:mentormeister/features/Onboarding&Authentication/presentation/app/ask_page_cubit/ask_page_state.dart';
import 'package:mentormeister/features/Onboarding&Authentication/presentation/views/onboarding_screen.dart';
import 'package:mentormeister/core/utils/basic_screen_imports.dart';
import 'package:mentormeister/features/Teacher/presentation/app/teacher_sign_up_cubit/teacher_sign_up_cubit.dart';
import 'package:mentormeister/features/Teacher/presentation/views/tutor_signup.dart';
import 'package:mentormeister/features/Teacher/utils/teacher_utils.dart';

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
    return StreamBuilder<List<LocalUserModel>>(
      stream: TeacherUtils.getAllUsers,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SafeArea(
            child: Scaffold(
              backgroundColor: CustomColor.primaryBGColor,
              body: Center(
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(CustomColor.redColor),
                ),
              ),
            ),
          );
        } else if (snapshot.hasData) {
          final List<LocalUserModel> users = snapshot.data!;
          for (LocalUserModel user in users) {
            if (user.uid == sl<FirebaseAuth>().currentUser!.uid &&
                user.alreadyVisitTutorAskPage == true) {
              return BlocProvider(
                create: (_) => sl<TeacherSignUpCubit>(),
                child: const TutorSignUp(),
              );
            }
          }
        }
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
                                        borderRadius:
                                            BorderRadius.circular(10.0),
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
                                                  FirebaseFirestore.instance
                                                      .collection('users')
                                                      .doc(sl<FirebaseAuth>()
                                                          .currentUser!
                                                          .uid)
                                                      .update({
                                                    'alreadyVisitTutorAskPage':
                                                        true,
                                                    'isFirstTime': false,
                                                  });
                                                  Navigator.of(context)
                                                      .pushReplacementNamed(
                                                    TutorSignUp.routeName,
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                      height: 20), // Space between cards
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
                                        borderRadius:
                                            BorderRadius.circular(10.0),
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
                                                  FirebaseFirestore.instance
                                                      .collection('users')
                                                      .doc(sl<FirebaseAuth>()
                                                          .currentUser!
                                                          .uid)
                                                      .update({
                                                    'alreadyVisitTutorAskPage':
                                                        true,
                                                  });
                                                  Navigator.of(context)
                                                      .pushReplacementNamed(
                                                    TutorSignUp.routeName,
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
      },
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
