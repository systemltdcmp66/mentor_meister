import 'package:mentormeister/core/utils/basic_screen_imports.dart';

import '../../commons/widgets/custom_appbar.dart';
import '../../commons/widgets/custom_button.dart';
import '../../commons/widgets/custom_dropdown.dart';

class CreateQuizScreen extends StatefulWidget {
  const CreateQuizScreen({super.key});

  @override
  _CreateQuizScreenState createState() => _CreateQuizScreenState();
}

class _CreateQuizScreenState extends State<CreateQuizScreen> {
  final TextEditingController _courseNameController = TextEditingController();
  final TextEditingController _quizNoController = TextEditingController();
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  final TextEditingController _questionController = TextEditingController();

  String selectedCourse = 'React.js';
  String selectFrom = 'Chap1';
  String selectTo = 'Chap5';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomColor.primaryBGColor,
      appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.15),
          child: const CustomAppBar(title: 'Create Quiz')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CustomDropdownField(
              label: 'Select Course',
              options: const ['React.js', 'Java', 'OOP'],
              selectedValue: selectedCourse,
              controller: _courseNameController,
              onChanged: (newValue) {
                // You need to specify what to do when the value changes
                // For example, you can assign the new value to a variable
                setState(() {
                  selectedCourse = newValue;
                });
              },
            ),
            SizedBox(
              height: Dimensions.heightSize,
            ),
            _buildTextField('Quiz No', '1', _quizNoController),
            SizedBox(
              height: Dimensions.heightSize,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomDropdownField(
                    label: 'Timeline',
                    options: const ['Chap1', 'Chap2', 'Chap2'],
                    selectedValue: selectFrom,
                    controller: _fromController,
                    onChanged: (newValue) {
                      setState(() {
                        selectFrom = newValue;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: Dimensions.widthSize,
                ),
                Expanded(
                  child: CustomDropdownField(
                    label: '',
                    options: const ['Chap4', 'Chap5', 'Chap6'],
                    selectedValue: selectTo,
                    controller: _toController,
                    onChanged: (newValue) {
                      setState(() {
                        selectTo = newValue;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Dimensions.heightSize,
            ),
            _buildTitle('Add Question'),
            _buildMultilineTextField(_questionController),
            SizedBox(
              height: Dimensions.heightSize,
            ),
            CustomButton(
              text: 'Publish Quiz',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownField(String label, List<String> options,
      String selectedValue, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: const TextStyle(fontSize: 18, color: Colors.black)),
        DropdownButtonFormField<String>(
          value: selectedValue,
          onChanged: (newValue) {
            setState(() {
              selectedCourse = newValue!;
            });
          },
          items: options.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTextField(
      String label, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: CustomStyle.interh2),
        SizedBox(
          height: Dimensions.heightSize,
        ),
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

  Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildRowDropdownField(String label, List<String> options,
      String selectedValue, TextEditingController controller) {
    return Row(
      children: <Widget>[
        Expanded(
          child: _buildDropdownField(label, options, selectedValue, controller),
        ),
      ],
    );
  }

  Widget _buildMultilineTextField(TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextField(
          controller: controller,
          maxLines: 5,
          keyboardType: TextInputType.multiline,
          decoration: const InputDecoration(
            border: InputBorder.none,
            filled: true,
            focusColor: Colors.white,
            hintText: 'Enter multiple chose question here',
          ),
        ),
      ],
    );
  }
}
