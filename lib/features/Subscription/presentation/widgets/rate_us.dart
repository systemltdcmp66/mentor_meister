import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mentormeister/core/services/injection_container.dart';
import 'package:mentormeister/core/utils/basic_screen_imports.dart';
import 'package:mentormeister/commons/widgets/custom_button.dart';
import 'package:mentormeister/core/utils/core_utils.dart';
import 'package:mentormeister/features/Teacher/data/models/feedback_model.dart';
import 'package:mentormeister/features/Teacher/presentation/app/feedback_cubit/feedback_cubit.dart';
import 'package:mentormeister/features/Teacher/presentation/app/feedback_cubit/feedback_state.dart';

import '../../../../commons/widgets/custom_appbar.dart';

class RateUs extends StatefulWidget {
  const RateUs({
    super.key,
  });

  @override
  State<RateUs> createState() => _RateUsState();

  static const routeName = '/rate-us';
}

class _RateUsState extends State<RateUs> {
  late TextEditingController feebackTextController;

  final formKey = GlobalKey<FormState>();

  double starRating = 1;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    feebackTextController = TextEditingController();
  }

  @override
  void dispose() {
    feebackTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primaryBGColor,
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.15),
        child: const CustomAppBar(
          title: 'Rate',
        ),
      ),
      body: BlocListener<FeedbackCubit, FeedbackState>(
        listener: (_, state) {
          if (state is FeedbackError) {
            CoreUtils.showSnackar(
              context: context,
              message: state.message,
            );
          } else if (state is SendingFeedback) {
            isLoading = true;
            CoreUtils.showSpinningLoader(context);
          } else if (state is FeedbackSent) {
            if (isLoading) {
              isLoading = false;
              Navigator.of(context).pop();
            }

            CoreUtils.showSnackar(
              context: context,
              message: 'Thanks for your feedback !',
            );
            Navigator.of(context).pop();
          }
        },
        child: Form(
          key: formKey,
          child: Padding(
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
                        Image.asset(
                          'assets/subscription/thumbs_up.png',
                          height: 150.h,
                          width: 150.w,
                        ),

                        SizedBox(height: Dimensions.heightSize),

                        Container(
                            padding: EdgeInsets.all(10.r),
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                border: Border.all(color: Colors.grey)),
                            child: Column(
                              children: [
                                Text('Enjoy our app',
                                    textAlign: TextAlign.center,
                                    style: CustomStyle.interh2),
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
                                      Rect.fromLTWH(
                                        0,
                                        0,
                                        bounds.width,
                                        bounds.height,
                                      ),
                                    );
                                  },
                                  child: RatingBar.builder(
                                    initialRating: starRating,
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
                                        starRating = rating;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            )),

                        SizedBox(height: Dimensions.heightSize),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Send feedback',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                            height: 10), // Space between text and text field

                        // Text field for entering review
                        TextFormField(
                          controller: feebackTextController,
                          onTapOutside: (event) {
                            FocusScope.of(context).unfocus();
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'The feeback text is required';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            hintText: 'Enter review here',
                            border: InputBorder.none,
                          ),
                          maxLines: 5,
                        ),
                        CustomButton(
                          text: 'Rate Now',
                          onPressed: () {
                            if (starRating == 0) {
                              CoreUtils.showSnackar(
                                context: context,
                                message: 'Choose at least one star',
                              );
                            } else {
                              if (formKey.currentState!.validate()) {
                                final now = DateTime.now();
                                final userFeedback =
                                    FeedbackModel.empty().copyWith(
                                  userId: sl<FirebaseAuth>().currentUser!.uid,
                                  numberOfStars: starRating.toInt(),
                                  text: feebackTextController.text.trim(),
                                  sendAt: now,
                                );
                                context
                                    .read<FeedbackCubit>()
                                    .sendFeedback(userFeedback);
                              }
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
