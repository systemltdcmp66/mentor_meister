import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentormeister/commons/app/providers/teacher_sign_up_controller.dart';
import 'package:mentormeister/core/services/injection_container.dart';
import 'package:mentormeister/core/utils/core_utils.dart';
import 'package:mentormeister/features/Onboarding&Authentication/data/models/user_model.dart';
import 'package:mentormeister/features/Teacher/data/models/teacher_info_model.dart';
import 'package:mentormeister/features/Teacher/presentation/app/teacher_sign_up_cubit/teacher_sign_up_cubit.dart';
import 'package:mentormeister/features/Teacher/presentation/app/teacher_sign_up_cubit/teacher_sign_up_state.dart';
import 'package:mentormeister/core/utils/basic_screen_imports.dart';
import 'package:mentormeister/features/Teacher/presentation/widgets/bottom_nav_bar.dart';
import 'package:mentormeister/features/Teacher/utils/teacher_utils.dart';
import '../../../tabs/Description.dart';
import '../../../tabs/about.dart';
import '../../../tabs/availability.dart';
import '../../../tabs/education.dart';
import '../../../tabs/pricing.dart';
import '../../../tabs/profilepic.dart';

class TutorSignUp extends StatefulWidget {
  const TutorSignUp({super.key});
  @override
  State<TutorSignUp> createState() => _TutorSignUpState();

  static const routeName = 'tutor-sign-up';
}

