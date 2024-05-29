import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mentormeister/core/services/injection_container.dart';
import 'package:mentormeister/core/utils/basic_screen_imports.dart';
import 'package:mentormeister/features/Onboarding&Authentication/data/models/user_model.dart';
import 'package:mentormeister/features/Teacher/data/models/teacher_info_model.dart';
import 'package:mentormeister/features/Teacher/domain/entities/teacher_info.dart';
import 'package:mentormeister/features/payment/data/models/hiring_model.dart';

class TeacherProvider extends ChangeNotifier {
  List<TeacherInfo>? _teacherInfo;

  List<TeacherInfo>? get teacherInfo => _teacherInfo;

  String? _teacherName;
  String? get teacherName => _teacherName;

  List<String> _hiredTeacherIds = [];
  List<String> get hiredTeacherIds => _hiredTeacherIds;

  bool _isChecking = false;
  bool get isChecking => _isChecking;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isTEnrolled = false;
  bool get isTEnrolled => _isTEnrolled;

  final Map<String, bool> _teacherIdsBooleanMap = {};
  Map<String, bool> get teacherIdsBooleanMap => _teacherIdsBooleanMap;

  String? _teacherId;
  String? get teacherId => _teacherId;

  List<String> _teacherBalances = [];
  List<String> get teacherBalances => _teacherBalances;

  Future<void> getTeacherBalances(String teacherId) async {
    _teacherBalances = [];
    List<HiringModel> hirings = [];
    await sl<FirebaseFirestore>().collection('hiring_payments').get().then(
      (value) {
        hirings = value.docs
            .map(
              (e) => HiringModel.fromMap(
                e.data(),
              ),
            )
            .toList();
      },
    );
    if (hirings.isEmpty) {
      _teacherBalances = [];
    } else {
      for (HiringModel h in hirings) {
        if (h.teacherId == teacherId) {
          _teacherBalances.add(
            '\$${h.hourlyRate} USD',
          );
        }
      }
    }
    Future.delayed(
      Duration.zero,
      notifyListeners,
    );
  }

  Future<void> checkIfTeacherIsEnrolled(String teacherId) async {
    await sl<FirebaseFirestore>()
        .collection('hiring_payments')
        .get()
        .then((value) {
      List<HiringModel> data =
          value.docs.map((e) => HiringModel.fromMap(e.data())).toList();
      if (data.isEmpty) {
        _isTEnrolled = false;
      } else {
        for (HiringModel hiringModel in data) {
          if (hiringModel.userId == sl<FirebaseAuth>().currentUser!.uid &&
              hiringModel.teacherId == teacherId) {
            _isTEnrolled = true;
          }
        }
      }
    });
  }

  Future<void> checkIfUserisTeacher() async {
    _isChecking = true;
    await sl<FirebaseFirestore>()
        .collection('users')
        .doc(sl<FirebaseAuth>().currentUser!.uid)
        .get()
        .then(
      (value) {
        _teacherId = LocalUserModel.fromMap(value.data()!).teacherId;
      },
    );
    _isChecking = false;
    notifyListeners();
  }

  bool _isLoading2 = false;
  bool get isLoading2 => _isLoading2;

  void isHired() async {
    _isLoading = true;
    _hiredTeacherIds = [];
    List<TeacherInfoModel> allTeachers = [];

    await sl<FirebaseFirestore>()
        .collection('users')
        .doc(sl<FirebaseAuth>().currentUser!.uid)
        .get()
        .then(
      (value) {
        _hiredTeacherIds =
            LocalUserModel.fromMap(value.data()!).hiredTeacherIds ?? [];
      },
    );

    await sl<FirebaseFirestore>().collection('teachers').get().then(
      (value) {
        allTeachers = value.docs
            .map(
              (e) => TeacherInfoModel.fromMap(
                e.data(),
              ),
            )
            .toList();
      },
    );

    for (int i = 0; i < allTeachers.length; i++) {
      _teacherIdsBooleanMap[allTeachers[i].id] = false;
    }

    if (_hiredTeacherIds.isNotEmpty) {
      for (int i = 0; i < _hiredTeacherIds.length; i++) {
        final teacherInfoModel = allTeachers
            .firstWhere((element) => element.id == _hiredTeacherIds[i]);
        _teacherIdsBooleanMap[teacherInfoModel.id] = true;
      }
    }

    _isLoading = false;
    notifyListeners();
  }

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
    _isLoading2 = true;
    Future.delayed(
      Duration.zero,
      notifyListeners,
    );
    await FirebaseFirestore.instance
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
    _isLoading2 = false;
    Future.delayed(
      Duration.zero,
      notifyListeners,
    );
  }

  Future<void> getTeacherName(String userId) async {
    await sl<FirebaseFirestore>()
        .collection('teachers')
        .where('userId', isEqualTo: userId)
        .get()
        .then((value) {
      _teacherName = '${value.docs.map(
            (e) => TeacherInfoModel.fromMap(
              e.data(),
            ),
          ).toList()[0].firstName} ${value.docs.map(
            (e) => TeacherInfoModel.fromMap(
              e.data(),
            ),
          ).toList()[0].lastName}';
    });
  }
}
