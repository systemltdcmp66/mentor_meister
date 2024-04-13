import 'package:mentormeister/utils/basic_screen_imports.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool includeBookmarkIcon; // Flag to include bookmark icon
  final VoidCallback? onBookmarkPressed;
  final IconData? icon; // Icon for actions
  final List<Widget>? actions; // List of additional actions
  final bool centerTitle; // Flag to center title

  const CustomAppBar({super.key, 
    required this.title,
    this.includeBookmarkIcon = false,
    this.onBookmarkPressed,
    this.icon,
    this.actions,
    this.centerTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColor.blackColor,
      padding: EdgeInsets.only(top: 30.h),
      child: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
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
              child: Icon(Icons.arrow_back_ios, color: CustomColor.whiteColor,),
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          title,
          style: CustomStyle.whiteh1,
          textAlign: centerTitle ? TextAlign.center : TextAlign.start,
        ),
        centerTitle: centerTitle,
        actions: _buildActions(),
      ),
    );
  }

  List<Widget> _buildActions() {
    List<Widget> appBarActions = [];

    // Add custom icon action
    if (icon != null) {
      appBarActions.add(
        IconButton(
          icon: Icon(icon, color: CustomColor.whiteColor,),
          onPressed: () {},
        ),
      );
    }

    // Add bookmark icon action if includeBookmarkIcon is true
    if (includeBookmarkIcon) {
      appBarActions.add(
        IconButton(
          icon: const Icon(Icons.bookmark),
          onPressed: onBookmarkPressed,
        ),
      );
    }

    // Add additional actions
    if (actions != null) {
      appBarActions.addAll(actions!);
    }

    return appBarActions;
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
