import 'package:mentormeister/core/utils/basic_screen_imports.dart';
import 'package:mentormeister/core/utils/typedefs.dart';
import 'package:mentormeister/features/Contact/presentation/widgets/pop_app_bar.dart';

class PhotoView extends StatelessWidget {
  const PhotoView({
    super.key,
    required this.arguments,
  });

  final DataMap arguments;

  static const routeName = '/photo-view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const AppBarWithPop(
        text: 'You',
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          child: Image.network(
            arguments['image'] as String,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
