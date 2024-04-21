import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentormeister/commons/app/providers/teacher_sign_up_controller.dart';
import 'package:mentormeister/core/utils/basic_screen_imports.dart';

class Availability extends StatefulWidget {
  const Availability({
    super.key,
    required this.fromController,
    required this.toController,
  });

  final TextEditingController fromController;
  final TextEditingController toController;

  @override
  _AvailabilityState createState() => _AvailabilityState();
}

class _AvailabilityState extends State<Availability> {
  TimeOfDay startTime = const TimeOfDay(hour: 19, minute: 0);
  TimeOfDay endTime = const TimeOfDay(hour: 19, minute: 0);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Set your availability',
            style: CustomStyle.interh1,
          ),
          SizedBox(height: Dimensions.marginBetweenInputTitleAndBox),
          Text(
            'Availability shows your potential working hours. Students can book live sessions at these times.',
            style: CustomStyle.pStyle,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Dimensions.marginBetweenInputTitleAndBox),
          Column(
            crossAxisAlignment: crossStart,
            mainAxisAlignment: mainStart,
            children: context
                .read<TeacherSignUpController>()
                .availabilityMap
                .entries
                .map((entry) {
              return Column(
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: entry.value,
                        onChanged: (value) {
                          setState(() {
                            context
                                .read<TeacherSignUpController>()
                                .availabilityMap[entry.key] = value!;
                          });
                        },
                      ),
                      Text(entry.key),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: buildDropdownFormField(
                          ["6:00", "11:00", "12:00"],
                          '6:00',
                          widget.fromController,
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            'To',
                            style: CustomStyle.blackh3,
                          )),
                      Expanded(
                        child: buildDropdownFormField(
                          ['9:00', "8:00", "10:00"],
                          '9:00',
                          widget.toController,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }).toList(),
          ),
          SizedBox(height: Dimensions.heightSize),
        ],
      ),
    );
  }

  Widget buildDropdownFormField(List<String> dropdownOptions,
      String initialValue, TextEditingController dropdownController) {
    return Row(
      children: [
        // Icon(icon),
        const SizedBox(width: 10),
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
