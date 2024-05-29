import 'package:mentormeister/core/utils/basic_screen_imports.dart';
import 'package:mentormeister/commons/widgets/custom_button.dart';
import 'package:mentormeister/features/Teacher/data/models/teacher_info_model.dart';
import '../../commons/widgets/custom_appbar.dart';

class MsgTeacher extends StatefulWidget {
  const MsgTeacher({
    required this.teacherInfoModel,
    Key? key,
  }) : super(key: key);

  final TeacherInfoModel teacherInfoModel;

  static const routeName = '/msg-teacher';

  @override
  State<MsgTeacher> createState() => _MsgTeacherState();
}

class _MsgTeacherState extends State<MsgTeacher> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primaryBGColor,
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.15),
        child: const CustomAppBar(
          title: 'Messages',
          centerTitle: true,
        ),
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
                  child: widget.teacherInfoModel.profilePic!
                          .contains('assets/defaults/default_course.png')
                      ? Image.asset(
                          'assets/defaults/default_course.png',
                          height: 60.h,
                          width: 60.h,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          widget.teacherInfoModel.profilePic!,
                          height: 60.h,
                          width: 60.h,
                          fit: BoxFit.cover,
                        ),
                  // Image(
                  //   image: AssetImage(imageUrl),
                  //   fit: BoxFit.cover,
                  // ),
                ),
                title: Text(
                    '${widget.teacherInfoModel.firstName} ${widget.teacherInfoModel.lastName}'),
                subtitle: Row(
                  children: [
                    Icon(
                      Icons.file_copy_sharp,
                      size: Dimensions.iconSizeDefault,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      widget.teacherInfoModel.subjectTaught,
                    ),
                  ],
                ),
              ),
            ),
            Text(
              'Write your msg here',
              style: CustomStyle.interh2,
            ),
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
            SizedBox(
              height: 50.h,
            ),
            CustomButton(
              text: 'Send Message',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
