import 'package:intl/intl.dart';
import 'package:mentormeister/core/utils/basic_screen_imports.dart';
import 'package:mentormeister/commons/widgets/custom_button.dart';
import '../../commons/widgets/custom_appbar.dart';
import 'message_teacher.dart';

class Teacher {
  final String name;
  final String subject;
  final String price;
  final List<String> languages;
  final String imageUrl;

  Teacher({
    required this.name,
    required this.subject,
    required this.price,
    required this.languages,
    required this.imageUrl,
  });
}

class TeachersPage extends StatefulWidget {
  const TeachersPage({super.key});

  @override
  _TeachersPageState createState() => _TeachersPageState();
}

class _TeachersPageState extends State<TeachersPage> {
  bool isSearching = false;
  String searchQuery = "";
  List<Teacher> filteredTeachers = [];

  final List<Teacher> teachers = [
    Teacher(
      name: 'Eleanor Pena',
      subject: 'Web Development',
      price: '\$15/1hr',
      languages: ['English', 'Spanish', 'French'],
      imageUrl: 'assets/teacher/person.png',
    ),
    Teacher(
      name: 'Floyd Miles',
      subject: 'Data Science',
      price: '\$20/1hr',
      languages: ['English', 'French'],
      imageUrl: 'assets/teacher/person.png',
    ),
  ];

  @override
  void initState() {
    super.initState();
    filteredTeachers = teachers; // Initially show all teachers
  }

