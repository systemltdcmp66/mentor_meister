import 'package:mentormeister/core/utils/basic_screen_imports.dart';

class NoFoundtext extends StatelessWidget {
  const NoFoundtext(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.black.withOpacity(.5),
                fontSize: 30,
              ),
        ),
      ),
    );
  }
}
