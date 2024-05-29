import 'package:firebase_auth/firebase_auth.dart';
import 'package:mentormeister/commons/app/providers/chat_provider.dart';
import 'package:mentormeister/commons/widgets/no_found_text.dart';
import 'package:mentormeister/core/services/injection_container.dart';
import 'package:mentormeister/core/utils/basic_screen_imports.dart';
import 'package:mentormeister/features/Contact/presentation/views/chat_page.dart';
import 'package:mentormeister/features/Contact/utils/chat_utils.dart';
import 'package:mentormeister/features/Teacher/my_courses/custom_app_bar.dart';
import 'package:provider/provider.dart';

class MsgScreen extends StatefulWidget {
  const MsgScreen({Key? key}) : super(key: key);

  @override
  State<MsgScreen> createState() => _MsgScreenState();
}

class _MsgScreenState extends State<MsgScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ChatProvider>().loadAllMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primaryBGColor,
      appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.15),
          child: const CustomAppBarWithPop(
            text: 'Message',
          )),
      body: Consumer<ChatProvider>(
        builder: (context, provider, child) {
          return provider.isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      CustomColor.redColor,
                    ),
                  ),
                )
              : provider.mesagelist.isEmpty
                  ? const NoFoundtext(
                      'No messages, Please text someone in'
                      ' order to see your last messages here.',
                    )
                  : Padding(
                      padding: EdgeInsets.all(Dimensions.paddingSize),
                      child: ListView.builder(
                        itemCount:
                            context.read<ChatProvider>().mesagelist.length,
                        itemBuilder: (BuildContext context, int index) {
                          final item = provider.mesagelist[index];
                          bool? from = item.toAvatar == null
                              ? null
                              : (item.toAvatar != null &&
                                      item.toAvatar!.contains(
                                          'assets/students/default_user.png'))
                                  ? true
                                  : false;

                          bool? to = item.fromAvatar == null
                              ? null
                              : (item.fromAvatar != null &&
                                      item.fromAvatar!.contains(
                                          'assets/students/default_user.png'))
                                  ? true
                                  : false;

                          return Card(
                            elevation: 0,
                            child: ListTile(
                              onTap: () {
                                var toUid = "";
                                var toName = "";
                                var toAvatar = "";

                                if (item.fromUid ==
                                    sl<FirebaseAuth>().currentUser!.uid) {
                                  toUid = item.toUid;
                                  toName = item.toName;
                                  toAvatar = item.toAvatar ??
                                      "assets/students/default_user.png";
                                } else {
                                  toUid = item.fromUid;
                                  toName = item.fromName;
                                  toAvatar = item.fromAvatar ??
                                      "assets/students/default_user.png";
                                }
                                Navigator.of(context).pushNamed(
                                  ChatPage.routeName,
                                  arguments: {
                                    'documentId': item.id,
                                    'toUid': toUid,
                                    'toName': toName,
                                    'toAvatar': toAvatar,
                                  },
                                );
                              },
                              title: item.lastMessage.contains(
                                      'https://firebasestorage.googleapis.com')
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.fromUid ==
                                                  sl<FirebaseAuth>()
                                                      .currentUser!
                                                      .uid
                                              ? item.toName
                                              : item.fromName,
                                        ),
                                        SizedBox(
                                          height: 4.h,
                                        ),
                                        Icon(
                                          Icons.photo,
                                          size: 19.sp,
                                        ),
                                      ],
                                    )
                                  : Text(
                                      item.fromUid ==
                                              sl<FirebaseAuth>()
                                                  .currentUser!
                                                  .uid
                                          ? item.toName
                                          : item.fromName,
                                    ),
                              subtitle: item.lastMessage.contains(
                                      'https://firebasestorage.googleapis.com')
                                  ? const SizedBox.shrink()
                                  : Text(
                                      item.lastMessage,
                                    ),
                              trailing: Text(
                                ChatUtils.duTimeLineFormat(
                                  item.messageSendAt,
                                ),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: CustomColor.redColor,
                                ),
                              ),
                              leading: Card(
                                clipBehavior: Clip.antiAlias,
                                child: Image(
                                  image: item.fromUid ==
                                          sl<FirebaseAuth>().currentUser!.uid
                                      ? ((from == null || from)
                                          ? const AssetImage(
                                              'assets/students/default_user.png')
                                          : NetworkImage(item.toAvatar!)
                                              as ImageProvider)
                                      : ((to == null || to)
                                          ? const AssetImage(
                                              'assets/students/default_user.png')
                                          : NetworkImage(item.fromAvatar!)
                                              as ImageProvider),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
        },
      ),
    );
  }
}
