import 'package:mentormeister/utils/basic_screen_imports.dart';

import '../give_feedback.dart';

class Assignment {
  final String title;
  final String imageUrl;
  final String studentName;
  final int? marks;

  Assignment({
    required this.title,
    required this.imageUrl,
    required this.studentName,
    this.marks,
  });
}

class AssignmentsPage extends StatefulWidget {
  const AssignmentsPage({super.key});

  @override
  _AssignmentsPageState createState() => _AssignmentsPageState();
}

class _AssignmentsPageState extends State<AssignmentsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<Assignment> uploadedQuizzes = [
    Assignment(
      title: 'Assignment 1',
      imageUrl: 'assets/students/student.png',
      studentName: 'John Doe',
    ),
    Assignment(
      title: 'Assignment 2',
      imageUrl: 'assets/students/student.png',
      studentName: 'Jane Smith',
      marks: 80,
    ),
  ];

  List<Assignment> attemptedQuizzes = [
    Assignment(
      title: 'Assignment 3',
      imageUrl: 'assets/students/student.png',
      studentName: 'Alice Johnson',

    ),
    Assignment(
      title: 'Assignment 4',
      imageUrl: 'assets/students/student.png',
      studentName: 'Bob Brown',

    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColor.primaryBGColor,

        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: Dimensions.paddingSize, right: Dimensions.paddingSize),
              child: ColoredBox(
                color: Colors.white,
                child: TabBar(
                  controller: _tabController,
                  tabs: [
                    Padding(
                        padding: EdgeInsets.only(left: Dimensions.paddingSize, right: Dimensions.paddingSize),
                        child: const Tab(text: 'Uploaded')),
                    Padding(
                        padding: EdgeInsets.only(left: 20.r, right: 20.r),
                        child: const Tab(text: 'Attempts')),
                  ],

                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  indicatorColor: Colors.white,
                  indicatorWeight: 0,
                  dividerColor: Colors.transparent,

                  indicator: const BoxDecoration(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: Dimensions.heightSize,),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildUploadedTab(),
                  _buildAttemptsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadedTab() {
    return Expanded(
      child: ListView.builder(
        itemCount: uploadedQuizzes.length,
        itemBuilder: (context, index) {
          final Assignment = uploadedQuizzes[index];
          return Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Container(
              height: 68.h,
              decoration: BoxDecoration(
                color: CustomColor.whiteColor,
                borderRadius: BorderRadius.all(Radius.circular(15.r)),
              ),
              child: Center(
                child: ListTile(
                  leading: Image.asset(Assignment.imageUrl, height: 45.h, width: 45.w,),
                  title: Text(Assignment.title, style: TextStyle(fontSize: 10.sp),),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      elevatedButton('Edit', (){}),
                      SizedBox(width: Dimensions.widthSize,),
                      elevatedButton('Delete',(){}),
      
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget elevatedButton(String text, VoidCallback onPressed ) {
    return ElevatedButton(onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: CustomColor.greyColor,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ), child: Text(text),
    );
  }

  Widget _buildAttemptsTab() {
    return Expanded(
      child: ListView.builder(
        itemCount: attemptedQuizzes.length,
        itemBuilder: (context, index) {
          final Assignment = attemptedQuizzes[index];
          return Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Container(
              height: 68.h,
              decoration: BoxDecoration(
                color: CustomColor.whiteColor,
                borderRadius: BorderRadius.all(Radius.circular(15.r)),
              ),
              child: Center(
                child: ListTile(
                  leading: Image.asset(Assignment.imageUrl, width: 45.w, height: 45.h,),
                  title: Text(Assignment.title, style: TextStyle(fontSize: 12.sp),),
                  subtitle: Text(Assignment.studentName, style: CustomStyle.fpStyle,),
                  trailing: elevatedButton('Give Feedback', (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>const FeedBack()));
                  }),
      
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
