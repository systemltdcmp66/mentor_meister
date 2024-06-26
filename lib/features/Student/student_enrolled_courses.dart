// import 'package:mentormeister/features/Teacher/data/models/course_model.dart';
// import '../../../models/video_cardmodel.dart';
// import 'package:mentormeister/core/utils/basic_screen_imports.dart';
// import '../../commons/widgets/custom_appbar.dart';
// import 'course_detaiil.dart';

// class EnrolledCoursesScreen extends StatefulWidget {
//   final CourseModel courseModel;
//   const EnrolledCoursesScreen({
//     required this.courseModel,
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<EnrolledCoursesScreen> createState() => _EnrolledCoursesScreenState();

//   static const routeName = 'enrolled-course';
// }

// class _EnrolledCoursesScreenState extends State<EnrolledCoursesScreen> {
//   bool isShowContent = false;
//   VideoCard? _selectedVideoCard;

//   @override
//   Widget build(BuildContext context) {
//     if (isShowContent) {
//       return CourseDetailStudent(
//         courseModel: widget.courseModel,
//       );
//     }

//     return Scaffold(
//       backgroundColor: CustomColor.primaryBGColor,
//       appBar: PreferredSize(
//         preferredSize:
//             Size.fromHeight(MediaQuery.of(context).size.height * 0.15),
//         child: Center(
//           child: CustomAppBar(
//               title: 'My Courses',
//               centerTitle: true,
//               onBookmarkPressed: () {},
//               icon: Icons.favorite_border),
//         ),
//       ),
//       body: Stack(
//         children: [
//           Column(
//             children: [
//               SizedBox(height: Dimensions.heightSize),
//               isShowContent
//                   ? Expanded(
//                       child: CourseDetailStudent(
//                         courseModel: widget.courseModel,
//                       ),
//                     )
//                   : Expanded(
//                       child: ListView.builder(
//                         padding: EdgeInsets.zero,
//                         itemCount: videoCards.length,
//                         itemBuilder: (context, index) {
//                           return _buildCourseCard(videoCards[index]);
//                         },
//                       ),
//                     ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCourseCard(VideoCard videoCard) {
//     return GestureDetector(
//       onTap: () {
//         {
//           setState(() {
//             isShowContent = true;
//             _selectedVideoCard = videoCard;
//           });
//         }
//       },
//       child: Card(
//         elevation: 0,
//         margin: EdgeInsets.all(10.h),
//         child: Center(
//           child: ListTile(
//               leading: Container(
//                 width: 40.w,
//                 height: 40.h,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(Radius.circular(8.r)),
//                   image: DecorationImage(
//                     image: AssetImage(videoCard.imageUrl),
//                     fit: BoxFit.fill,
//                   ),
//                 ),
//               ),
//               title: Text(
//                 videoCard.title,
//                 style: CustomStyle.hintTextStyle,
//               ),
//               subtitle: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     videoCard.subtitle,
//                     style: CustomStyle.fpStyle,
//                   ),
//                   SizedBox(height: 4.h),
//                   const LinearProgressIndicator(
//                     value: 0.3,
//                     backgroundColor: CustomColor.greyColor,
//                     valueColor:
//                         AlwaysStoppedAnimation<Color>(CustomColor.redColor),
//                   ),
//                 ],
//               ),
//               trailing: const Text(
//                 '30%',
//                 style: TextStyle(color: Colors.black),
//               )),
//         ),
//       ),
//     );
//   }
// }
