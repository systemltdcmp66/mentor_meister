import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mentormeister/core/utils/basic_screen_imports.dart';
import 'package:mentormeister/features/Teacher/data/models/teacher_info_model.dart';
import 'package:mentormeister/features/Teacher/domain/entities/teacher_info.dart';

class TeacherProvider extends ChangeNotifier {
  List<TeacherInfo>? _teacherInfo;

  List<TeacherInfo>? get teacherInfo => _teacherInfo;

  void initCourses(List<TeacherInfo>? teacherInfo) {
    if (_teacherInfo != teacherInfo) _teacherInfo = teacherInfo;
  }

  set teacherInfo(List<TeacherInfo>? teacherInfo) {
    if (_teacherInfo != teacherInfo) {
      _teacherInfo = teacherInfo;
      Future.delayed(Duration.zero, notifyListeners);
    }
  }

  Future<void> getTeacherInfo() async {
    FirebaseFirestore.instance
        .collection('teachers')
        .where(
          'userId',
          isEqualTo: FirebaseAuth.instance.currentUser!.uid,
        )
        .get()
        .then(
          (value) => _teacherInfo = value.docs
              .map(
                (e) => TeacherInfoModel.fromMap(
                  e.data(),
                ),
              )
              .toList(),
        );
  }
}
