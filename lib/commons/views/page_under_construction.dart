import 'package:lottie/lottie.dart';
import 'package:mentormeister/core/utils/basic_screen_imports.dart';

class PageUnderConstruction extends StatelessWidget {
  const PageUnderConstruction({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Lottie.asset(
            'assets/lottie/page_under_construction.json',
          ),
        ),
      ),
    );
  }
}
