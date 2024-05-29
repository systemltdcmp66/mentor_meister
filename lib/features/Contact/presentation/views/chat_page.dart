import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mentormeister/commons/widgets/no_found_text.dart';
import 'package:mentormeister/core/services/injection_container.dart';
import 'package:mentormeister/core/utils/basic_screen_imports.dart';
import 'package:mentormeister/core/utils/core_utils.dart';
import 'package:mentormeister/features/Contact/presentation/widgets/chat_list.dart';
import 'package:mentormeister/features/Contact/presentation/widgets/contact_app_bar.dart';
import 'package:mentormeister/features/Contact/utils/chat_utils.dart';
import 'package:mentormeister/features/Message/data/models/message_list_model.dart';
import 'package:mentormeister/features/Message/presentation/bloc/message_bloc.dart';
import 'package:mentormeister/features/Message/presentation/bloc/message_event.dart';
import 'package:mentormeister/features/Message/presentation/bloc/message_state.dart';

class ChatPage extends StatefulWidget {
  final Map<String, dynamic> chatData;
  const ChatPage({
    required this.chatData,
    super.key,
  });

  static const routeName = '/chat';

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late TextEditingController messageController;

  File? image;
  late String documentId;
  late String toUid;
  late String? toAvatar;
  late String toName;

  @override
  void initState() {
    super.initState();
    messageController = TextEditingController();
    documentId = widget.chatData['documentId'];
    toUid = widget.chatData['toUid'];
    toAvatar = widget.chatData['toAvatar'];
    toName = widget.chatData['toName'];
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ContactAppBar(
        name: toName,
        toAvatar: toAvatar,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: ChatUtils.getMessages(
          documentId,
        ),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const NoFoundtext(
              'Error getting all the messages ...',
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  CustomColor.redColor,
                ),
              ),
            );
          } else {
            final messages = snapshot.data!.docs
                .map(
                  (e) => MessageListModel.fromMap(
                    e.data() as Map<String, dynamic>,
                  ),
                )
                .toList();
            return BlocConsumer<MessageBloc, MessageState>(
              listener: (_, state) {
                if (state is MessageError) {
                  CoreUtils.showSnackar(
                    context: context,
                    message: state.message,
                  );
                } else if (state is MessageSent) {
                  messageController.clear();
                  FocusScope.of(context).unfocus();
                }
              },
              builder: (context, state) {
                return SafeArea(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints.expand(),
                    child: Stack(
                      children: [
                        ChatList(
                          toUid: toUid,
                          messages: messages,
                        ),
                        Positioned(
                          bottom: 2.h,
                          height: 50,
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width - 70.w,
                                height: 50.h,
                                margin: EdgeInsets.only(
                                  left: 2.w,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    10.r,
                                  ),
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                ),
                                child: TextFormField(
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 3,
                                  controller: messageController,
                                  onTapOutside: (_) {
                                    FocusScope.of(context).unfocus();
                                  },
                                  autofocus: false,
                                  decoration: InputDecoration(
                                    hintText: 'Send Messages ...',
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.all(
                                      10.w,
                                    ),
                                  ),
                                ),
                              ),
                              StatefulBuilder(
                                builder: (context, refresh) {
                                  messageController.addListener(
                                    () {
                                      refresh(() {});
                                    },
                                  );
                                  return Row(
                                    children: [
                                      Container(
                                        height: 30.w,
                                        width: 30.w,
                                        margin: EdgeInsets.only(
                                          left: 5.w,
                                        ),
                                        child: GestureDetector(
                                          child: const Icon(
                                            Icons.photo_outlined,
                                          ),
                                          onTap: () async {
                                            final img =
                                                await ImagePicker().pickImage(
                                              source: ImageSource.gallery,
                                            );

                                            if (img != null) {
                                              image = File(img.path);
                                              final messageList =
                                                  MessageListModel(
                                                addTime: Timestamp.now(),
                                                content: image!.path,
                                                uid: sl<FirebaseAuth>()
                                                    .currentUser!
                                                    .uid,
                                                isContentAnImage: true,
                                              );
                                              if (context.mounted) {
                                                context.read<MessageBloc>().add(
                                                      SendMessageEvent(
                                                        messageList:
                                                            messageList,
                                                        documentId: documentId,
                                                      ),
                                                    );
                                              }
                                            }
                                          },
                                        ),
                                      ),
                                      state is! SendingMessage
                                          ? messageController.text.isEmpty ||
                                                  messageController.text
                                                          .trim() ==
                                                      ''
                                              ? const SizedBox.shrink()
                                              : GestureDetector(
                                                  onTap: () {
                                                    final messageList =
                                                        MessageListModel(
                                                      addTime: Timestamp.now(),
                                                      content: messageController
                                                          .text
                                                          .trim(),
                                                      uid: sl<FirebaseAuth>()
                                                          .currentUser!
                                                          .uid,
                                                      isContentAnImage: false,
                                                    );
                                                    context
                                                        .read<MessageBloc>()
                                                        .add(
                                                          SendMessageEvent(
                                                            messageList:
                                                                messageList,
                                                            documentId:
                                                                documentId,
                                                          ),
                                                        );
                                                  },
                                                  child: Image.asset(
                                                    'assets/icons/message.png',
                                                    width: 30.w,
                                                    height: 30.w,
                                                    fit: BoxFit.cover,
                                                  ),
                                                )
                                          : const Center(
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  CustomColor.redColor,
                                                ),
                                              ),
                                            ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
