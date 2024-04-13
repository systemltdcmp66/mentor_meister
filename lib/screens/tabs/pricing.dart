import 'package:mentormeister/utils/basic_screen_imports.dart';

class Pricing extends StatefulWidget {
  const Pricing({super.key});



  @override
  _PricingState createState() => _PricingState();
}

class _PricingState extends State<Pricing> {
  double hourlyRate = 10.0;
  double coursePrice = 50.0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Set your hourly based rate for live session',
            style: CustomStyle.interh1,
            textAlign: TextAlign.center,

          ),
          SizedBox(height: Dimensions.marginBetweenInputTitleAndBox),
          Text(
            'We recommend an hourly rate of \$10 for new teachers',
            style: CustomStyle.pStyle,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Dimensions.marginBetweenInputTitleAndBox),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              SizedBox(width: Dimensions.widthSize),
              SizedBox(
                width: 80.w,
                child: TextFormField(
                  initialValue: hourlyRate.toString(),
                  onChanged: (value) {
                    setState(() {
                      hourlyRate = double.parse(value);
                    });
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  ),
                ),
              ),
              SizedBox(width: Dimensions.widthSize),
              Text(
                '\$USD',
                style: CustomStyle.interh1.copyWith(fontSize: 20),
              ),
            ],
          ),
          SizedBox(height: Dimensions.heightSize),
          Text(
            'Courses Prices',
            style: CustomStyle.interh1,
          ),
          SizedBox(height: Dimensions.marginBetweenInputTitleAndBox),
          Card(
            elevation: 0,
            color: CustomColor.greyColor,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'The above pricing is only for the live session. For adding the price of the courses go to "My Courses" section, create a course, add lectures, quizzes, assignments, timeline, and the price of the course.\nThe minimum course price according to our terms and conditions is \$50.',
                style: CustomStyle.pBStyle,
                textAlign: TextAlign.start,
              ),
            ),
          ),

        ],
      ),
    );
  }
}
