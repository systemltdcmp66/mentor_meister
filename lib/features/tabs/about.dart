import 'package:mentormeister/core/utils/basic_screen_imports.dart';

class AboutForm extends StatefulWidget {
  const AboutForm({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.phoneNumberController,
    required this.countryController,
    required this.languageController,
    required this.subjectController,
    required this.emailController,
  });

  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController phoneNumberController;
  final TextEditingController countryController;
  final TextEditingController languageController;
  final TextEditingController subjectController;
  final TextEditingController emailController;

  @override
  _AboutFormState createState() => _AboutFormState();
}

class _AboutFormState extends State<AboutForm> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildTextFormField(
            icon: Icons.person_outline,
            text: 'First Name',
            controller: widget.firstNameController,
          ),
          SizedBox(
            height: Dimensions.marginBetweenInputTitleAndBox,
          ),
          buildTextFormField(
            icon: Icons.person_outline,
            text: 'Last Name',
            controller: widget.lastNameController,
          ),
          SizedBox(
            height: Dimensions.marginBetweenInputTitleAndBox,
          ),
          buildTextFormField(
            icon: Icons.phone_outlined,
            text: 'Phone No',
            controller: widget.phoneNumberController,
          ),
          SizedBox(height: Dimensions.marginBetweenInputTitleAndBox),
          buildDropdownFormField(
            Icons.public,
            'Country',
            ['Pakistan', 'Canada', 'UK'],
            'Pakistan',
            widget.countryController,
          ),
          SizedBox(height: Dimensions.marginBetweenInputTitleAndBox),
          buildDropdownFormField(
            Icons.language_rounded,
            'Language Spoken',
            ['Urdu', 'English', 'French'],
            'Urdu',
            widget.languageController,
          ),
          SizedBox(height: Dimensions.marginBetweenInputTitleAndBox),
          buildDropdownFormField(
            Icons.book,
            'Subject Taught',
            ["Mathematics", "Science", "Literature"],
            'Mathematics',
            widget.subjectController,
          ),
          SizedBox(height: Dimensions.heightSize),
          buildTextFormField(
            icon: Icons.link,
            text: 'Email',
            controller: widget.emailController,
          ),
          SizedBox(height: Dimensions.heightSize),
        ],
      ),
    );
  }

  Widget buildDropdownFormField(
    IconData icon,
    String labelText,
    List<String> dropdownOptions,
    String initialValue,
    TextEditingController dropdownController,
  ) {
    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField<String>(
            value: dropdownController.text.isNotEmpty
                ? dropdownController.text
                : initialValue,
            onChanged: (String? newValue) {
              setState(() {
                dropdownController.text = newValue!;
              });
            },
            icon: Container(
              height: 25,
              width: 25,
              color: Colors.grey,
              child: const Center(
                  child: Icon(
                Icons.keyboard_arrow_down,
                color: CustomColor.whiteColor,
              )),
            ),
            decoration: InputDecoration(
              prefixIcon: Icon(icon),
              labelText: labelText,
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.grey[200],
            ),
            items: dropdownOptions.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

TextFormField buildTextFormField({
  required TextEditingController controller,
  required IconData icon,
  required String text,
}) {
  return TextFormField(
    controller: controller,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'This field is required';
      }
      return null;
    },
    decoration: InputDecoration(
      labelText: text,
      border: InputBorder.none,
      filled: true,
      fillColor: Colors.grey[200],
      prefixIcon: Icon(icon),
    ),
  );
}
