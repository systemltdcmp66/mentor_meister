import 'package:mentormeister/core/utils/basic_screen_imports.dart';

class AboutForm extends StatefulWidget {
  const AboutForm({super.key});

  @override
  _AboutFormState createState() => _AboutFormState();
}

class _AboutFormState extends State<AboutForm> {
  TextEditingController countryController = TextEditingController();
  TextEditingController languageController = TextEditingController();
  TextEditingController subjectController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildTextFormField(Icons.person_outline, 'First Name'),
          SizedBox(
            height: Dimensions.marginBetweenInputTitleAndBox,
          ),
          buildTextFormField(Icons.person_outline, 'Last Name'),
          SizedBox(
            height: Dimensions.marginBetweenInputTitleAndBox,
          ),
          buildTextFormField(Icons.phone_outlined, 'Phone No'),
          SizedBox(height: Dimensions.marginBetweenInputTitleAndBox),
          buildDropdownFormField(Icons.public, 'Country',
              ['Pakistan', 'Canada', 'UK'], 'Pakistan', countryController),
          SizedBox(height: Dimensions.marginBetweenInputTitleAndBox),
          buildDropdownFormField(Icons.language_rounded, 'Language Spoken',
              ['Urdu', 'English', 'French'], 'Urdu', languageController),
          SizedBox(height: Dimensions.marginBetweenInputTitleAndBox),
          buildDropdownFormField(
              Icons.book,
              'Subject Taught',
              ["Mathematics", "Science", "Literature"],
              'Mathematics',
              subjectController),
          SizedBox(height: Dimensions.heightSize),
          buildTextFormField(Icons.link, 'Email'),
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
      TextEditingController dropdownController) {
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

TextFormField buildTextFormField(IconData icon, String text) {
  return TextFormField(
    decoration: InputDecoration(
      labelText: text,
      border: InputBorder.none,
      filled: true,
      fillColor: Colors.grey[200],
      prefixIcon: Icon(icon),
    ),
  );
}
