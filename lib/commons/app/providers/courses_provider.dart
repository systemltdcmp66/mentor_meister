import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mentormeister/core/utils/basic_screen_imports.dart';
import 'package:mentormeister/features/Teacher/data/models/course_model.dart';

class CoursesProvider extends ChangeNotifier {
  List<CourseModel>? _courses;

  List<CourseModel>? get courses => _courses;

  void initCourses(List<CourseModel>? courses) {
    if (_courses != courses) _courses = courses;
  }

  set courses(List<CourseModel>? courses) {
    if (_courses != courses) {
      _courses = courses;
      Future.delayed(Duration.zero, notifyListeners);
    }
  }

  Future<void> getAllCourses() async {
    FirebaseFirestore.instance.collection('courses').get().then(
          (value) => _courses =
              value.docs.map((e) => CourseModel.fromMap(e.data())).toList(),
        );
  }
}
