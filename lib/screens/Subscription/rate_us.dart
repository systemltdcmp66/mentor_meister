import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mentormeister/utils/basic_screen_imports.dart';
import 'package:mentormeister/widget/custom_button.dart';

import '../../widget/custom_appbar.dart';

class RateUs extends StatefulWidget {
  const RateUs({super.key, Key? key});

  @override
  State<RateUs> createState() => _RateUsState();
}

class _RateUsState extends State<RateUs> {
  @override
  Widget build(BuildContext context) {
    double rating = 0;
    return Scaffold(
      backgroundColor: CustomColor.primaryBGColor,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height*0.15),
          child: const CustomAppBar(title: 'Rate')),
      body: Padding(
        padding: EdgeInsets.all(Dimensions.paddingSize),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Card with image at the top
            Card(
              elevation: 0,
              child: Padding(
                padding: EdgeInsets.all(10.r),
                child: Column(
                  children: [
                    Image.asset('assets/subscription/thumbs_up.png', height: 150.h, width: 150.w,),

                    SizedBox(height: Dimensions.heightSize),


                    Container(
                      padding: EdgeInsets.all(10.r),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: Colors.grey)
                      ),
                      child: Column(

                        children: [
                          Text(
                              'Enjoy our app',
                              textAlign: TextAlign.center,
                              style: CustomStyle.interh2
                          ),
                          SizedBox(height: Dimensions.heightSize),

                          // Text
                          const Text(
                            'If you enjoy using our app, please rate us',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
                          ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return const LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Color(0xfffd5900),
                                  Color(0xffffde00)
                                ],
                              ).createShader(
                                Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                              );
                            },
                            child: RatingBar.builder(
                              initialRating: rating,
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
                                  rating = rating;
                                });
                              },
                            ),
                          ),

                        ],
                      )

                    ),

                    SizedBox(height: Dimensions.heightSize),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Send feedback',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 10), // Space between text and text field

                    // Text field for entering review
                    TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        hintText: 'Enter review here',
                        border: InputBorder.none,
                      ),
                      maxLines: 5,
                    ),
                    CustomButton(text: 'Rate Now', onPressed: (){})
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