class _TutorSignUpState extends State<TutorSignUp> {
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
                user.alreadyVisitTutorSignUpPage == true) {
              sl<FirebaseFirestore>().collection('users').doc(user.uid).update(
                {
                  'isFirstTime': true,
                },
              );
            }
            if (user.uid == sl<FirebaseAuth>().currentUser!.uid &&
                user.teacherId == null &&
                user.alreadyVisitTutorSignUpPage == false &&
                user.alreadyVisitTutorAskPage == true &&
                user.isFirstTime == true) {
              return const BottomNavBar(
                isStudent: true,
              );
            }
            if (user.uid == sl<FirebaseAuth>().currentUser!.uid &&
                user.alreadyVisitTutorSignUpPage == false) {
              sl<FirebaseFirestore>().collection('users').doc(user.uid).update(
                {
                  'isFirstTime': false,
                },
              );
              return SafeArea(
                child: Scaffold(
                    backgroundColor: CustomColor.primaryBGColor,
                    body: BlocConsumer<TeacherSignUpCubit, TeacherSignUpState>(
                      listener: (context, state) {
                        if (state is TeacherSignUpError) {
                          CoreUtils.showSnackar(
                            context: context,
                            message: state.message,
                          );
                        } else if (state is TeacherInfoPosted) {
                          Navigator.pushReplacementNamed(context, '/');
                        }
                      },
                      builder: (context, state) {
                        if (state is PostingTeacherInfo ||
                            state is GettingTeacherInfo) {
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
                            SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
                                    color: CustomColor.blackColor,
                                    child: Column(
                                      crossAxisAlignment: crossCenter,
                                      mainAxisAlignment: mainStart,
                                      children: [
                                        logo(),
                                        space(),
                                        text('Teacher Signup'),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.7),
                                    child: Center(
                                        child: Padding(
                                      padding: EdgeInsets.all(
                                          Dimensions.paddingSize),
                                    )),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: MediaQuery.of(context).size.height * 0.2,
                              left: 0,
                              right: 0,
                              child: const TutorForm(),
                            )
                          ],
                        );
                      },
                    )),
              );
            }
            if (user.uid == sl<FirebaseAuth>().currentUser!.uid &&
                user.teacherId != null &&
                user.alreadyVisitTutorSignUpPage == true &&
                user.isFirstTime == true) {
              return const BottomNavBar(
                isStudent: false,
              );
            }
          }
        }
        return const SizedBox.shrink();
      },
    );
  }

  Text createAccount() => Text(
        "Create Account",
        style: CustomStyle.whiteh1,
      );

  Widget buildContainer(
      BuildContext context, VoidCallback onPressed, String imagePath) {
    return SizedBox(
      height: Dimensions.buttonHeight,
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        style: ElevatedButton.styleFrom(
          elevation: 0.5,
          backgroundColor: Colors.white,
          padding: const EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          minimumSize: Size(MediaQuery.of(context).size.width * 0.4, 0),
        ),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Text text(String text) => Text(text, style: CustomStyle.lStyle);

  Image logo() => Image.asset(
        'assets/Login/logo.png',
        height: 100.h,
        width: 100.h,
      );

  SizedBox topSpace() => SizedBox(
        height: 80.h,
      );

  SizedBox space() => SizedBox(
        height: Dimensions.heightSize,
      );
}

class TutorForm extends StatefulWidget {
  const TutorForm({super.key});

  @override
  _TutorFormState createState() => _TutorFormState();
}

class _TutorFormState extends State<TutorForm>
    with SingleTickerProviderStateMixin {
  // About
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final countryController = TextEditingController();
  final languageController = TextEditingController();
  final subjectController = TextEditingController();
  final emailController = TextEditingController();
  final aboutFormKey = GlobalKey<FormState>();

  // Education
  final universityController = TextEditingController();
  final degreeController = TextEditingController();
  final degreeTypeController = TextEditingController();
  final specializationController = TextEditingController();
  final yearController = TextEditingController();
  final toController = TextEditingController();
  final educationFormKey = GlobalKey<FormState>();

  // Description
  final headlineController = TextEditingController();
  final descriptionController = TextEditingController();
  final descriptionFormKey = GlobalKey<FormState>();

  // Availability
  final fromController = TextEditingController();
  final toController2 = TextEditingController();

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _tabController.addListener(_updateButtonVisibility);
  }

  @override
  void dispose() {
    _tabController.removeListener(_updateButtonVisibility);
    _tabController.dispose();
    super.dispose();
  }

  void _updateButtonVisibility() {
    setState(
        () {}); // Rebuild the widget tree when the tab controller index changes
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.all(10),
        padding: EdgeInsets.all(Dimensions.paddingSize),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.radius),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: TabBar(
                indicator: null,
                padding: EdgeInsets.zero,
                labelPadding: const EdgeInsets.only(left: 5, right: 5),
                indicatorPadding: EdgeInsets.zero,
                indicatorColor: Colors.transparent,
                isScrollable: true,
                unselectedLabelColor: Colors.black,
                labelColor: Colors.red,
                labelStyle: CustomStyle.tabStyle,
                controller: _tabController,
                tabs: const [
                  Tab(
                    text: 'About',
                  ),
                  Tab(
                    text: 'Photo',
                  ),
                  Tab(
                    text: 'Education',
                  ),
                  Tab(
                    text: 'Description',
                  ),
                  Tab(
                    text: 'Availability',
                  ),
                  Tab(
                    text: 'Pricing',
                  ),
                ],
              ),
            ),
            SizedBox(height: Dimensions.heightSize),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.55,
              child: TabBarView(
                controller: _tabController,
                children: [
                  Form(
                    key: aboutFormKey,
                    child: AboutForm(
                      firstNameController: firstNameController,
                      lastNameController: lastNameController,
                      phoneNumberController: phoneNumberController,
                      countryController: countryController,
                      languageController: languageController,
                      subjectController: subjectController,
                      emailController: emailController,
                    ),
                  ),
                  ProfilePhotoTab(),
                  Form(
                    key: educationFormKey,
                    child: Education(
                      universityController: universityController,
                      degreeController: degreeController,
                      degreeTypeController: degreeTypeController,
                      specializationController: specializationController,
                      yearController: yearController,
                      toController: toController,
                    ),
                  ),
                  Form(
                    key: descriptionFormKey,
                    child: Description(
                      firstName: firstNameController.text.trim(),
                      lastName: lastNameController.text.trim(),
                      headlineController: headlineController,
                      descriptionController: descriptionController,
                    ),
                  ),
                  Availability(
                    fromController: fromController,
                    toController: toController2,
                  ),
                  const Pricing()
                ],
              ),
            ),
            SizedBox(height: Dimensions.heightSize),
            _buildBottomButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButton() {
    if (_tabController.index == 0) {
      // Show only next button
      return SizedBox(
        width: 300.w,
        child: ElevatedButton(
          onPressed: () {
            if (aboutFormKey.currentState!.validate()) {
              _navigateWithDelay(_tabController.index + 1);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: CustomColor.redColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text('Next', style: CustomStyle.whiteh3),
        ),
      );
    } else if (_tabController.index == _tabController.length - 1) {
      // Show back and finish button
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: () {
              _navigateWithDelay(_tabController.index - 1);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: CustomColor.redColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text('Back', style: CustomStyle.whiteh3),
          ),
          ElevatedButton(
            onPressed: () {
              bool canContinue = !context
                          .read<TeacherSignUpController>()
                          .canContinueToPricing ||
                      context.read<TeacherSignUpController>().profilePic ==
                          null ||
                      firstNameController.text.isEmpty ||
                      lastNameController.text.isEmpty ||
                      phoneNumberController.text.isEmpty ||
                      emailController.text.isEmpty ||
                      universityController.text.isEmpty ||
                      degreeController.text.isEmpty ||
                      degreeTypeController.text.isEmpty ||
                      specializationController.text.isEmpty ||
                      headlineController.text.isEmpty ||
                      descriptionController.text.isEmpty
                  ? false
                  : true;
              if (canContinue) {
                List<String> availabilityDates = [];
                for (var element in context
                    .read<TeacherSignUpController>()
                    .availabilityMap
                    .entries) {
                  if (element.value) {
                    availabilityDates.add(element.key);
                  }
                }
                final teacherInfo = TeacherInfoModel.empty().copyWith(
                  firstName: firstNameController.text.trim(),
                  lastName: lastNameController.text.trim(),
                  email: emailController.text.trim(),
                  phoneNumber: phoneNumberController.text.trim(),
                  country: countryController.text.trim(),
                  languageSpoken: languageController.text.trim(),
                  subjectTaught: subjectController.text.trim(),
                  profilePic: context
                          .read<TeacherSignUpController>()
                          .profilePicString ??
                      'assets/teacher/person.png',
                  university: universityController.text.trim(),
                  degree: degreeController.text.trim(),
                  degreeType: degreeTypeController.text.trim(),
                  specialization: specializationController.text.trim(),
                  fromYearOfStudy: yearController.text.trim(),
                  toYearOfStudy: toController.text.trim(),
                  headline: headlineController.text.trim(),
                  description: descriptionController.text.trim(),
                  hourlyRate:
                      context.read<TeacherSignUpController>().hourlyRate,
                  isProfilePicFile:
                      context.read<TeacherSignUpController>().profilePic == null
                          ? false
                          : true,
                  availabilityDates: availabilityDates,
                  availabilityFromTimes: [],
                  availabilityToTimes: [],
                );
                context.read<TeacherSignUpCubit>().postTeacherInformations(
                      teacherInfo,
                    );
              } else {
                CoreUtils.showSnackar(
                  context: context,
                  message: 'Please fill up the required field(s)',
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: CustomColor.redColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text('Finish', style: CustomStyle.whiteh3),
          ),
        ],
      );
    } else {
      // Show back and next button
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: () {
              _navigateWithDelay(_tabController.index - 1);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: CustomColor.redColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text('Back', style: CustomStyle.whiteh3),
          ),
          ElevatedButton(
            onPressed: () {
              if (_tabController.index == 4) {
                List<bool> availabilityList = [];
                context
                    .read<TeacherSignUpController>()
                    .availabilityMap
                    .forEach((key, value) {
                  availabilityList.add(value);
                });
                for (var element in availabilityList) {
                  if (element == true) {
                    context
                        .read<TeacherSignUpController>()
                        .setCanContinueToPricing = true;
                  }
                }
              }

              if (_tabController.index == 1 &&
                      context.read<TeacherSignUpController>().profilePic !=
                          null ||
                  _tabController.index == 2 &&
                      educationFormKey.currentState!.validate() ||
                  _tabController.index == 3 &&
                      descriptionFormKey.currentState!.validate() ||
                  _tabController.index == 4 &&
                      context
                          .read<TeacherSignUpController>()
                          .canContinueToPricing) {
                _navigateWithDelay(_tabController.index + 1);
              } else if (_tabController.index == 1 &&
                  context.read<TeacherSignUpController>().profilePic == null) {
                CoreUtils.showSnackar(
                  context: context,
                  message: 'Please upload a profile picture',
                );
              } else if (_tabController.index == 4 &&
                  !context
                      .read<TeacherSignUpController>()
                      .canContinueToPricing) {
                CoreUtils.showSnackar(
                  context: context,
                  message: 'Please set your availabilty',
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: CustomColor.redColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text('Next', style: CustomStyle.whiteh3),
          ),
        ],
      );
    }
  }

  void _navigateWithDelay(int index) {
    const delay = Duration(milliseconds: 500);
    Future.delayed(delay, () {
      _tabController.animateTo(index);
    });
  }
}
