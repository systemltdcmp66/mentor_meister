import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentormeister/commons/app/providers/user_provider.dart';
import 'package:mentormeister/core/utils/basic_screen_imports.dart';
import 'package:mentormeister/core/utils/core_utils.dart';
import 'package:mentormeister/features/Onboarding&Authentication/data/models/user_model.dart';
import 'package:mentormeister/features/Onboarding&Authentication/presentation/app/authentication_bloc/authentication_bloc.dart';
import 'package:mentormeister/features/Onboarding&Authentication/presentation/views/login.dart';
import 'package:mentormeister/features/Onboarding&Authentication/presentation/widgets/ask_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();

  static const routeName = 'sign-up';
}

class _SignupPageState extends State<SignupPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
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
              } else if (state is UserSignedUp) {
                context.read<AuthenticationBloc>().add(
                      SignInEvent(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      ),
                    );
              } else if (state is UserSignedIn) {
                final user = state.user as LocalUserModel;
                context.read<UserProvider>().initUser(user);
                Navigator.of(context).pushReplacementNamed(
                  AskPage.routeName,
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
                  SingleChildScrollView(
                    child: Column(
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
                              logo(),
                              createAccount(),
                              Registertext(),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.25),
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
                                    buildContainer(context, () {},
                                        'assets/Login/google.png'),
                                    SizedBox(width: Dimensions.widthSize),

                                    ///login with signup button
                                    buildContainer(
                                        context, () {}, 'assets/Login/fb.png'),
                                  ],
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            "Already have an account? ", // Updated text
                                        style: CustomStyle.hintStyle,
                                      ),
                                      TextSpan(
                                        text: "Sign In", // Updated text
                                        style: CustomStyle.fpStyle,
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.pushReplacementNamed(
                                              context,
                                              LoginPage.routeName,
                                            ); // Updated navigation to LoginScreen
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
                  ),
                  Center(
                    child: Positioned(
                      //top: MediaQuery.of(context).size.height*0.2,
                      left: 20.h,
                      right: 20.h,
                      child: Form(
                        key: formKey,
                        child: RegisterForm(
                          nameController: nameController,
                          emailController: emailController,
                          passwordController: passwordController,
                          phoneNumberController: phoneNumberController,
                          formKey: formKey,
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          )),
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

  Text Registertext() =>
      Text('Register to get Started!', style: CustomStyle.lStyle);

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

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.phoneNumberController,
    required this.formKey,
    super.key,
  });

  final TextEditingController nameController;
  final TextEditingController passwordController;
  final TextEditingController emailController;
  final TextEditingController phoneNumberController;
  final GlobalKey<FormState> formKey;

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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Name can't be empty";
                } else if (value.length < 5) {
                  return 'Name length must have at least 5 characters';
                }
                return null;
              },
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Name",
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.grey[200],
                prefixIcon: const Icon(Icons.person_outline),
              ),
            ),
            SizedBox(
              height: Dimensions.heightSize,
            ),
            Container(
              height: Dimensions.inputBoxHeight,
              color: Colors.grey[100],
              child: Padding(
                padding: EdgeInsets.all(10.r),
                child: Row(
                  mainAxisAlignment: mainSpaceBet,
                  children: [
                    StatefulBuilder(builder: (context, refresh) {
                      nameController.addListener(
                        () => refresh(() {}),
                      );
                      return Row(
                        children: [
                          const Icon(
                            Icons.person,
                            color: CustomColor.blackColor,
                          ),
                          SizedBox(
                            width: Dimensions.widthSize,
                          ),
                          Text(
                            nameController.text,
                            style: CustomStyle.blackh3,
                          ),
                        ],
                      );
                    }),
                    Builder(builder: (context) {
                      bool isNameCorrect = nameController.text.isEmpty ||
                              nameController.text.length < 4
                          ? false
                          : true;
                      return Icon(
                        isNameCorrect ? Icons.check_circle : Icons.error,
                        color: CustomColor.redColor,
                      );
                    }),
                  ],
                ),
              ),
            ),
            SizedBox(height: Dimensions.heightSize),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Email can't be empty";
                }
                return null;
              },
              controller: emailController,
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Phone Number can't be empty";
                }
                return null;
              },
              controller: phoneNumberController,
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Password can't be empty";
                } else if (value.length < 8) {
                  return 'Password length must have at least 8 characters';
                }
                return null;
              },
              controller: passwordController,
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
                onPressed: () {
                  FirebaseAuth.instance.currentUser?.reload();
                  FocusManager.instance.primaryFocus?.unfocus();

                  if (formKey.currentState!.validate()) {
                    context.read<AuthenticationBloc>().add(
                          SignUpEvent(
                            name: nameController.text.trim(),
                            email: emailController.text.trim(),
                            phoneNumber: phoneNumberController.text.trim(),
                            password: passwordController.text.trim(),
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
                  'Register',
                  style: CustomStyle.lStyle,
                ),
              ),
            ),
            // In Sign up there must not be forgot password text
            // SizedBox(height: Dimensions.heightSize),
            // TextButton(
            //   onPressed: () {},
            //   child: Text('Forgot your password?', style: CustomStyle.fpStyle),
            // ),
          ],
        ),
      ),
    );
  }
}
