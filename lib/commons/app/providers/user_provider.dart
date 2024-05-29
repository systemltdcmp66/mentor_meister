import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mentormeister/core/utils/basic_screen_imports.dart';
import 'package:mentormeister/features/Onboarding&Authentication/data/models/user_model.dart';
import 'package:mentormeister/features/Onboarding&Authentication/domain/entities/user.dart';

class UserProvider extends ChangeNotifier {
  LocaleUser? _user;

  LocaleUser? get user => _user;

  List<LocalUserModel>? _userInfo;
  List<LocalUserModel>? get userInfo => _userInfo;

  void initUser(LocaleUser? user) {
    if (_user != user) _user = user;
  }

  set user(LocaleUser? user) {
    if (_user != user) {
      _user = user;
      Future.delayed(Duration.zero, notifyListeners);
    }
  }

  set userInfo(List<LocalUserModel>? value) {
    if (_user != user) {
      _user = user;
      Future.delayed(Duration.zero, notifyListeners);
    }
  }

  Future<void> getUserInfo() async {
    FirebaseFirestore.instance
        .collection('users')
        .where(
          'uid',
          isEqualTo: FirebaseAuth.instance.currentUser!.uid,
        )
        .get()
        .then(
          (value) => _userInfo = value.docs
              .map(
                (e) => LocalUserModel.fromMap(
                  e.data(),
                ),
              )
              .toList(),
        );
  }
}
