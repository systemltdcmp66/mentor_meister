import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mentormeister/features/Onboarding&Authentication/data/models/user_model.dart';
import 'package:mentormeister/features/Teacher/data/models/course_model.dart';
import 'package:mentormeister/features/Teacher/data/models/teacher_info_model.dart';

class TeacherUtils {
  const TeacherUtils._();

  static Stream<List<CourseModel>> get courses => FirebaseFirestore.instance
      .collection('courses')
      .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots()
      .map(
        (event) => event.docs
            .map(
              (doc) => CourseModel.fromMap(
                doc.data(),
              ),
            )
            .toList(),
      );

  static Stream<TeacherInfoModel> get teacherInfoData =>
      FirebaseFirestore.instance
          .collection('teachers')
          .where(
            'userId',
            isEqualTo: FirebaseAuth.instance.currentUser!.uid,
          )
          .snapshots()
          .map(
            (event) => TeacherInfoModel.fromMap(
              event.docs.first.data(),
            ),
          );

  static Stream<List<CourseModel>> get getAllCourses =>
      FirebaseFirestore.instance.collection('courses').snapshots().map(
            (event) => event.docs
                .map(
                  (doc) => CourseModel.fromMap(
                    doc.data(),
                  ),
                )
                .toList(),
          );

  static Stream<List<LocalUserModel>> get getAllUsers =>
      FirebaseFirestore.instance
          .collection(
            'users',
          )
          .snapshots()
          .map(
            (event) => event.docs
                .map(
                  (e) => LocalUserModel.fromMap(
                    e.data(),
                  ),
                )
                .toList(),
          );
}
