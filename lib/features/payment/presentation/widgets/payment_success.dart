import 'package:mentormeister/commons/app/providers/payment_controller.dart';
import 'package:mentormeister/core/utils/basic_screen_imports.dart';
import 'package:mentormeister/features/Teacher/presentation/widgets/bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class PaymentSuccessPage extends StatefulWidget {
  const PaymentSuccessPage({
    Key? key,
    required this.isCoursePayment,
  }) : super(key: key);

  final bool isCoursePayment;

  @override
  State<PaymentSuccessPage> createState() => _PaymentSuccessPageState();

  static const routeName = '/payment-success';
}

class _PaymentSuccessPageState extends State<PaymentSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentController>(builder: (context, controller, child) {
      return SafeArea(
        child: Scaffold(
          body: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    controller.status
                        ? Icons.check_circle_outline
                        : Icons.warning_amber_outlined,
                    size: 100.sp,
                    color: CustomColor.redColor,
                  ),
                  SizedBox(
                    height: 45.h,
                  ),
                  Text(
                      controller.status
                          ? widget.isCoursePayment
                              ? 'success course enrollment'
                              : 'success subscription payment'
                          : widget.isCoursePayment
                              ? 'course payment failed'
                              : 'subscription payment failed',
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24.sp,
                      )),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 20.h,
                    ),
                    child: Text(
                      controller.status ? 'success payment' : 'payment failed',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 22.sp,
                        color: Theme.of(context).disabledColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: EdgeInsets.all(
                      20.h,
                    ),
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60.h,
                        decoration: BoxDecoration(
                          color: CustomColor.redColor,
                          borderRadius: BorderRadius.circular(
                            25.r,
                          ),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              BottomNavBar.routeName,
                              arguments: widget.isCoursePayment,
                              (route) => false,
                            );
                          },
                          child: Center(
                            child: Text(
                              'Back to home',
                              style: TextStyle(
                                fontSize: 27.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
