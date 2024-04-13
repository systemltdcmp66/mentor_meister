import 'package:mentormeister/screens/Subscription/payment_page.dart';
import 'package:mentormeister/utils/basic_screen_imports.dart';
import '../../widget/custom_appbar.dart';
import '../../widget/custom_button.dart';

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
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.15),
        child: const Center(
          child: CustomAppBar(title: 'Subscription Plan'),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(Dimensions.paddingSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Text('Choose Subscription Plan', style: CustomStyle.blackh1)),
            Center(
              child: Text(
                "I'm a paragraph. I’m a great place for you to tell a story and let your users know a little.",
                style: CustomStyle.pStyle,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: Dimensions.heightSize),
            Text('Basic Tier', style: CustomStyle.interh2,),
            buildPlanTile('Free Tier', 0, showRichText: false),
            SizedBox(height: Dimensions.heightSize),
            Text('Premium Tier', style: CustomStyle.interh2,),
            SizedBox(height: Dimensions.heightSize),
            buildPlanTile('Monthly', 1),
            SizedBox(height: Dimensions.heightSize),
            buildPlanTile('Annual', 2),
            const Spacer(),
            CustomButton(
              text: 'Get Started',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const PaymentMethod()));
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
              TextSpan(text: '\$50', style: TextStyle(color: CustomColor.blackColor)),
              TextSpan(text: ' /month', style: TextStyle(color: Colors.grey)),
            ],
          ),
        )
            : null,
      ),
    );
  }
}
