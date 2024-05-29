import 'dart:async';
import 'package:mentormeister/commons/app/providers/payment_controller.dart';
import 'package:mentormeister/core/utils/basic_screen_imports.dart';
import 'package:mentormeister/core/utils/constants.dart';
import 'package:mentormeister/features/Contact/presentation/widgets/pop_app_bar.dart';
import 'package:mentormeister/features/payment/data/models/course_payment_model.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class CoursePaymentPage extends StatelessWidget {
  CoursePaymentPage({
    Key? key,
    this.coursePaymentModel,
  }) : super(key: key);

  final CoursePaymentModel? coursePaymentModel;

  final Completer<WebViewController> webviewController =
      Completer<WebViewController>();

  late WebViewController controllerGlobal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWithPop(
        text: 'Payment Methods',
      ),
      body: Consumer<PaymentController>(
        builder: (context, controller, child) {
          return SafeArea(
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    WebView(
                      initialUrl: appBaseUrl,
                      javascriptMode: JavascriptMode.unrestricted,
                      onWebViewCreated: (WebViewController controller) {
                        controllerGlobal = controller;
                      },
                      onProgress: (int progress) {
                        if (progress < 100) {
                          controller.setLoading = true;
                        } else {
                          controller.setLoading = false;
                        }
                      },
                      onPageFinished: (String url) {
                        controller.redirect(
                          url: url,
                          context: context,
                          isSubscription: false,
                          coursePaymentModel: coursePaymentModel,
                        );
                      },
                    ),
                    controller.isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                CustomColor.redColor,
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  static const routeName = '/course-payment';
}

// Personal Payment Account Test
//sb-yky47i28028844@personal.example.com
//123@paypal