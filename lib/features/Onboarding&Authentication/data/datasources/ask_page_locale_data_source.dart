import 'package:mentormeister/core/errors/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AskPageLocaleDataSource {
  const AskPageLocaleDataSource();

  Future<void> isAStudent();
  Future<void> isATeacher();

  Future<bool> checkIfUserIsAStudent();
  Future<bool> checkIfUserIsATeacher();
}

const String kIsAStudent = 'is-a-student';
const String kIsATeacher = 'is-a-teacher';

class AskPageLocaleDataSourceImplementation implements AskPageLocaleDataSource {
  const AskPageLocaleDataSourceImplementation(this._prefs);

  final SharedPreferences _prefs;
  @override
  Future<void> isAStudent() async {
    try {
      await _prefs.setBool(
        kIsAStudent,
        true,
      );
    } catch (e) {
      throw CacheException(
        message: e.toString(),
      );
    }
  }

  @override
  Future<bool> checkIfUserIsAStudent() async {
    try {
      return _prefs.getBool(kIsAStudent) ?? false;
    } catch (e) {
      throw CacheException(
        message: e.toString(),
      );
    }
  }

  @override
  Future<void> isATeacher() async {
    try {
      await _prefs.setBool(
        kIsATeacher,
        true,
      );
    } catch (e) {
      throw CacheException(
        message: e.toString(),
      );
    }
  }

  @override
  Future<bool> checkIfUserIsATeacher() async {
    try {
      return _prefs.getBool(kIsATeacher) ?? false;
    } catch (e) {
      throw CacheException(
        message: e.toString(),
      );
    }
  }
}
