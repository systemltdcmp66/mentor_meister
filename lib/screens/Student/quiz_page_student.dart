import 'package:mentormeister/screens/Student/attemp_quiz.dart';
import 'package:mentormeister/utils/basic_screen_imports.dart';

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

class QuizzesPageStudent extends StatefulWidget {
  const QuizzesPageStudent({super.key});

  @override
  _QuizzesPageStudentState createState() => _QuizzesPageStudentState();
}

class _QuizzesPageStudentState extends State<QuizzesPageStudent> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<Quiz> quizzes = [
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
        backgroundColor: CustomColor.primaryBGColor, // Changed to default white color for demonstration

        body: Column(
          children: [
            Expanded(
              child: _buildQuizList(quizzes),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuizList(List<Quiz> quizzes) {
    return ListView.builder(
      itemCount: quizzes.length,
      itemBuilder: (context, index) {
        final quiz = quizzes[index];
        return Card(
          elevation: 0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(quiz.imageUrl),
            ),
            title: Text(quiz.title),
            subtitle: RichText(
              text: TextSpan(
                text: quiz.studentName,
                style: const TextStyle(color: CustomColor.redColor),
                children: const [
                  TextSpan(
                    text: ' | Data Science',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
           trailing: ElevatedButton(onPressed: () {
             Navigator.push(context, MaterialPageRoute(builder: (context)=>const AttemptQuizPage()));
           },
             style: ElevatedButton.styleFrom(
               backgroundColor: CustomColor.redColor,
               shape: const RoundedRectangleBorder(
                 borderRadius: BorderRadius.all(Radius.circular(10)),
               )
             ),
             child: Text('Attemp', style: CustomStyle.whiteh3,),

           ),
          ),
        );
      },
    );
  }
}
