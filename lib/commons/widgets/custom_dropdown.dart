import 'package:mentormeister/core/utils/basic_screen_imports.dart';

class CustomDropdownField extends StatefulWidget {
  final String label;
  final List<String> options;
  final String selectedValue;
  final TextEditingController controller;
  final Function(String) onChanged;

  const CustomDropdownField({
    Key? key,
    required this.label,
    required this.options,
    required this.selectedValue,
    required this.controller,
    required this.onChanged,
  }) : super(key: key);

  @override
  _CustomDropdownFieldState createState() => _CustomDropdownFieldState();
}

class _CustomDropdownFieldState extends State<CustomDropdownField> {
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          widget.label,
          style: CustomStyle.interh2,
        ),
        Container(
          height: Dimensions.buttonHeight,
          padding: EdgeInsets.all(5.r),
          decoration: const BoxDecoration(
            color: CustomColor.whiteColor,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Center(
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration.collapsed(hintText: ''),
              value: selectedValue,
              focusColor: Colors.transparent,
              isExpanded: true,
              isDense: true,
              elevation: 0,
              borderRadius: const BorderRadius.all(Radius.circular(50)),
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
              onChanged: (newValue) {
                setState(() {
                  selectedValue = newValue!;
                  widget.onChanged(newValue);
                });
              },
              items:
                  widget.options.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
