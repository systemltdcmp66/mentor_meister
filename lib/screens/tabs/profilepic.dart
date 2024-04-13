import 'package:mentormeister/utils/basic_screen_imports.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class ProfilePhotoTab extends StatefulWidget {
  const ProfilePhotoTab({super.key});

  @override
  _ProfilePhotoTabState createState() => _ProfilePhotoTabState();
}

class _ProfilePhotoTabState extends State<ProfilePhotoTab> {
  File? profilePic;
  // Function to handle picking an image from the gallery

  Future<String?> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      profilePic = File(pickedFile!.path);
    });
    return null;
  }

    @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: Dimensions.marginBetweenInputTitleAndBox),
          Text(
            'Profile Picture',
            style: CustomStyle.interh1,
          ),
          SizedBox(height: Dimensions.marginBetweenInputTitleAndBox),
          Text(
            'Make a great impression',
            style: CustomStyle.p2Style,
          ),
          SizedBox(height: Dimensions.marginBetweenInputTitleAndBox),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                 _pickImage();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColor.redColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Upload', style: CustomStyle.whiteh3),
              ),
              SizedBox(width: Dimensions.widthSize),
              Text(
                'JPG, PNG format\nmax size 4mb',
                style: CustomStyle.pStyle,
              ),
            ],
          ),
          SizedBox(height: Dimensions.marginBetweenInputTitleAndBox),
          DottedBorder(
            dashPattern: const [6, 6, 6, 6],
            color: CustomColor.hintColor,
            radius: const Radius.circular(15),
            strokeWidth: 2,
            borderType: BorderType.RRect,
            child: SizedBox(
              width: 400.w,
              height: 300.h,
              child: profilePic != null
                  ? Image.file(profilePic!, fit: BoxFit.cover)
                  : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.upload_file,
                      size: Dimensions.iconSizeextraLarge),
                  const SizedBox(height: 10),
                  Text('Upload Document Here', style: CustomStyle.pStyle),
                ],
              ),
            ),
          )
      ],
      ),
    );
  }

}
