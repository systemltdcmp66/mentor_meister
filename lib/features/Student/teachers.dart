import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mentormeister/commons/app/providers/teacher_provider.dart';
import 'package:mentormeister/commons/widgets/no_found_text.dart';
import 'package:mentormeister/core/services/injection_container.dart';
import 'package:mentormeister/core/utils/basic_screen_imports.dart';
import 'package:mentormeister/commons/widgets/custom_button.dart';
import 'package:mentormeister/core/utils/core_utils.dart';
import 'package:mentormeister/features/Teacher/data/models/teacher_info_model.dart';
import 'package:mentormeister/features/Teacher/my_courses/custom_app_bar.dart';
import 'package:mentormeister/features/Teacher/presentation/app/teacher_sign_up_cubit/teacher_sign_up_cubit.dart';
import 'package:mentormeister/features/Teacher/presentation/app/teacher_sign_up_cubit/teacher_sign_up_state.dart';
import 'package:mentormeister/features/payment/data/models/hiring_model.dart';
import 'package:mentormeister/features/payment/presentation/views/hiring_payment_page.dart';

class TeachersPage extends StatefulWidget {
  const TeachersPage({super.key});

  @override
  _TeachersPageState createState() => _TeachersPageState();
}

class _TeachersPageState extends State<TeachersPage> {
  bool isSearching = false;
  String searchQuery = "";
  List<TeacherInfoModel> filteredTeachers = [];

  List<TeacherInfoModel> teachers = [];

  Future<void> getAllTeacherInformations() async {
    await sl<FirebaseFirestore>().collection('teachers').get().then((value) {
      teachers.addAll(
          value.docs.map((e) => TeacherInfoModel.fromMap(e.data())).toList());
    });
    filteredTeachers = teachers;
  }

  @override
  void initState() {
    super.initState();
    getAllTeacherInformations();
    // Initially show all teachers
    context.read<TeacherSignUpCubit>().getAllTeacherInformations();
    context.read<TeacherProvider>().isHired();
  }

