import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentormeister/core/utils/basic_screen_imports.dart';
import 'package:mentormeister/features/Onboarding&Authentication/presentation/app/on_boarding_cubit/on_boarding_cubit.dart';
import 'package:mentormeister/features/Onboarding&Authentication/presentation/app/on_boarding_cubit/on_boarding_state.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();

  static const routeName = '/';
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OnBoardingCubit>().checkIfUserIsFirstTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: BlocConsumer<OnBoardingCubit, OnBoardingState>(
          listener: (_, state) {
            if (state is OnBoardingStatus && !state.isFirstTimer) {
              // Nothing
            } else if (state is UserCached) {
              Navigator.pushReplacementNamed(context, '/');
            }
          },
          builder: (context, state) {
            if (state is CachingFirstTimer ||
                state is CheckingIfUserIsFirstTimer) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(
                    CustomColor.redColor,
                  ),
                ),
              );
            }
            return Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: mainCenter,
                    crossAxisAlignment: crossCenter,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3),

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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                child: Padding(
                                  padding:
                                      EdgeInsets.all(Dimensions.paddingSize),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                              left: (MediaQuery.of(context).size.width) /
                                  3.2, // Center the button horizontally
                              child: GestureDetector(
                                onTap: () {
                                  context
                                      .read<OnBoardingCubit>()
                                      .cacheFirstTimer();
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
            );
          },
        ));
  }

  Positioned lineStyle() {
    return Positioned(
      top: 0,
      right: -5,
      child: Image.asset('assets/Login/topdesign.png'),
    );
  }
}
