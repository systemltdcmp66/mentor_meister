import 'package:mentormeister/core/utils/basic_screen_imports.dart';
import 'package:mentormeister/features/Teacher/domain/entities/course.dart';

class CoursesProvider extends ChangeNotifier {
  List<Course>? _courses;

  List<Course>? get courses => _courses;

  void initCourses(List<Course>? courses) {
    if (_courses != courses) _courses = courses;
  }

  set courses(List<Course>? courses) {
    if (_courses != courses) {
      _courses = courses;
      Future.delayed(Duration.zero, notifyListeners);
    }
  }
}
