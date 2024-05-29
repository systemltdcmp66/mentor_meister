import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentormeister/commons/app/providers/user_provider.dart';
import 'package:mentormeister/commons/widgets/no_found_text.dart';
import 'package:mentormeister/core/services/injection_container.dart';
import 'package:mentormeister/core/utils/basic_screen_imports.dart';
import 'package:mentormeister/core/utils/core_utils.dart';
import 'package:mentormeister/features/Contact/presentation/views/chat_page.dart';
import 'package:mentormeister/features/Message/data/models/message_model.dart';
import 'package:mentormeister/features/Onboarding&Authentication/data/models/user_model.dart';
import 'package:mentormeister/features/Onboarding&Authentication/presentation/app/authentication_bloc/authentication_bloc.dart';
import 'package:mentormeister/features/Teacher/my_courses/custom_app_bar.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  void initState() {
    super.initState();
    context.read<AuthenticationBloc>().add(
          const GetAllUsersEvent(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWithPop(
        text: 'Contacts',
      ),
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (_, state) {
          if (state is AuthenticationError) {
            CoreUtils.showSnackar(
              context: context,
              message: state.message,
            );
          }
        },
        builder: (context, state) {
          if (state is AuthenticationLoading) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  CustomColor.redColor,
                ),
              ),
            );
          } else if (state is AllUsersFetched && state.users.isEmpty) {
            return const NoFoundtext(
              "No contacts. All the users/teachers' "
              'contacts will be displayed here.',
            );
          } else if ((state is AllUsersFetched && state.users.isNotEmpty)) {
            final contacts = (state.users as List<LocalUserModel>)
              ..sort(
                (a, b) => a.name.compareTo(
                  b.name,
                ),
              );
            return ListView.builder(
              itemCount: contacts.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final contact = contacts[index];

                return ListTile(
                  contentPadding: EdgeInsets.only(
                    left: 20.w,
                    right: 20.w,
                    top: 20.w,
                    bottom: 5.h,
                  ),
                  leading: CircleAvatar(
                    radius: 35.r,
                    backgroundColor: Colors.white,
                    backgroundImage: contact.profilePic == null ||
                            contact.profilePic!
                                .contains('assets/students/default_user.png')
                        ? const AssetImage(
                            'assets/students/default_user.png',
                          ) as ImageProvider
                        : NetworkImage(
                            contact.profilePic!,
                          ) as ImageProvider,
                  ),
                  title: Text(
                    contact.name,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () async {
                    final fromMessages = await sl<FirebaseFirestore>()
                        .collection('messages')
                        .where(
                          'fromUid',
                          isEqualTo: sl<FirebaseAuth>().currentUser!.uid,
                        )
                        .where(
                          'toUid',
                          isEqualTo: contact.uid,
                        )
                        .get();

                    final toMessages = await sl<FirebaseFirestore>()
                        .collection('messages')
                        .where(
                          'fromUid',
                          isEqualTo: contact.uid,
                        )
                        .where(
                          'toUid',
                          isEqualTo: sl<FirebaseAuth>().currentUser!.uid,
                        )
                        .get();
                    if (fromMessages.docs.isEmpty && toMessages.docs.isEmpty) {
                      if (context.mounted) {
                        final UserMessageModel msg = UserMessageModel(
                          fromName: context.read<UserProvider>().user!.name,
                          toName: contact.name,
                          messageSendAt: DateTime.now(),
                          lastMessage: '',
                          fromUid: sl<FirebaseAuth>().currentUser!.uid,
                          toUid: contact.uid,
                          fromAvatar: sl<FirebaseAuth>().currentUser!.photoURL,
                          toAvatar: contact.profilePic,
                        );

                        await sl<FirebaseFirestore>()
                            .collection('messages')
                            .add(msg.toMap())
                            .then(
                          (DocumentReference doc) {
                            Navigator.of(context).pushNamed(
                              ChatPage.routeName,
                              arguments: {
                                'documentId': doc.id,
                                'toUid': contact.uid,
                                'toName': contact.name,
                                'toAvatar': contact.profilePic,
                              },
                            );
                          },
                        );
                      }
                    } else if (fromMessages.docs.isNotEmpty) {
                      if (context.mounted) {
                        Navigator.of(context).pushNamed(
                          ChatPage.routeName,
                          arguments: {
                            'documentId': fromMessages.docs.first.id,
                            'toUid': contact.uid,
                            'toName': contact.name,
                            'toAvatar': contact.profilePic,
                          },
                        );
                      }
                    } else if (toMessages.docs.isNotEmpty) {
                      if (context.mounted) {
                        Navigator.of(context).pushNamed(
                          ChatPage.routeName,
                          arguments: {
                            'documentId': toMessages.docs.first.id,
                            'toUid': contact.uid,
                            'toName': contact.name,
                            'toAvatar': contact.profilePic,
                          },
                        );
                      }
                    }
                  },
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
