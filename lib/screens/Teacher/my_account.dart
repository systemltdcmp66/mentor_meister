
import 'package:mentormeister/screens/Subscription/subscription_plan_page.dart';
import 'package:mentormeister/utils/basic_screen_imports.dart';

import '../../widget/custom_appbar.dart';
import '../Subscription/rate_us.dart';

class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height*0.15),
          child: const CustomAppBar(title: 'My Account')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ///set to true when user have active subscription plan
              _buildSubscriptionPlan(false, (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const SubscriptionPlanPage()));
              }),
              _buildAccountSection(),
              _buildRowWithIconAndText(Icons.person, 'Profile', (){}),
              _buildRowWithIconAndText(Icons.lock, 'Account Preference',(){}),
              _buildRowWithIconAndText(Icons.star, 'Rate Us',(){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const RateUs()));
              }),
              _buildRowWithIconAndText(Icons.privacy_tip, 'Privacy Policy',(){}),
              _buildRowWithIconAndText(Icons.support, 'Student Support',(){}),
              _buildRowWithIconAndText(Icons.description, 'Terms and Conditions',(){}),
              _buildRowWithIconAndText(Icons.question_answer, 'FAQ',(){}),
              _buildRowWithIconAndText(Icons.help, 'Help',(){}),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubscriptionPlan(bool isSubscribed, VoidCallback onPressed) {
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
                      'Year Package',
                      style: CustomStyle.whiteh3,
                    ),
                    Text(
                      'Valid Till',
                      style: CustomStyle.whiteh3,
                    ),
                  ],
                ),

                SizedBox(height: Dimensions.heightSize),
                Row(
                  mainAxisAlignment: mainSpaceBet,
                  children: [
                    Text(
                      'Monthly \$50',
                      style: CustomStyle.whiteh2,
                    ),
                    Text(
                      '31 December,2024',
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
              Image.asset('assets/teacher/crown.png', height: 62.h, width: 70.w,),
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

  Widget _buildRowWithIconAndText(IconData icon, String text, VoidCallback onPressed) {
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
              style:CustomStyle.interh3,
            ),
          ),
          IconButton(icon: const Icon(Icons.arrow_forward_ios), onPressed: onPressed,),
        ],
      ),
      
    );
  }
}

