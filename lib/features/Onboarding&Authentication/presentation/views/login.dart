import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentormeister/commons/app/providers/user_provider.dart';
import 'package:mentormeister/core/utils/core_utils.dart';
import 'package:mentormeister/features/Onboarding&Authentication/data/models/user_model.dart';
import 'package:mentormeister/features/Onboarding&Authentication/presentation/app/authentication_bloc/authentication_bloc.dart';
import 'package:mentormeister/core/utils/basic_screen_imports.dart';
import 'package:mentormeister/features/Onboarding&Authentication/presentation/views/create_account.dart';
import 'package:mentormeister/features/Onboarding&Authentication/presentation/views/onboarding_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();

  static const routeName = '/login';
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  // Updated class name
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColor.primaryBGColor,
        body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (_, state) {
            if (state is AuthenticationError) {
              CoreUtils.showSnackar(
                context: context,
                message: state.message,
              );
            } else if (state is UserSignedIn) {
              final user = state.user as LocalUserModel;
              context.read<UserProvider>().initUser(user);
              Navigator.of(context).pushReplacementNamed(
                OnboardingScreen.routeName,
              );
            }
          },
          builder: (context, state) {
            if (state is AuthenticationLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(
                    CustomColor.redColor,
                  ),
                ),
              );
            }
            return Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * 0.5,
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
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.2),
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
                                buildContainer(
                                    context, () {}, 'assets/Login/google.png'),
                                SizedBox(width: Dimensions.widthSize),

                                ///login with signup button
                                buildContainer(
                                    context, () {}, 'assets/Login/fb.png'),
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
                                        Navigator.pushReplacementNamed(
                                          context,
                                          SignupPage.routeName,
                                        ); // Updated navigation to SignupPage
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                    ),
                  ],
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.3,
                  left: 20.h,
                  right: 20.h,
                  child: Form(
                    key: formKey,
                    child: LoginForm(
                      emailController: emailController,
                      passwordController: passwordController,
                      formKey: formKey,
                    ),
                  ), // Updated to LoginForm
                )
              ],
            );
          },
        ),
      ),
    );
  }

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

  Text logintext() =>
      Text('Please Login to continue', style: CustomStyle.lStyle);

  Image logo() => Image.asset(
        'assets/Login/logo.png',
        height: 100.h,
        width: 100.h,
      );

  RichText welcometext() {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: 'Welcome to ',
          style: CustomStyle.whiteh2,
        ),
        TextSpan(
          text: 'Mentor Meister',
          style: CustomStyle.whiteh1,
        ),
      ]),
    );
  }

  SizedBox topSpace() => SizedBox(
        height: 80.h,
      );

  SizedBox space() => SizedBox(
        height: Dimensions.heightSize,
      );
}

class LoginForm extends StatefulWidget {
  const LoginForm({
    required this.emailController,
    required this.passwordController,
    required this.formKey,
    super.key,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
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
          SizedBox(
            height: Dimensions.heightSize,
          ),
          TextFormField(
            controller: widget.emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Email can't be empty";
              }
              return null;
            },
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
            controller: widget.passwordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Password can't be empty";
              } else if (value.length < 8) {
                return 'Password length must have at least 8 characters';
              }
              return null;
            },
            obscureText: _isObscure,
            decoration: InputDecoration(
              labelText: 'Password',
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.grey[200],
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                icon:
                    Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
                onPressed: _toggleVisibility,
              ),
            ),
          ),
          SizedBox(height: Dimensions.heightSize),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
                FirebaseAuth.instance.currentUser?.reload();
                if (widget.formKey.currentState!.validate()) {
                  context.read<AuthenticationBloc>().add(
                        SignInEvent(
                          email: widget.emailController.text.trim(),
                          password: widget.passwordController.text.trim(),
                        ),
                      );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomColor.redColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              child: Text(
                'Login',
                style: CustomStyle.lStyle,
              ),
            ),
          ),
          SizedBox(height: Dimensions.heightSize),
          TextButton(
            onPressed: () {},
            child: Text(
              'Forgot your password?',
              style: CustomStyle.fpStyle,
            ),
          ),
        ],
      ),
    );
  }
}
