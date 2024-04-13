import 'package:mentormeister/screens/Student/upload_assignment.dart';
import 'package:mentormeister/utils/basic_screen_imports.dart';

class Assignment {
  final String title;
  final String imageUrl;
  final String studentName;
  final String subject;
  final bool completed;

  Assignment({
    required this.title,
    required this.imageUrl,
    required this.studentName,
    required this.subject,
    this.completed = false,
  });
}

class AssignmentsPageStudent extends StatefulWidget {
  const AssignmentsPageStudent({super.key});

  @override
  _AssignmentsPageStudentState createState() => _AssignmentsPageStudentState();
}

class _AssignmentsPageStudentState extends State<AssignmentsPageStudent> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<Assignment> assignments = [
    Assignment(
      title: 'Assignment 1',
      imageUrl: 'assets/students/student.png',
      studentName: 'John Doe',
      subject: 'Mathematics',
    ),
    Assignment(
      title: 'Assignment 2',
      imageUrl: 'assets/students/student.png',
      studentName: 'Jane Smith',
      subject: 'Physics',
      completed: true,
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
            Expanded(
              child: _buildAssignmentList(assignments),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAssignmentList(List<Assignment> assignments) {
    return ListView.builder(
      itemCount: assignments.length,
      itemBuilder: (context, index) {
        final assignment = assignments[index];
        return Card(
          elevation: 0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(assignment.imageUrl),
            ),
            title: Text(assignment.title, style: TextStyle(fontSize: 8.sp),),
            subtitle: RichText(
              text: TextSpan(
                text: assignment.studentName,
                style: const TextStyle(color: Colors.grey),
                children: [
                  TextSpan(
                    text: '| ${assignment.subject}',
                    style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            trailing: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const UploadAssignment()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomColor.redColor,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              child: const Text('Upload', style: TextStyle(color: Colors.white)),
            ),
          ),
        );
      },
    );
  }
}
