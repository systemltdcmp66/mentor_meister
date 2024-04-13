import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mentormeister/utils/basic_screen_imports.dart';

import '../../widget/custom_appbar.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_dropdown.dart';

class CreateAssignmentScreen extends StatefulWidget {
  const CreateAssignmentScreen({super.key});

  @override
  _CreateAssignmentScreenState createState() => _CreateAssignmentScreenState();
}

class _CreateAssignmentScreenState extends State<CreateAssignmentScreen> {
  final TextEditingController _courseNameController = TextEditingController();
  final TextEditingController _assignmentNoController = TextEditingController();
  final TextEditingController _assignmentQuestionController = TextEditingController();
  File? selectedDocument;

  Future<void> _pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        // Assign the selected file to the selectedDocument variable
        selectedDocument = File(result.files.single.path!);
      });
    }
  }

  String selectedCourse = 'React.js';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primaryBGColor,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.15),
        child: const Center(
          child: CustomAppBar(title: 'Create Assignment'),
        ),
      ),      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CustomDropdownField(
              label: 'Select Course',
              options: const ['React.js', 'c++', 'Oop'],
              selectedValue: selectedCourse,
              controller: _courseNameController,
              onChanged: (newValue) {
                selectedCourse = newValue;
              },
            ),
            SizedBox(height: Dimensions.heightSize,),
            _buildTextField('Assignment No', '1', _assignmentNoController),
            SizedBox(height: Dimensions.heightSize,),
            _buildTextField('Assignment Question', 'Ask question here or uplod file', _assignmentQuestionController),
            SizedBox(height: Dimensions.heightSize,),
            Text('File to Upload', style: CustomStyle.interh2),
            SizedBox(height: Dimensions.heightSize,),
            pickDocument(),
            CustomButton(text: 'Publish Assignment', onPressed: () {  },),

          ],
        ),
      ),
    );
  }


  Widget _buildTextField(String label, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: CustomStyle.interh2),
        SizedBox(height: Dimensions.heightSize,),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            fillColor: CustomColor.whiteColor,
            filled: true,
            border: InputBorder.none,
            hintText: hint,
          ),
        ),
      ],
    );
  }



  DottedBorder pickDocument() {
    return DottedBorder(
      dashPattern: const [6, 6, 6, 6],
      color: CustomColor.hintColor,
      radius: const Radius.circular(15),
      strokeWidth: 2,
      borderType: BorderType.RRect,
      child: SizedBox(
        width: 400.w,
        height: 200.h,
        child: selectedDocument != null
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.file_copy, size: Dimensions.iconSizeextraLarge),
            const SizedBox(height: 10),
            Text(
              selectedDocument!.path.split('/').last, // Display only file name
              style: CustomStyle.pStyle,
            ),
          ],
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(icon: Icon(Icons.upload_file,size: Dimensions.iconSizeextraLarge), onPressed: (){
              _pickDocument();
            }, ),
            const SizedBox(height: 10),
            Text('Attach Document Here', style: CustomStyle.pStyle),
          ],
        ),
      ),
    );
  }
}

