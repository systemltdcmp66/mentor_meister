import 'package:mentormeister/core/utils/basic_screen_imports.dart';

class Description extends StatefulWidget {
  const Description({super.key});

  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  String fullName = 'Fazin Ali';
  TextEditingController headlineController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: Dimensions.heightSize),
          Text(
            'Profile Description',
            style: CustomStyle.interh1,
          ),
          SizedBox(height: Dimensions.marginBetweenInputTitleAndBox),
          Text(
            'Update or create a profile headline that will appear on your teacher card.',
            style: CustomStyle.pStyle,
          ),
          SizedBox(height: Dimensions.marginBetweenInputTitleAndBox),
          SizedBox(
            height: 133,
            child: Row(
              children: [
                Image.asset(
                  'assets/teacher/person.png',
                  height: 100,
                  width: 100,
                ),
                SizedBox(
                  width: Dimensions.widthSize,
                ),
                Column(
                  mainAxisAlignment: mainStart,
                  crossAxisAlignment: crossStart,
                  children: [
                    Text(
                      fullName,
                      style: CustomStyle.blackh2,
                    ),
                    SizedBox(height: Dimensions.marginBetweenInputTitleAndBox),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: TextFormField(
                        controller: descriptionController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: CustomColor.greyColor,
                          hintText: 'Write your profile headline',
                          hintStyle: TextStyle(fontSize: 12.sp),
                          border: InputBorder.none,
                        ),
                        maxLines: null,
                      ),
                    ),
                    SizedBox(height: Dimensions.marginBetweenInputTitleAndBox),
                    Text(
                      'Example : “teacher with five years\nof experience in the field”',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: Dimensions.marginBetweenInputTitleAndBox),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: TextFormField(
                controller: descriptionController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: CustomColor.greyColor,
                  hintText: 'Write your profile description here',
                  hintStyle: CustomStyle.hintStyle,
                  border: InputBorder.none,
                ),
                maxLines: 5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
