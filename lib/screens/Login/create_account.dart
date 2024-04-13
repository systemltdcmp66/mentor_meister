import 'package:flutter/gestures.dart';
import 'package:mentormeister/utils/basic_screen_imports.dart';

import 'login.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});
 // Updated class name
  @override
  Widget build(BuildContext context) {
    String userName = "john";
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
                    height: MediaQuery.of(context).size.height*0.5,
                    color: CustomColor.blackColor,
                    child: Column(
                      crossAxisAlignment: crossCenter,
                      mainAxisAlignment: mainStart,
                      children: [
                        logo(),
                        createAccount(),
                        Registertext(),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.25),
                    child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(Dimensions.paddingSize),
                          child: Column(
                            children: [
                              or(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ///login with google button
                                  buildContainer(context, (){}, 'assets/Login/google.png'),
                                  SizedBox(width: Dimensions.widthSize),
                                  ///login with signup button
                                  buildContainer(context, (){}, 'assets/Login/fb.png'),
                                ],
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Already have an account? ", // Updated text
                                      style: CustomStyle.hintStyle,
                                    ),
                                    TextSpan(
                                      text: "Sign In", // Updated text
                                      style: CustomStyle.fpStyle,
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginPage())); // Updated navigation to LoginScreen
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )

                    ),
                  ),
                ],
              ),
            ),


            Center(
              child: Positioned(
                //top: MediaQuery.of(context).size.height*0.2,
                left: 20.h,
                right: 20.h,
                child: const RegisterForm(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Text createAccount() => Text("Create Account", style: CustomStyle.whiteh1,);

  Container buildContainer(BuildContext context, VoidCallback onPressed, String imagePath) {
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

  Padding or() {

    return Padding(
      padding: EdgeInsets.all(Dimensions.paddingSize),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Divider(
              height: 20,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "or",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: Divider(
              height: 20,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Text Registertext() => Text('Register to get Started!', style: CustomStyle.lStyle);

  Image logo() => Image.asset('assets/Login/logo.png', height: 100.h,width: 100.h,);



  SizedBox topSpace() => SizedBox(height: 80.h,);

  SizedBox space() => SizedBox(height: Dimensions.heightSize,);
}


class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  _RegisterFormState createState() => _RegisterFormState();
}
class _RegisterFormState extends State<RegisterForm> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: 400.w,
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
            TextFormField(
              decoration: InputDecoration(
                labelText:"John",
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.grey[200],
                prefixIcon: const Icon(Icons.person_outline),
              ),
            ),
            SizedBox(height: Dimensions.heightSize,),
            Container(
              height: Dimensions.inputBoxHeight,
              color: Colors.grey[100],
              child: Padding(
                padding: EdgeInsets.all(10.r),
                child: Row(
                  mainAxisAlignment: mainSpaceBet,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.person, color: CustomColor.blackColor,),
                        SizedBox(width: Dimensions.widthSize,),
                        Text('John', style: CustomStyle.blackh3,),
                      ],
                    ),

                    const Icon(Icons.check_circle, color: CustomColor.redColor,),
                  ],
                ),
              ),
            ),

            SizedBox(height: Dimensions.heightSize),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.grey[200],
                prefixIcon: const Icon(Icons.email_outlined),
              ),
            ),
            SizedBox(height: Dimensions.heightSize),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.grey[200],
                prefixIcon: const Icon(Icons.phone_outlined),
              ),
            ),
            SizedBox(height: Dimensions.heightSize),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.grey[200],
                prefixIcon: const Icon(Icons.lock_open),
              ),
            ),
            SizedBox(height: Dimensions.heightSize),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColor.redColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                child: Text('Register', style: CustomStyle.lStyle,),
              ),
            ),
            SizedBox(height: Dimensions.heightSize),
            TextButton(
              onPressed: () {},
              child: Text('Forgot your password?', style: CustomStyle.fpStyle),
            ),
          ],
        ),
      ),
    );
  }
}
