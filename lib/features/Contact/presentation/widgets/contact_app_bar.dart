import 'package:mentormeister/core/utils/basic_screen_imports.dart';

class ContactAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ContactAppBar({
    super.key,
    required this.name,
    this.toAvatar,
  });

  final String name;
  final String? toAvatar;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110.h,
      color: Colors.black,
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          CircleAvatar(
            radius: 35.r,
            backgroundColor: CustomColor.whiteColor,
            backgroundImage: toAvatar == null ||
                    toAvatar!.contains('assets/students/default_user.png')
                ? const AssetImage('assets/students/default_user.png')
                : NetworkImage(toAvatar!) as ImageProvider,
          ),
          SizedBox(
            width: 10.w,
          ),
          Text(
            name,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        110.h,
      );
}
