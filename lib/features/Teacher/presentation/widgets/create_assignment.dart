import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentormeister/commons/app/providers/courses_provider.dart';
import 'package:mentormeister/commons/widgets/no_found_text.dart';
import 'package:mentormeister/core/utils/basic_screen_imports.dart';
import 'package:mentormeister/core/utils/core_utils.dart';
import 'package:mentormeister/features/Teacher/data/models/assignment_model.dart';
import 'package:mentormeister/features/Teacher/data/models/course_model.dart';
import 'package:mentormeister/features/Teacher/presentation/app/assignment_cubit/assignment_cubit.dart';
import 'package:mentormeister/features/Teacher/presentation/app/assignment_cubit/assignment_state.dart';
import 'package:mentormeister/features/Teacher/utils/teacher_utils.dart';
import 'package:provider/provider.dart';

import '../../../../commons/widgets/custom_appbar.dart';
import '../../../../commons/widgets/custom_button.dart';
import '../../../../commons/widgets/custom_dropdown.dart';

class CreateAssignmentScreen extends StatefulWidget {
  const CreateAssignmentScreen({super.key});

  @override
  _CreateAssignmentScreenState createState() => _CreateAssignmentScreenState();
  static const routeName = 'create-assignment';
}

class _CreateAssignmentScreenState extends State<CreateAssignmentScreen> {
  final TextEditingController _courseNameController = TextEditingController();
  final TextEditingController _assignmentNoController = TextEditingController();
  final TextEditingController _assignmentQuestionController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();
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

  var selectedCourse = '';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CourseModel>>(
      stream: TeacherUtils.courses,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          context.read<CoursesProvider>().courses = snapshot.data;
        } else {
          context.read<CoursesProvider>().courses = [];
        }
        return Scaffold(
            backgroundColor: CustomColor.primaryBGColor,
            resizeToAvoidBottomInset: false,
            appBar: PreferredSize(
              preferredSize:
                  Size.fromHeight(MediaQuery.of(context).size.height * 0.15),
              child: const Center(
                child: CustomAppBar(title: 'Create Assignment'),
              ),
            ),
            body: BlocConsumer<AssignmentCubit, AssignmentState>(
              listener: (context, state) async {
                if (state is AssignmentError) {
                  CoreUtils.showSnackar(
                    context: context,
                    message: state.message,
                  );
                } else if (state is AssignmentCreated) {
                  CoreUtils.showSnackar(
                    context: context,
                    message: 'Assignment created successfully',
                  );
                  await Future.delayed(
                    const Duration(milliseconds: 1500),
                    () {
                      Navigator.of(context).pop();
                    },
                  );
                }
              },
              builder: (context, state) {
                if (state is CreatingAssignment) {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(CustomColor.redColor),
                    ),
                  );
                }
                return Consumer<CoursesProvider>(
                  builder: (context, provider, child) {
                    if (provider.courses!.isEmpty || provider.courses == null) {
                      return const NoFoundtext(
                        'Create a course first before creating an assignment',
                      );
                    }
                    return Builder(builder: (context) {
                      selectedCourse = context
                          .read<CoursesProvider>()
                          .courses!
                          .map((e) => e.title)
                          .toList()[0];
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              CustomDropdownField(
                                label: 'Select Course',
                                options: provider.courses!
                                    .map((e) => e.title)
                                    .toList(),
                                selectedValue: selectedCourse,
                                controller: _courseNameController,
                                onChanged: (newValue) {
                                  selectedCourse = newValue;
                                },
                              ),
                              SizedBox(
                                height: Dimensions.heightSize,
                              ),
                              _buildTextField(
                                label: 'Assignment No',
                                hint: 'Number',
                                controller: _assignmentNoController,
                              ),
                              SizedBox(
                                height: Dimensions.heightSize,
                              ),
                              _buildTextField(
                                label: 'Assignment Question',
                                hint: 'Ask question here or uplod file',
                                required: false,
                                controller: _assignmentQuestionController,
                              ),
                              SizedBox(
                                height: Dimensions.heightSize,
                              ),
                              Text('File to Upload',
                                  style: CustomStyle.interh2),
                              SizedBox(
                                height: Dimensions.heightSize,
                              ),
                              pickDocument(),
                              CustomButton(
                                text: 'Publish Assignment',
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    if (_assignmentNoController.text.trim() ==
                                        '0') {
                                      CoreUtils.showSnackar(
                                        context: context,
                                        message:
                                            'Assignment number cannot be 0',
                                      );
                                    } else if (_assignmentQuestionController
                                            .text.isEmpty &&
                                        selectedDocument == null) {
                                      CoreUtils.showSnackar(
                                        context: context,
                                        message:
                                            'Give assignment or select a file to upload',
                                      );
                                    } else if (_assignmentQuestionController
                                            .text.isNotEmpty &&
                                        selectedDocument != null) {
                                      CoreUtils.showSnackar(
                                        context: context,
                                        message:
                                            'You can only select a file to uplaod or give an assignment question',
                                      );
                                    } else {
                                      final course = provider.courses!
                                          .where((course) =>
                                              course.title == selectedCourse)
                                          .first;
                                      final assignmentModel =
                                          const AssignmentModel.empty()
                                              .copyWith(
                                        courseName: selectedCourse,
                                        question: selectedDocument == null
                                            ? _assignmentQuestionController.text
                                                .trim()
                                            : null,
                                        assignmentFile:
                                            _assignmentQuestionController
                                                    .text.isEmpty
                                                ? selectedDocument
                                                : null,
                                        isAssignmentFile:
                                            selectedDocument == null
                                                ? false
                                                : true,
                                        assignmentNumber: int.parse(
                                          _assignmentNoController.text.trim(),
                                        ),
                                        courseId: course.id,
                                      );
                                      context
                                          .read<AssignmentCubit>()
                                          .createAssignment(assignmentModel);
                                    }
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    });
                  },
                );
              },
            ));
      },
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    bool? required = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(label, style: CustomStyle.interh2),
            const SizedBox(
              width: 5,
            ),
            if (required!)
              const Text(
                '*',
                style: TextStyle(color: CustomColor.redColor),
              ),
          ],
        ),
        SizedBox(
          height: Dimensions.heightSize,
        ),
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
}
