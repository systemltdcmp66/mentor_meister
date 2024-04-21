import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mentormeister/core/utils/basic_screen_imports.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mentormeister/core/utils/core_utils.dart';
import 'package:mentormeister/features/Teacher/data/models/course_model.dart';
import 'package:mentormeister/features/Teacher/presentation/app/course_cubit/course_cubit.dart';
import 'package:mentormeister/features/Teacher/presentation/app/course_cubit/course_state.dart';
import '../../../../commons/widgets/custom_appbar.dart';
import '../../../../commons/widgets/custom_button.dart';

class CreateCourseScreen extends StatefulWidget {
  const CreateCourseScreen({super.key});

  @override
  _CreateCourseScreenState createState() => _CreateCourseScreenState();

  static const routeName = 'create-course';
}

class _CreateCourseScreenState extends State<CreateCourseScreen> {
  final TextEditingController _courseNameController = TextEditingController();
  final TextEditingController _courseTypeController = TextEditingController();
  final TextEditingController _coursePriceController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  File? selectedDocument;
  bool isImageFile = false;
  File? image;

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
  void initState() {
    super.initState();
    _imageController.addListener(() {
      if (isImageFile && _imageController.text.trim().isEmpty) {
        image = null;
        isImageFile = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: CustomColor.primaryBGColor,
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.15),
          child: const Center(
            child: CustomAppBar(title: 'Create Course'),
          ),
        ),
        body: BlocConsumer<CourseCubit, CourseState>(
          listener: (_, state) async {
            if (state is CourseError) {
              CoreUtils.showSnackar(
                context: context,
                message: state.message,
              );
            } else if (state is CourseCreated) {
              CoreUtils.showSnackar(
                context: context,
                message: 'Course created successfully',
              );
              await Future.delayed(const Duration(milliseconds: 1500), () {
                Navigator.of(context).pop();
              });
            }
          },
          builder: (context, state) {
            if (state is CreatingCourse) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(CustomColor.redColor),
                ),
              );
            }
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(Dimensions.paddingSize),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildTextField(
                          label: 'Course Name',
                          hint: 'Java',
                          controller: _courseNameController),
                      _buildTextField(
                          label: 'Course Type',
                          hint: 'Type',
                          controller: _courseTypeController),
                      _buildTextField(
                        label: 'Course Price',
                        hint: '30\$',
                        controller: _coursePriceController,
                      ),
                      _buildTextField(
                        label: 'Course Image',
                        hint: 'Enter Image URL or pick from gallery',
                        required: false,
                        controller: _imageController,
                        suffixIcon: IconButton(
                          onPressed: () async {
                            final pickImage = await ImagePicker().pickImage(
                              source: ImageSource.gallery,
                            );

                            if (pickImage != null) {
                              isImageFile = true;
                              image = File(pickImage.path);
                              final imageName = pickImage.path.split('/').last;
                              _imageController.text = imageName;
                            }
                          },
                          icon: const Icon(
                            Icons.add_photo_alternate_outlined,
                          ),
                        ),
                      ),
                      Text('Upload Lessons', style: CustomStyle.interh2),
                      SizedBox(
                        height: Dimensions.heightSize,
                      ),
                      pickDocument(),
                      CustomButton(
                        text: 'Publish Course',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            final now = DateTime.now();
                            final courseModel = CourseModel.empty().copyWith(
                              title: _courseNameController.text.trim(),
                              type: _courseTypeController.text.trim(),
                              price: double.parse(
                                  _coursePriceController.text.trim()),
                              lessons: selectedDocument,
                              isImageFile: isImageFile,
                              image: _imageController.text.trim().isEmpty
                                  ? 'assets/defaults/default_course.png'
                                  : isImageFile
                                      ? image!.path
                                      : _imageController.text.trim(),
                              createdAt: now,
                              updatedAt: now,
                            );
                            context
                                .read<CourseCubit>()
                                .createCourse(courseModel);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
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
                    selectedDocument!.path
                        .split('/')
                        .last, // Display only file name
                    style: CustomStyle.pStyle,
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.upload_file,
                        size: Dimensions.iconSizeextraLarge),
                    onPressed: () {
                      _pickDocument();
                    },
                  ),
                  const SizedBox(height: 10),
                  Text('Attach Document Here', style: CustomStyle.pStyle),
                ],
              ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    bool? required = true,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(label, style: CustomStyle.interh2),
                const SizedBox(
                  width: 5,
                ),
                required!
                    ? const Text(
                        '*',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: CustomColor.redColor),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
            if (suffixIcon != null) suffixIcon,
          ],
        ),
        SizedBox(height: Dimensions.heightSize),
        TextFormField(
          controller: controller,
          validator: (value) {
            if (required) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              return null;
            }
            return null;
          },
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
