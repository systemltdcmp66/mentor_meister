import 'package:mentormeister/utils/basic_screen_imports.dart';
import 'package:mentormeister/widget/custom_button.dart';
import '../../widget/custom_appbar.dart';

class MsgTeacher extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String subtitle;

  const MsgTeacher({
    required this.imageUrl,
    required this.name,
    required this.subtitle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primaryBGColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.15),
        child: const CustomAppBar(title: 'Messages', centerTitle: true,),
      ),
      body: Padding(
        padding: EdgeInsets.all(Dimensions.paddingSize),
        child: Column(
          crossAxisAlignment: crossStart,
          children: [
            Card(
              elevation: 0,
              child: ListTile(
                leading: Card(
                  clipBehavior: Clip.antiAlias,
                  child: Image(
                    image: AssetImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(name),
                subtitle: Row(children: [Icon(Icons.file_copy_sharp, size: Dimensions.iconSizeDefault,),
                  const SizedBox(width: 5,),
                  Text(subtitle)],),
              ),
            ),
            Text('Write your msg here', style: CustomStyle.interh2,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: InputBorder.none,
                  hintText: 'Write here...',
                ),
                maxLines: 8,
              ),
            ),
          SizedBox(height: 50.h,),
          CustomButton(text: 'Send Message', onPressed: (){}),
          ],
        ),
      ),
    );
  }
}
