import 'package:flutter/gestures.dart';
import 'package:mentormeister/screens/Login/ask_page.dart';
// Updated import
import 'package:mentormeister/utils/basic_screen_imports.dart';

import 'create_account.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
 // Updated class name
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColor.primaryBGColor,
        body: Stack(
          children: <Widget>[
            Column(
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
                      topSpace(),
                      logo(),
                      space(),
                      welcometext(),
                      space(),
                      logintext(),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.2),
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
                            space(),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Don't have an account? ",
                                    style: CustomStyle.hintStyle,
                                  ),
                                  TextSpan(
                                    text: "Sign Up",
                                    style: CustomStyle.fpStyle,
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignupPage())); // Updated navigation to SignupPage
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


            Positioned(
             top: MediaQuery.of(context).size.height*0.3,
              left: 20.h,
              right: 20.h,
              child: const LoginForm(), // Updated to LoginForm
            )
          ],
        ),
      ),
    );
  }

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

  Text logintext() => Text('Please Login to continue', style: CustomStyle.lStyle);

  Image logo() => Image.asset('assets/Login/logo.png', height: 100.h,width: 100.h,);

  RichText welcometext() {
    return RichText(
      text: TextSpan(
          children: [
            TextSpan(
              text: 'Welcome to ',
              style: CustomStyle.whiteh2,
            ),
            TextSpan(
              text: 'Mentor Meister',
              style: CustomStyle.whiteh1,
            ),
          ]
      ),
    );
  }

  SizedBox topSpace() => SizedBox(height: 80.h,);

  SizedBox space() => SizedBox(height: Dimensions.heightSize,);
}


class LoginForm extends StatefulWidget {
  const LoginForm({super.key});
 // Updated class name
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _isObscure = true;

  void _toggleVisibility() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.all(Dimensions.margin),
      padding: EdgeInsets.all(Dimensions.paddingSize),
      width: 390.w,
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

          SizedBox(height: Dimensions.heightSize,),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Email',
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.grey[200],
              prefixIcon: const Icon(Icons.email),
            ),
          ),
          SizedBox(height: Dimensions.heightSize),
          TextFormField(
            obscureText: _isObscure,
            decoration: InputDecoration(
              labelText: 'Password',
              border:InputBorder.none,
              filled: true,
              fillColor: Colors.grey[200],
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
                onPressed: _toggleVisibility,
              ),
            ),
          ),
          SizedBox(height: Dimensions.heightSize),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const AskPage()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomColor.redColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              child: Text('Login', style: CustomStyle.lStyle,),
            ),
          ),
          SizedBox(height: Dimensions.heightSize),
          TextButton(
            onPressed: () {},
            child: Text('Forgot your password?',style: CustomStyle.fpStyle, ),
          ),
        ],
      ),
    );
  }
}
