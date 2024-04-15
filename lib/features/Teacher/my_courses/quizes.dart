import 'package:mentormeister/core/utils/basic_screen_imports.dart';

class Quiz {
  final String title;
  final String imageUrl;
  final String studentName;
  final int? marks;

  Quiz({
    required this.title,
    required this.imageUrl,
    required this.studentName,
    this.marks,
  });
}

class QuizzesPage extends StatefulWidget {
  const QuizzesPage({super.key});

  @override
  _QuizzesPageState createState() => _QuizzesPageState();
}

class _QuizzesPageState extends State<QuizzesPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<Quiz> uploadedQuizzes = [
    Quiz(
      title: 'Quiz 1',
      imageUrl: 'assets/students/student.png',
      studentName: 'John Doe',
    ),
    Quiz(
      title: 'Quiz 2',
      imageUrl: 'assets/students/student.png',
      studentName: 'Jane Smith',
      marks: 80,
    ),
  ];

  List<Quiz> attemptedQuizzes = [
    Quiz(
      title: 'Quiz 3',
      imageUrl: 'assets/students/student.png',
      studentName: 'Alice Johnson',
    ),
    Quiz(
      title: 'Quiz 4',
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
            ColoredBox(
              color: Colors.white,
              child: TabBar(
                controller: _tabController,
                tabs: [
                  Padding(
                      padding: EdgeInsets.only(
                          left: Dimensions.paddingSize,
                          right: Dimensions.paddingSize),
                      child: const Tab(text: 'Uploaded')),
                  Padding(
                      padding: EdgeInsets.only(
                          left: Dimensions.paddingSize,
                          right: Dimensions.paddingSize),
                      child: const Tab(text: 'Attempts')),
                ],
                padding: EdgeInsets.zero,
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
            SizedBox(
              height: Dimensions.heightSize,
            ),
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
        padding: EdgeInsets.zero,
        itemCount: uploadedQuizzes.length,
        itemBuilder: (context, index) {
          final quiz = uploadedQuizzes[index];
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
                  leading: Image.asset(quiz.imageUrl),
                  title: Text(quiz.title),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      elevatedButton('Edit', () {}),
                      SizedBox(
                        width: Dimensions.widthSize,
                      ),
                      elevatedButton('Delete', () {}),
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

  ElevatedButton elevatedButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: CustomColor.greyColor,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      child: Text(text),
    );
  }

  Widget _buildAttemptsTab() {
    return Expanded(
      child: ListView.builder(
        itemCount: attemptedQuizzes.length,
        itemBuilder: (context, index) {
          final quiz = attemptedQuizzes[index];
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
                  leading: Image.asset(quiz.imageUrl),
                  title: Text(quiz.title),
                  subtitle: Text(
                    quiz.studentName,
                    style: CustomStyle.fpStyle,
                  ),
                  trailing: elevatedButton('Show Marks', () {}),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
