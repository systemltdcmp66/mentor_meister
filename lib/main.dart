import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentormeister/commons/app/providers/chat_provider.dart';
import 'package:mentormeister/commons/app/providers/courses_provider.dart';
import 'package:mentormeister/commons/app/providers/payment_controller.dart';
import 'package:mentormeister/commons/app/providers/subscription_provider.dart';
import 'package:mentormeister/commons/app/providers/teacher_provider.dart';
import 'package:mentormeister/commons/app/providers/teacher_sign_up_controller.dart';
import 'package:mentormeister/commons/app/providers/user_provider.dart';
import 'package:mentormeister/core/services/injection_container.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'core/services/router.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    androidProvider: AndroidProvider.debug,
  );
  // Locking Device Orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: (context, _) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => UserProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => TeacherSignUpController(),
          ),
          ChangeNotifierProvider(
            create: (_) => CoursesProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => TeacherProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => ChatProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => PaymentController(),
          ),
          ChangeNotifierProvider(
            create: (_) => SubscriptionProvider(),
          ),
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: generateRoute,
        ),
      ),
    );
  }
}
