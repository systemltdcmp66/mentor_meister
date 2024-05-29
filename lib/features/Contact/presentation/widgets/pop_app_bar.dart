import 'package:mentormeister/core/utils/basic_screen_imports.dart';

class AppBarWithPop extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWithPop({
    required this.text,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: 150,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.only(left: 6),
              height: 38,
              width: 38,
              decoration: BoxDecoration(
                color: CustomColor.whiteColor.withOpacity(0.1),
                borderRadius: const BorderRadius.all(Radius.circular(5)),
              ),
              child: const Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.arrow_back_ios,
                  color: CustomColor.whiteColor,
                ),
              ),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              text,
              style: CustomStyle.whiteh1,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(150);
}
