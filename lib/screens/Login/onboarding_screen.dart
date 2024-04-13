import 'package:mentormeister/utils/basic_screen_imports.dart';

import 'login.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: mainCenter,
              crossAxisAlignment: crossCenter,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*0.3),
            
                // Logo
                Image.asset(
                  'assets/Login/logo.png',
                  width: 190.w,
                  height: 190.h,
                ),
                SizedBox(height: 80.h),
                // Welcome text
                SizedBox(
                  width: 325.w,
                  height: 280.h,
                  child: Stack(
                    children: [
                    //  White container
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          width: 325.w,
                          height: 225.h,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Padding(
                            padding:  EdgeInsets.all(Dimensions.paddingSize),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Welcome to\nMentor Meister",
                                  textAlign: TextAlign.center,
                                  style: CustomStyle.blackh2,
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  "At convallis tristique egestas\ntellus velit. Morbi nec pretium\nvel.At convallis tristique.",
                                  textAlign: TextAlign.center,
                                  style: CustomStyle.pStyle,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 30.h,
                        left: (MediaQuery.of(context).size.width) / 3.2, // Center the button horizontally
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginPage()));
                          },
                          child: const Center(
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: CustomColor.redColor,
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 56,
                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
            
              ],
            ),
          ),
          lineStyle(),
        ],
      ),
    );
  }

  Positioned lineStyle() {
    return Positioned(
      top: 0,
      right: -5,
      child: Image.asset('assets/Login/topdesign.png'),
    );
  }

}
