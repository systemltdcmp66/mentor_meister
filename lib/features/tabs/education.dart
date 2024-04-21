import 'package:mentormeister/core/utils/basic_screen_imports.dart';

class Education extends StatefulWidget {
  const Education({
    super.key,
    required this.universityController,
    required this.degreeController,
    required this.degreeTypeController,
    required this.specializationController,
    required this.yearController,
    required this.toController,
  });

  final TextEditingController universityController;
  final TextEditingController degreeController;
  final TextEditingController degreeTypeController;
  final TextEditingController specializationController;
  final TextEditingController yearController;
  final TextEditingController toController;

  @override
  _EducationState createState() => _EducationState();
}

class _EducationState extends State<Education> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildTextFormField(
            icon: Icons.menu_book_sharp,
            text: 'University',
            controller: widget.universityController,
          ),
          SizedBox(
            height: Dimensions.marginBetweenInputTitleAndBox,
          ),
          buildTextFormField(
            icon: Icons.person_outline,
            text: 'Degree',
            controller: widget.degreeController,
          ),
          SizedBox(
            height: Dimensions.marginBetweenInputTitleAndBox,
          ),
          buildDropdownFormField(
            Icons.description,
            'Degree Type',
            ['PHD', 'BS', 'MSC'],
            'PHD',
            widget.degreeTypeController,
          ),
          SizedBox(height: Dimensions.marginBetweenInputTitleAndBox),
          buildTextFormField(
            icon: Icons.star,
            text: 'Specalization',
            controller: widget.specializationController,
          ),
          SizedBox(
            height: Dimensions.marginBetweenInputTitleAndBox,
          ),
          Row(
            children: [
              Expanded(
                child: buildDropdownFormField(
                  Icons.book,
                  'Year of Study',
                  ["2010", "2018", "2024"],
                  '2010',
                  widget.yearController,
                ),
              ),
              Expanded(
                child: buildDropdownFormField(
                  Icons.book,
                  'To',
                  ["2010", "2018", "2024"],
                  '2018',
                  widget.toController,
                ),
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
