import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mentormeister/core/utils/basic_screen_imports.dart';
import 'package:mentormeister/commons/widgets/custom_button.dart';
import '../../commons/widgets/custom_appbar.dart';

class MeetingReportPage extends StatefulWidget {
  const MeetingReportPage({super.key});

  @override
  State<MeetingReportPage> createState() => _MeetingReportPageState();
}

class _MeetingReportPageState extends State<MeetingReportPage> {
  double _rating = 3.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomColor.primaryBGColor,
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.15),
        child: const CustomAppBar(
          title: 'All Meetings Report',
          centerTitle: true,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                'All meetings reports\nTeacher Performance',
                style: CustomStyle.interh1,
              ),
            ),
            SizedBox(height: Dimensions.heightSize),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildPercentageIndicator(33, 'Relevant'),
                _buildPercentageIndicator(50, 'Non-Relevant'),
              ],
            ),
            SizedBox(height: Dimensions.heightSize),
            Text(
              'Would you like to rate your experience?',
              style: CustomStyle.interh2,
            ),
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color(0xfffd5900), Color(0xffffde00)],
                ).createShader(
                  Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                );
              },
              child: RatingBar.builder(
                initialRating: _rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 40.0,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    _rating = rating;
                  });
                },
              ),
            ),
            SizedBox(height: Dimensions.heightSize),
            Text(
              'Add feedback here',
              style: CustomStyle.interh2,
            ),
            SizedBox(height: Dimensions.heightSize),
            TextFormField(
              decoration: const InputDecoration(
                filled: true,
                focusColor: CustomColor.redColor,
                hintText: 'Write here...',
                border: InputBorder.none,
              ),
              maxLines: 2,
            ),
            SizedBox(height: Dimensions.heightSize),
            CustomButton(text: 'Done', onPressed: () {})
          ],
        ),
      ),
    );
  }

  Widget _buildPercentageIndicator(int percentage, String text) {
    return Column(
      children: [
        SizedBox(
          width: 100.w,
          height: 100.h,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 80.h,
                width: 80.h,
                child: CircularProgressIndicator(
                  value: percentage / 100,
                  strokeWidth: 10,
                  backgroundColor: Colors.grey[300],
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(CustomColor.redColor),
                ),
              ),
              Text(
                '$percentage%',
                style: const TextStyle(fontSize: 18, color: Colors.black),
              ),
            ],
          ),
        ),
        SizedBox(height: Dimensions.heightSize),
        Text(text, style: CustomStyle.interh2),
      ],
    );
  }
}
