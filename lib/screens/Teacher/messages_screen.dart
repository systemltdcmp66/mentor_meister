import 'package:mentormeister/utils/basic_screen_imports.dart';

import '../../widget/custom_appbar.dart';

class MsgScreen extends StatelessWidget {
  const MsgScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primaryBGColor,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height*0.15),
          child: const CustomAppBar(title: 'Message', centerTitle: true,)),
      body: Padding(
        padding: EdgeInsets.all(Dimensions.paddingSize),
        child: ListView.builder(
          itemCount: messages.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              elevation: 0,
              child: ListTile(
                leading: Card(
                  clipBehavior: Clip.antiAlias,
                  child: Image(
                    image: AssetImage(messages[index].imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(messages[index].title),
                subtitle: Text(messages[index].subtitle),
                trailing: Padding(
                  padding: EdgeInsets.only(bottom: 30.r),
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(50.r), topLeft: Radius.circular(50.r)),
                    ),
                    child: Center(
                      child: Text(
                        messages[index].badge.toString(),
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class Message {
  final String title;
  final String subtitle;
  final int badge;
  final String imageUrl;

  Message({
    required this.title,
    required this.subtitle,
    required this.badge,
    required this.imageUrl,
  });
}

// Sample data
List<Message> messages = [
  Message(
    title: 'John Wick',
    subtitle: 'Hey, I just checked that you hired me.',
    badge: 2,
    imageUrl: 'assets/students/student.png',
  ),
  Message(
    title: 'John Wick',
    subtitle: 'Hey, I just checked that you hired me.',
    badge: 2,
    imageUrl: 'assets/students/student.png',
  ),
  Message(
    title: 'Tony Stark',
    subtitle: 'Hey, I just checked that you hired me',
    badge: 2,
    imageUrl: 'assets/students/student.png',
  ),

];


