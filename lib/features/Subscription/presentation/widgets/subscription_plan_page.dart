import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentormeister/commons/app/providers/subscription_provider.dart';
import 'package:mentormeister/commons/app/providers/teacher_provider.dart';
import 'package:mentormeister/core/utils/basic_screen_imports.dart';
import 'package:mentormeister/core/utils/core_utils.dart';
import 'package:mentormeister/features/payment/data/models/subscription_model.dart';
import 'package:mentormeister/features/payment/presentation/views/subs_payment_page.dart';
import '../../../../commons/widgets/custom_appbar.dart';
import '../../../../commons/widgets/custom_button.dart';

class SubscriptionPlanPage extends StatefulWidget {
  const SubscriptionPlanPage({Key? key}) : super(key: key);

  @override
  _SubscriptionPlanPageState createState() => _SubscriptionPlanPageState();
}

class _SubscriptionPlanPageState extends State<SubscriptionPlanPage> {
  int _selectedPlan = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primaryBGColor,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.15),
        child: const Center(
          child: CustomAppBar(
            title: 'Subscription Plan',
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(Dimensions.paddingSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Choose Subscription Plan',
                style: CustomStyle.blackh1,
              ),
            ),
            Center(
              child: Text(
                "I'm a paragraph. I’m a great place for you to "
                "tell a story and let your users know a little.",
                style: CustomStyle.pStyle,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: Dimensions.heightSize),
            Text(
              'Basic Tier',
              style: CustomStyle.interh2,
            ),
            buildPlanTile(
              'Free Tier',
              0,
              showRichText: false,
            ),
            SizedBox(
              height: Dimensions.heightSize,
            ),
            Text(
              'Premium Tier',
              style: CustomStyle.interh2,
            ),
            SizedBox(
              height: Dimensions.heightSize,
            ),
            buildPlanTile('Monthly', 1),
            SizedBox(
              height: Dimensions.heightSize,
            ),
            buildPlanTile('Annual', 2),
            const Spacer(),
            CustomButton(
              text: 'Get Started',
              onPressed: () {
                if (context.read<SubscriptionProvider>().package == "Free" &&
                    _selectedPlan == 0) {
                  CoreUtils.showSnackar(
                    context: context,
                    message: 'You have already subscribed for the free tier.',
                  );
                } else if (context.read<SubscriptionProvider>().package ==
                        "Monthly" &&
                    _selectedPlan == 1) {
                  CoreUtils.showSnackar(
                    context: context,
                    message:
                        'You have already subscribed for the monthly tier.',
                  );
                } else if (context.read<SubscriptionProvider>().package ==
                        "Annual" &&
                    _selectedPlan == 2) {
                  CoreUtils.showSnackar(
                    context: context,
                    message: 'You have already subscribed for the annual tier.',
                  );
                } else {
                  final String type = _selectedPlan == 0
                      ? 'free'
                      : (_selectedPlan == 1 ? 'monthly' : 'annual');
                  final double price = _selectedPlan == 0
                      ? 0
                      : (_selectedPlan == 1 ? 50 : 50 * 12);
                  final subscription = SubscriptionModel(
                    teacherId:
                        context.read<TeacherProvider>().teacherInfo![0].id,
                    teacherEmail:
                        context.read<TeacherProvider>().teacherInfo![0].email,
                    paymentType: 'Paypal',
                    paymentId: '',
                    paidAt: DateTime.now(),
                    type: type,
                    price: price,
                  );
                  Navigator.of(context).pushNamed(
                    SubscriptionPaymentPage.routeName,
                    arguments: subscription,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPlanTile(String text, int index, {bool showRichText = true}) {
    return Card(
      elevation: 0,
      child: RadioListTile<int>(
        title: Text(
          text,
          style: CustomStyle.interh2,
        ),
        value: index,
        groupValue: _selectedPlan,
        activeColor: CustomColor.redColor,
        onChanged: (int? value) {
          setState(() {
            _selectedPlan = value!;
          });
        },
        secondary: showRichText
            ? RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: '\$50',
                      style: TextStyle(color: CustomColor.blackColor),
                    ),
                    TextSpan(
                      text: ' /month',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              )
            : null,
      ),
    );
  }
}
