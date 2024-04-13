import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:mentormeister/utils/basic_screen_imports.dart';
import 'package:file_picker/file_picker.dart';
import '../../widget/custom_appbar.dart';
import '../../widget/custom_button.dart';

class UploadAssignment extends StatefulWidget {
  const UploadAssignment({super.key});

  @override
  _UploadAssignmentState createState() => _UploadAssignmentState();
}

class _UploadAssignmentState extends State<UploadAssignment> {
  final TextEditingController _assignmentNoController = TextEditingController();
  final TextEditingController _weekController = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomColor.primaryBGColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.15),
        child: const Center(
          child: CustomAppBar(title: 'Assignment', centerTitle: true,),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(Dimensions.paddingSize),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Upload Assignment', style: CustomStyle.interh1),
            SizedBox(height: Dimensions.heightSize,),

            _buildTextField('Assignment No', '1', _assignmentNoController),
            _buildTextField('Week', '2', _weekController),
            Text('Upload Document', style: CustomStyle.interh2),
            SizedBox(height: Dimensions.heightSize,),
            pickDocument(),
            CustomButton(text: 'Upload Assignment', onPressed: () {  },),
          ],
        ),
      ),
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
        height: 180.h,
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

  Widget _buildTextField(
      String label, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: CustomStyle.interh2),
        SizedBox(height: Dimensions.heightSize),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: CustomColor.whiteColor,
            border: InputBorder.none,
            hintText: hint,
          ),
        ),
        SizedBox(height: Dimensions.heightSize),
      ],
    );
  }


}
