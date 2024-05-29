import 'package:mentormeister/core/utils/basic_screen_imports.dart';
import 'package:mentormeister/features/Contact/presentation/views/photo_view.dart';
import 'package:mentormeister/features/Message/data/models/message_list_model.dart';

class ChatLeftItem extends StatelessWidget {
  const ChatLeftItem({
    super.key,
    required this.item,
  });

  final MessageListModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        right: 15.w,
        left: 15.w,
        bottom: 10.h,
        top: 10.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 240.w,
              minHeight: 40.h,
            ),
            child: Container(
              margin: EdgeInsets.only(
                right: 10.w,
                top: 10.h,
              ),
              padding: EdgeInsets.only(
                top: 10.w,
                left: 10.w,
                right: 10.w,
                bottom: 10.w,
              ),
              decoration: BoxDecoration(
                color: CustomColor.blackColor,
                borderRadius: BorderRadius.circular(
                  10,
                ),
              ),
              child: !item.isContentAnImage
                  ? Text(
                      item.content,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    )
                  : ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 90.w,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            PhotoView.routeName,
                            arguments: {
                              'image': item.content,
                              'time': item.addTime,
                            },
                          );
                        },
                        child: Image.network(
                          item.content as String,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