  void filterTeachers(String query) {
    setState(() {
      filteredTeachers = teachers
          .where((teacher) =>
              teacher.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      searchQuery = query; // Update search query
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primaryBGColor,
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.15),
        child: const CustomAppBar(
          title: 'Teachers',
          centerTitle: true,
        ),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(Dimensions.paddingSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 0,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: Dimensions.paddingSize),
                        child: IconButton(
                          icon: Icon(
                            Icons.search,
                            size: Dimensions.iconSizeLarge,
                          ),
                          onPressed: () {
                            setState(() {
                              isSearching = !isSearching;
                              if (!isSearching) {
                                // If not searching, reset the filtered teachers list
                                filteredTeachers = teachers;
                              }
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: Dimensions.widthSize,
                      ),
                      Expanded(
                        child: TextField(
                          onChanged: (value) => filterTeachers(value),
                          decoration: InputDecoration(
                            hintText: 'Search teachers',
                            hintStyle: CustomStyle.blackh2,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: Dimensions.paddingSize),
                        child: IconButton(
                            onPressed: () {
                              // Add filter functionality here
                            },
                            icon: Icon(
                              Icons.filter_list,
                              size: Dimensions.iconSizeLarge,
                            )),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredTeachers.length,
                    itemBuilder: (context, index) {
                      final Teacher teacher = filteredTeachers[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                contentPadding: const EdgeInsets.all(16),
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    teacher.imageUrl,
                                    height: 60.h,
                                    width: 60.h,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                title: Text(
                                  teacher.name,
                                  style: CustomStyle.interh3,
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(teacher.price,
                                        style: CustomStyle.fpStyle),
                                  ],
                                ),
                                trailing: Wrap(
                                  spacing: 2,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => MsgTeacher(
                                              imageUrl: teacher.imageUrl,
                                              name: teacher.name,
                                              subtitle: teacher
                                                  .subject, // or any relevant subtitle here
                                            ),
                                          ),
                                        );
                                      },
                                      icon: const Icon(Icons.message,
                                          color: CustomColor.redColor),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: CustomColor.redColor,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)))),
                                      onPressed: () {
                                        _showDialog(context, teacher);
                                      },
                                      child: Text('Hire',
                                          style: CustomStyle.whiteh3),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 80),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.file_copy_sharp,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(teacher.subject),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.public),
                                        const SizedBox(width: 4),
                                        Text(teacher.languages.length > 2
                                            ? "${teacher.languages.take(2).join(', ')} +${teacher.languages.length - 2}"
                                            : teacher.languages.join(', ')),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Text(
                                  'Become a Full-Stack Developer with a Programming Coach Who\'s a Digital Nomad! Tap to Learn How! Hey there 👋, I\'m Eleanor Pena',
                                  textAlign: TextAlign.start,
                                  style: CustomStyle.pStyle,
                                ),
                              ),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        'Read More',
                                        style: CustomStyle.interh3,
                                      )))
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  ///Dialog box
  String formatDate(DateTime startDate, DateTime endDate) {
    // Format the start and end dates
    String formattedStartDate = DateFormat.MMMMd().format(startDate);
    String formattedEndDate = DateFormat.y().format(endDate);

    // Return the formatted date string
    return '$formattedStartDate-$formattedEndDate';
  }

  Widget updateDayNames(DateTime currentDate) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        7,
        (index) => Text(
          DateFormat('EEE').format(currentDate.add(Duration(days: index))),
        ),
      ),
    );
  }

  void _showDialog(BuildContext context, Teacher teacher) async {
    DateTime currentDate = DateTime.now();
    List<List<bool>> selectedTimes =
        List.generate(7, (_) => List.filled(7, false));
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: StatefulBuilder(
            builder: (context, setState) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 0,
                insetPadding: const EdgeInsets.all(10),
                backgroundColor: Colors.transparent, // Transparent background
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.black),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.9),
                        blurRadius: 3.0,
                        spreadRadius: -22.0,
                        offset: const Offset(0, 0), // Shadow position
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      color: Colors.white, // Dialog background color
                      padding: EdgeInsets.all(16.r),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  teacher.imageUrl,
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Hire ${teacher.name} For Live Session',
                                      style: CustomStyle.interh2,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Dimensions.heightSize),
                          SizedBox(
                            width: 500,
                            height: 300,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          currentDate = currentDate.subtract(
                                              const Duration(days: 7));
                                        });
                                      },
                                      child: dialogBackIcon(),
                                    ),
                                    Text(
                                      formatDate(
                                          currentDate,
                                          currentDate
                                              .add(const Duration(days: 7))),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          currentDate = currentDate
                                              .add(const Duration(days: 7));
                                        });
                                      },
                                      child: dialogBackIcon(),
                                    ),
                                  ],
                                ),
                                SizedBox(height: Dimensions.heightSize),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    for (int i = 0; i < 7; i++) container,
                                  ],
                                ),
                                SizedBox(height: Dimensions.heightSize),
                                updateDayNames(currentDate),
                                SizedBox(height: Dimensions.heightSize),
                                time('8:00', setState, selectedTimes[0]),
                                SizedBox(height: Dimensions.heightSize),
                                time('9:00', setState, selectedTimes[1]),
                                SizedBox(height: Dimensions.heightSize),
                                time('10:00', setState, selectedTimes[2]),
                                SizedBox(height: Dimensions.heightSize),
                                time('11:00', setState, selectedTimes[3]),
                                SizedBox(height: Dimensions.heightSize),
                                time('12:00', setState, selectedTimes[4]),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 300,
                            child: CustomButton(
                              text: 'Confirm time & hire',
                              onPressed: () {
                                Navigator.pop(context);
                                // Implement your logic for confirming time and hire
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Container get container {
    return Container(
      width: 31,
      height: 8,
      decoration: const BoxDecoration(
        color: CustomColor.redColor,
        borderRadius: BorderRadius.all(Radius.circular(40)),
      ),
    );
  }

  Row time(String time, StateSetter setState, List<bool> selectedTimes) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        7,
        (index) => GestureDetector(
          onTap: () {
            setState(() {
              // Clear the previous selection for this row
              for (int i = 0; i < selectedTimes.length; i++) {
                selectedTimes[i] = false;
              }
              // Toggle the selected state of the tapped time
              selectedTimes[index] = true;
            });
          },
          child: Center(
            child: Text(
              time,
              style: TextStyle(
                fontSize: 12,
                color: selectedTimes[index] ? Colors.red : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container dialogBackIcon() {
    return Container(
      height: 38,
      width: 38,
      decoration: BoxDecoration(
        color: Colors.red.shade100, // Red color
        borderRadius: BorderRadius.circular(8), // Rounded corners
      ),
      child: Center(
        child: Container(
          padding: const EdgeInsets.only(left: 5),
          height: 18,
          width: 18,
          decoration: BoxDecoration(
            color: const Color(0xFFF01C1C), // Red color
            borderRadius: BorderRadius.circular(4), // Rounded corners
          ),
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white, // White color
            size: 12, // Adjust the size of the icon
          ),
        ),
      ),
    );
  }
}
