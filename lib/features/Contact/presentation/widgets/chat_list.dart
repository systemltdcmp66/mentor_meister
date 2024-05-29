import 'package:mentormeister/core/utils/basic_screen_imports.dart';
import 'package:mentormeister/features/Contact/presentation/widgets/chat_left_item.dart';
import 'package:mentormeister/features/Contact/presentation/widgets/chat_right_item.dart';
import 'package:mentormeister/features/Message/data/models/message_list_model.dart';

class ChatList extends StatefulWidget {
  const ChatList({
    super.key,
    required this.toUid,
    required this.messages,
  });

  final String toUid;
  final List<MessageListModel> messages;

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  late ScrollController messageScrolling;

  @override
  void initState() {
    super.initState();
    messageScrolling = ScrollController();
  }

  @override
  void dispose() {
    messageScrolling.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: CustomColor.redColor,
      padding: EdgeInsets.only(
        bottom: 50.h,
      ),
      child: CustomScrollView(
        reverse: true,
        controller: messageScrolling,
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 0,
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: widget.messages.length,
                (context, index) {
                  var item = widget.messages[index];
                  if (widget.toUid != item.uid) {
                    return ChatRightItem(
                      item: item,
                    );
                  }
                  return ChatLeftItem(
                    item: item,
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
