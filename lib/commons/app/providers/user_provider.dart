import 'package:mentormeister/core/utils/basic_screen_imports.dart';
import 'package:mentormeister/features/Onboarding&Authentication/domain/entities/user.dart';

class UserProvider extends ChangeNotifier {
  LocaleUser? _user;

  LocaleUser? get user => _user;

  void initUser(LocaleUser? user) {
    if (_user != user) _user = user;
  }

  set user(LocaleUser? user) {
    if (_user != user) {
      _user = user;
      Future.delayed(Duration.zero, notifyListeners);
    }
  }
}
