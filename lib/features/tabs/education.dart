import 'package:mentormeister/core/utils/basic_screen_imports.dart';

class Education extends StatefulWidget {
  const Education({super.key});

  @override
  _EducationState createState() => _EducationState();
}

class _EducationState extends State<Education> {
  TextEditingController degreeController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController toController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildTextFormField(Icons.menu_book_sharp, 'University'),
          SizedBox(
            height: Dimensions.marginBetweenInputTitleAndBox,
          ),
          buildTextFormField(Icons.person_outline, 'Degree'),
          SizedBox(
            height: Dimensions.marginBetweenInputTitleAndBox,
          ),
          buildDropdownFormField(Icons.description, 'Degree Type',
              ['PHD', 'BS', 'MSC'], 'PHD', degreeController),
          SizedBox(height: Dimensions.marginBetweenInputTitleAndBox),
          buildTextFormField(Icons.star, 'Specalization'),
          SizedBox(
            height: Dimensions.marginBetweenInputTitleAndBox,
          ),
          Row(
            children: [
              Expanded(
                child: buildDropdownFormField(Icons.book, 'Year of Study',
                    ["2010", "2018", "2024"], '2010', yearController),
              ),
              Expanded(
                child: buildDropdownFormField(Icons.book, 'To',
                    ["2010", "2018", "2024"], '2018', toController),
              ),
            ],
          ),
        ],
      ),
    );
  }

  ElevatedButton buildElevatedButton(VoidCallback onPressed, String text) {
    return ElevatedButton(
      onPressed: () {
        onPressed;
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: CustomColor.redColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(text, style: CustomStyle.whiteh3),
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
        // Icon(icon),
        Expanded(
          child: DropdownButtonFormField<String>(
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
            value: dropdownController.text.isNotEmpty
                ? dropdownController.text
                : initialValue,
            onChanged: (String? newValue) {
              setState(() {
                dropdownController.text = newValue!;
              });
            },
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
