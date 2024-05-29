import 'dart:async';
import 'package:mentormeister/commons/app/providers/payment_controller.dart';
import 'package:mentormeister/core/utils/basic_screen_imports.dart';
import 'package:mentormeister/core/utils/constants.dart';
import 'package:mentormeister/features/Contact/presentation/widgets/pop_app_bar.dart';
import 'package:mentormeister/features/payment/data/models/hiring_model.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class HiringPaymentPage extends StatelessWidget {
  HiringPaymentPage({
    Key? key,
    required this.hiringModel,
  }) : super(key: key);

  final HiringModel hiringModel;

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
                        controller.redirect2(
                          url: url,
                          context: context,
                          hiringModel: hiringModel,
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

  static const routeName = '/hiring-payment';
}

// Personal Payment Account Test
//sb-yky47i28028844@personal.example.com
//123@paypal