  void filterTeachers(String query) {
    setState(() {
      filteredTeachers = teachers
          .where((teacher) =>
              teacher.firstName.toLowerCase().contains(query.toLowerCase()))
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
          child: const CustomAppBarWithPop(
            text: 'Teachers',
          ),
        ),
        body: BlocConsumer<TeacherSignUpCubit, TeacherSignUpState>(
          listener: (_, state) {
            if (state is TeacherInformationsError) {
              CoreUtils.showSnackar(
                context: context,
                message: 'Error getting all available teachers. Try later',
              );
            }
          },
          builder: (context, state) {
            if (state is GettingAllTeacherInformations ||
                context.watch<TeacherProvider>().isLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(CustomColor.redColor),
                ),
              );
            } else if (state is AllTeacherInformationsFetched &&
                state.allTeacherInfos.isEmpty) {
              return const NoFoundtext(
                'No teachers available right now.',
              );
            } else if (state is AllTeacherInformationsFetched &&
                state.allTeacherInfos.isNotEmpty) {
              return Builder(
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
                                padding: EdgeInsets.only(
                                    left: Dimensions.paddingSize),
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
                                padding: EdgeInsets.only(
                                    left: Dimensions.paddingSize),
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
                              final teacherInfoModel = filteredTeachers[index];
                              // context
                              //     .read<TeacherProvider>()
                              //     .checkIfTeacherIsEnrolled(
                              //       teacherInfoModel.id,
                              //     );
                              // if (context.read<TeacherProvider>().isTEnrolled) {
                              //   print('yesssssssssss');

                              //   // context.read<TeacherProvider>().isHired();
                              // }

                              final isHired = context
                                          .watch<TeacherProvider>()
                                          .teacherIdsBooleanMap[
                                      teacherInfoModel.id] ??
                                  false;
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
                                        contentPadding:
                                            const EdgeInsets.all(16),
                                        leading: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: teacherInfoModel.profilePic!
                                                  .contains(
                                                      'assets/defaults/default_course.png')
                                              ? Image.asset(
                                                  'assets/defaults/default_course.png',
                                                  height: 60.h,
                                                  width: 60.h,
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.network(
                                                  teacherInfoModel.profilePic!,
                                                  height: 60.h,
                                                  width: 60.h,
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                        title: Text(
                                          '${teacherInfoModel.firstName} ${teacherInfoModel.lastName}',
                                          style: CustomStyle.interh3,
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              teacherInfoModel.hourlyRate
                                                  .toString(),
                                              style: CustomStyle.fpStyle,
                                            ),
                                          ],
                                        ),
                                        trailing: Wrap(
                                          spacing: 2,
                                          children: [
                                            // IconButton(
                                            //   onPressed: () {
                                            //     bool canMessage = false;
                                            //     for (String teacherId in context
                                            //         .read<TeacherProvider>()
                                            //         .hiredTeacherIds) {
                                            //       if (teacherId ==
                                            //           teacherInfoModel.id) {
                                            //         canMessage = true;
                                            //       }
                                            //     }
                                            //     if (canMessage) {
                                            //       Navigator.of(context)
                                            //           .pushNamed(
                                            //         MsgTeacher.routeName,
                                            //         arguments: teacherInfoModel,
                                            //       );
                                            //     } else {
                                            //       CoreUtils.showSnackar(
                                            //         context: context,
                                            //         message:
                                            //             'Hire a teacher first in order'
                                            //             ' to message him/her',
                                            //       );
                                            //     }
                                            //   },
                                            //   icon: const Icon(Icons.message,
                                            //       color: CustomColor.redColor),
                                            // ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: isHired
                                                    ? Colors.grey
                                                    : CustomColor.redColor,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(10),
                                                  ),
                                                ),
                                              ),
                                              onPressed: () {
                                                if (isHired) {
                                                  CoreUtils.showSnackar(
                                                    context: context,
                                                    message:
                                                        'You have already hired ${teacherInfoModel.firstName}'
                                                        ' ${teacherInfoModel.lastName}',
                                                  );
                                                } else {
                                                  _showDialog(
                                                    context,
                                                    teacherInfoModel,
                                                  );
                                                }
                                              },
                                              child: Text(
                                                isHired ? 'Hired' : 'Hire',
                                                style: CustomStyle.whiteh3,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 80),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.file_copy_sharp,
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  teacherInfoModel
                                                      .subjectTaught,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Icon(Icons.public),
                                                const SizedBox(width: 4),
                                                Text(
                                                  teacherInfoModel
                                                      .languageSpoken,
                                                ),
                                                // Text(teacher.languages.length >
                                                //         2
                                                //     ? "${teacher.languages.take(2).join(', ')} +${teacher.languages.length - 2}"
                                                //     : teacher.languages
                                                //         .join(', ')),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Text(
                                          teacherInfoModel.description,
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
                                          ),
                                        ),
                                      ),
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
              );
            }
            return const SizedBox.shrink();
          },
        ));
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

  void _showDialog(
    BuildContext context,
    TeacherInfoModel teacherInfoModel,
  ) async {
    DateTime currentDate = DateTime.now();
    List<List<bool>> selectedTimes =
        List.generate(7, (_) => List.filled(7, false));
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider(
            create: (_) => sl<TeacherSignUpCubit>(),
            child: BlocConsumer<TeacherSignUpCubit, TeacherSignUpState>(
              listener: (_, state) {
                if (state is HiringTeacherError) {
                  CoreUtils.showSnackar(
                    context: context,
                    message: state.message,
                  );
                } else if (state is TeacherHired) {
                  CoreUtils.showSnackar(
                    context: context,
                    message: 'Teacher hired successfully',
                  );
                  context.read<TeacherProvider>().isHired();
                  Navigator.of(context).pop();
                }
              },
              builder: (context, state) {
                if (state is HiringATeacher) {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        CustomColor.redColor,
                      ),
                    ),
                  );
                }
                return Center(
                  child: StatefulBuilder(
                    builder: (context, setState) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 0,
                        insetPadding: const EdgeInsets.all(10),
                        backgroundColor:
                            Colors.transparent, // Transparent background
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
                                        child: teacherInfoModel.profilePic!
                                                .contains(
                                                    'assets/defaults/default_course.png')
                                            ? Image.asset(
                                                'assets/defaults/default_course.png',
                                                height: 50,
                                                width: 50,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.network(
                                                teacherInfoModel.profilePic!,
                                                height: 50,
                                                width: 50,
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'Hire ${teacherInfoModel.firstName} ${teacherInfoModel.lastName}'
                                              ' For Live Session',
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
                                                  currentDate =
                                                      currentDate.subtract(
                                                    const Duration(
                                                      days: 7,
                                                    ),
                                                  );
                                                });
                                              },
                                              child: dialogBackIcon(),
                                            ),
                                            Text(
                                              formatDate(
                                                  currentDate,
                                                  currentDate.add(
                                                      const Duration(days: 7))),
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  currentDate = currentDate.add(
                                                    const Duration(days: 7),
                                                  );
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
                                            for (int i = 0; i < 7; i++)
                                              container,
                                          ],
                                        ),
                                        SizedBox(height: Dimensions.heightSize),
                                        updateDayNames(currentDate),
                                        SizedBox(height: Dimensions.heightSize),
                                        time(
                                            '8:00', setState, selectedTimes[0]),
                                        SizedBox(height: Dimensions.heightSize),
                                        time(
                                            '9:00', setState, selectedTimes[1]),
                                        SizedBox(height: Dimensions.heightSize),
                                        time('10:00', setState,
                                            selectedTimes[2]),
                                        SizedBox(height: Dimensions.heightSize),
                                        time('11:00', setState,
                                            selectedTimes[3]),
                                        SizedBox(height: Dimensions.heightSize),
                                        time('12:00', setState,
                                            selectedTimes[4]),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 300,
                                    child: CustomButton(
                                      text: 'Confirm time & hire',
                                      onPressed: () {
                                        // Implement your logic for confirming time and hire
                                        // context

                                        final hiringModel = HiringModel(
                                          teacherId: teacherInfoModel.id,
                                          userId: sl<FirebaseAuth>()
                                              .currentUser!
                                              .uid,
                                          paidAt: DateTime.now(),
                                          hourlyRate:
                                              teacherInfoModel.hourlyRate,
                                        );
                                        Navigator.of(context).pushNamed(
                                          HiringPaymentPage.routeName,
                                          arguments: hiringModel,
                                        );
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
            ));
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
