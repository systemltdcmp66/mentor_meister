import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentormeister/core/utils/basic_screen_imports.dart';
import 'package:mentormeister/core/utils/constants.dart';
import 'package:mentormeister/features/Teacher/presentation/app/teacher_sign_up_cubit/teacher_sign_up_cubit.dart';
import 'package:mentormeister/features/payment/data/models/course_payment_model.dart';
import 'package:mentormeister/features/payment/data/models/hiring_model.dart';
import 'package:mentormeister/features/payment/data/models/subscription_model.dart';
import 'package:mentormeister/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:mentormeister/features/payment/presentation/widgets/hiring_payment_success.dart';
import 'package:mentormeister/features/payment/presentation/widgets/payment_success.dart';

class PaymentController extends ChangeNotifier {
  bool _isLoading = false;
  bool _status = false;

  bool get isLoading => _isLoading;
  bool get status => _status;

  set setLoading(bool value) {
    if (_isLoading != value) {
      _isLoading = value;
      Future.delayed(
        Duration.zero,
        notifyListeners,
      );
    }
  }

  void redirect2({
    required String url,
    required BuildContext context,
    required HiringModel hiringModel,
  }) {
    if (url.contains('success') && url.contains(appBaseUrl)) {
      _status = true;
      notifyListeners();

      context.read<PaymentCubit>().hiringPayment(
            hiring: hiringModel,
          );
      context.read<TeacherSignUpCubit>().hireATeacher(
            hiringModel.teacherId,
          );

      Navigator.of(context).pushNamedAndRemoveUntil(
        HiringPaymentSuccessPage.routeName,
        (Route<dynamic> route) => false,
      );
    } else if (url.contains('cancel') && url.contains(appBaseUrl)) {
      _status = false;
      notifyListeners();
      Navigator.of(context).pushNamedAndRemoveUntil(
        HiringPaymentSuccessPage.routeName,
        (Route<dynamic> route) => false,
      );
    } else {
      print("Encountered problem");
    }
  }

  void redirect({
    required String url,
    required BuildContext context,
    required bool isSubscription,
    SubscriptionModel? subscription,
    CoursePaymentModel? coursePaymentModel,
  }) {
    if (isSubscription) {
      if (url.contains('success') && url.contains(appBaseUrl)) {
        _status = true;
        notifyListeners();

        context.read<PaymentCubit>().makeSubscription(
              subscription: subscription!,
            );
        Navigator.of(context).pushNamedAndRemoveUntil(
          PaymentSuccessPage.routeName,
          arguments: false,
          (Route<dynamic> route) => false,
        );
      } else if (url.contains('cancel') && url.contains(appBaseUrl)) {
        _status = false;
        notifyListeners();
        Navigator.of(context).pushNamedAndRemoveUntil(
          PaymentSuccessPage.routeName,
          arguments: false,
          (Route<dynamic> route) => false,
        );
      } else {
        print("Encountered problem");
      }
    } else {
      if (url.contains('success') && url.contains(appBaseUrl)) {
        _status = true;
        notifyListeners();
        context.read<PaymentCubit>().paypalPayment(
              coursePayment: coursePaymentModel as CoursePaymentModel,
            );
        Navigator.of(context).pushNamedAndRemoveUntil(
          PaymentSuccessPage.routeName,
          arguments: true,
          (Route<dynamic> route) => false,
        );
      } else if (url.contains('cancel') && url.contains(appBaseUrl)) {
        _status = false;
        notifyListeners();
        Navigator.of(context).pushNamedAndRemoveUntil(
          PaymentSuccessPage.routeName,
          arguments: true,
          (Route<dynamic> route) => false,
        );
      } else {
        print("Encountered problem");
      }
    }
  }
}
