import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentormeister/commons/app/providers/subscription_provider.dart';
import 'package:mentormeister/commons/app/providers/teacher_provider.dart';
import 'package:mentormeister/commons/app/providers/user_provider.dart';
import 'package:mentormeister/core/services/injection_container.dart';
import 'package:mentormeister/core/utils/core_utils.dart';
import 'package:mentormeister/features/Contact/utils/chat_utils.dart';
import 'package:mentormeister/features/Onboarding&Authentication/presentation/views/onboarding_screen.dart';
import 'package:mentormeister/features/Subscription/presentation/cubit/subscription_cubit.dart';
import 'package:mentormeister/features/Subscription/presentation/cubit/subscription_state.dart';
import 'package:mentormeister/features/Subscription/presentation/widgets/subscription_plan_page.dart';
import 'package:mentormeister/core/utils/basic_screen_imports.dart';
import 'package:mentormeister/features/Teacher/my_courses/custom_app_bar.dart';
import 'package:mentormeister/features/payment/data/models/subscription_model.dart';

import '../../../Subscription/presentation/widgets/rate_us.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({
    super.key,
    required this.isStudent,
  });

  final bool isStudent;

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  @override
  void initState() {
    super.initState();
    if (!widget.isStudent) {
      context.read<SubscriptionCubit>().getSubscriptionData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height * 0.15,
        ),
        child: const CustomAppBarWithPop(text: 'My Account'),
      ),
      body: BlocConsumer<SubscriptionCubit, SubscriptionState>(
        listener: (_, state) {
          if (state is SubscriptionError) {
            CoreUtils.showSnackar(
              context: context,
              message: 'Error checking the subscription. Try later',
            );
          } else if (state is SubscriptionDataFetched &&
              state.subscriptions.isNotEmpty) {
            final data = state.subscriptions as List<SubscriptionModel>;

            for (SubscriptionModel subscriptionModel in data) {
              if (subscriptionModel.teacherId ==
                  context.read<TeacherProvider>().teacherInfo![0].id) {
                context.read<SubscriptionProvider>().isSubscribed = true;
                if (subscriptionModel.type == "free") {
                  context.read<SubscriptionProvider>().package = "Free";
                  context.read<SubscriptionProvider>().price = 0;
                  context.read<SubscriptionProvider>().validTill =
                      subscriptionModel.paidAt.add(
                    const Duration(days: 7),
                  );
                } else if (subscriptionModel.type == "monthly") {
                  context.read<SubscriptionProvider>().package = "Monthly";
                  context.read<SubscriptionProvider>().price = 50;
                  context.read<SubscriptionProvider>().validTill =
                      subscriptionModel.paidAt.add(
                    const Duration(
                      days: 31,
                    ),
                  );
                } else if (subscriptionModel.type == "annual") {
                  context.read<SubscriptionProvider>().package = "Annual";
                  context.read<SubscriptionProvider>().price = 50;
                  context.read<SubscriptionProvider>().validTill =
                      subscriptionModel.paidAt.add(
                    const Duration(
                      days: 365,
                    ),
                  );
                }
              }
            }
          }
        },
        builder: (context, state) {
          if (state is GettingSubscriptionData) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(CustomColor.redColor),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ///set to true when user have active subscription plan
                  widget.isStudent
                      ? const SizedBox.shrink()
                      : _buildSubscriptionPlan(
                          isSubscribed:
                              context.read<SubscriptionProvider>().isSubscribed,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const SubscriptionPlanPage(),
                              ),
                            );
                          },
                          package: context
                              .read<SubscriptionProvider>()
                              .package
                              .toString(),
                          validTill:
                              context.read<SubscriptionProvider>().validTill,
                          price: context.read<SubscriptionProvider>().price,
                        ),
                  _buildAccountSection(),
                  _buildRowWithIconAndText(
                    Icons.person,
                    'Profile',
                    () {},
                  ),
                  _buildRowWithIconAndText(
                    Icons.lock,
                    'Account Preference',
                    () {},
                  ),
                  _buildRowWithIconAndText(Icons.star, 'Rate Us', () {
                    Navigator.of(context).pushNamed(
                      RateUs.routeName,
                    );
                  }),
                  _buildRowWithIconAndText(
                      Icons.privacy_tip, 'Privacy Policy', () {}),
                  _buildRowWithIconAndText(
                    Icons.support,
                    'Student Support',
                    () {},
                  ),
                  _buildRowWithIconAndText(
                    Icons.description,
                    'Terms and Conditions',
                    () {},
                  ),
                  _buildRowWithIconAndText(
                    Icons.question_answer,
                    'FAQ',
                    () {},
                  ),
                  _buildRowWithIconAndText(
                    Icons.help,
                    'Help',
                    () {},
                  ),
                  _buildRowWithIconAndText(
                    Icons.logout_outlined,
                    'Logout',
                    () async {
                      if (context.mounted) {
                        context.read<UserProvider>().userInfo = [];
                      }
                      final navigator = Navigator.of(context);
                      await sl<FirebaseAuth>().signOut();
                      navigator.pushNamedAndRemoveUntil(
                        OnboardingScreen.routeName,
                        (route) => false,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSubscriptionPlan({
    required bool isSubscribed,
    required VoidCallback onPressed,
    required String package,
    required DateTime validTill,
    required double price,
  }) {
    if (isSubscribed) {
      return GestureDetector(
        onTap: onPressed,
        child: Card(
          elevation: 0,
          color: CustomColor.redColor,
          child: Padding(
            padding: EdgeInsets.all(Dimensions.paddingSize),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: mainSpaceBet,
                  children: [
                    Text(
                      '$package Package',
                      style: CustomStyle.whiteh3,
                    ),
                    Text(
                      'Valid Till',
                      style: CustomStyle.whiteh3,
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.heightSize),
                price == 0
                    ? Row(
                        mainAxisAlignment: mainSpaceBet,
                        children: [
                          Text(
                            'Weekly \$0',
                            style: CustomStyle.whiteh2,
                          ),
                          Text(
                            ChatUtils.toMyTime(
                              validTill,
                            ),
                            style: CustomStyle.whiteh2,
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: mainSpaceBet,
                        children: [
                          Text(
                            'Monthly \$50',
                            style: CustomStyle.whiteh2,
                          ),
                          Text(
                            ChatUtils.toMyTime(
                              validTill,
                            ),
                            style: CustomStyle.whiteh2,
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.r)),
            color: Colors.red,
          ),
          padding: EdgeInsets.all(Dimensions.paddingSize),
          child: Row(
            mainAxisAlignment: mainSpaceBet,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                children: [
                  Text(
                    'Subscription Plan',
                    style: CustomStyle.whiteh1,
                  ),
                  Text(
                    'Upgrade for more features',
                    style: CustomStyle.whiteh3,
                  ),
                ],
              ),
              Image.asset(
                'assets/teacher/crown.png',
                height: 62.h,
                width: 70.w,
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget _buildAccountSection() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Text(
        'Account',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildRowWithIconAndText(
      IconData icon, String text, VoidCallback onPressed) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.r),
      child: Row(
        children: <Widget>[
          Container(
            height: 30.h,
            width: 30.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.r)),
              color: CustomColor.hintColor,
            ),
            child: Icon(icon, color: Colors.black),
          ),
          SizedBox(width: Dimensions.widthSize),
          Expanded(
            child: Text(
              text,
              style: CustomStyle.interh3,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.arrow_forward_ios,
            ),
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
