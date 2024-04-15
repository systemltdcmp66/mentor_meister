import 'package:mentormeister/features/Teacher/bottom_nav_bar.dart';
import 'package:mentormeister/core/utils/basic_screen_imports.dart';

import '../tabs/Description.dart';
import '../tabs/about.dart';
import '../tabs/availability.dart';
import '../tabs/education.dart';
import '../tabs/pricing.dart';
import '../tabs/profilepic.dart';

class TutorSignUp extends StatefulWidget {
  const TutorSignUp({super.key});
  @override
  State<TutorSignUp> createState() => _TutorSignUpState();
}

class _TutorSignUpState extends State<TutorSignUp> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColor.primaryBGColor,
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
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
                        top: MediaQuery.of(context).size.height * 0.7),
                    child: Center(
                        child: Padding(
                      padding: EdgeInsets.all(Dimensions.paddingSize),
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
        ),
      ),
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
                  Container(
                    child: const AboutForm(),
                  ),
                  const ProfilePhotoTab(),
                  const Education(),
                  const Description(),
                  const Availability(),
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
            _navigateWithDelay(_tabController.index + 1);
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BottomNavBar(isStudent: false),
                ),
              );
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
              _navigateWithDelay(_tabController.index + 1);
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
