import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mentormeister/core/utils/basic_screen_imports.dart';
import '../../commons/widgets/custom_appbar.dart';

class FeedBack extends StatefulWidget {
  const FeedBack({Key? key}) : super(key: key);

  @override
  State<FeedBack> createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  double _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primaryBGColor,
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.15),
        child: const Center(
          child: CustomAppBar(title: 'Create Assignment'),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(Dimensions.paddingSize),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Container(
                      child: Image.asset(
                        'assets/students/student.png',
                        height: 50,
                        width: 50,
                      ),
                      // You can add your leading image here
                    ),
                    SizedBox(width: Dimensions.widthSize),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Assignment 1',
                          style: CustomStyle.blackh2,
                        ),
                        RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: 'Rohan',
                                style: TextStyle(color: Colors.red),
                              ),
                              TextSpan(
                                text: ' | ',
                                style: TextStyle(color: Colors.grey),
                              ),
                              TextSpan(
                                text: 'react.js',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: Dimensions.heightSize),
            Text(
              'Would you like to rate your experience?',
              style: CustomStyle.interh1,
            ),
            SizedBox(height: Dimensions.heightSize),
            // Rating stars
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
                allowHalfRating: false,
                itemCount: 5,
                itemSize: 40.0,
                unratedColor: Colors.amber.withAlpha(50),
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
              'Add Feedback here',
              style: CustomStyle.interh1,
            ),
            SizedBox(height: Dimensions.heightSize),
            // Feedback input field
            TextFormField(
              maxLines: 3,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Write here',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
            ),
            SizedBox(height: Dimensions.heightSize),
            // Submit button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Add functionality to submit feedback
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColor.redColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Text(
                  'Give Feedback',
                  style: CustomStyle.whiteh3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
