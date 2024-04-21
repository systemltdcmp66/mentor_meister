import 'dart:io';
import 'dart:math';

import 'package:mentormeister/core/utils/basic_screen_imports.dart';

class TeacherSignUpController extends ChangeNotifier {
  final Map<String, bool> _availabilityMap = {
    'Monday': false,
    'Tuesday': false,
    'Wednesday': false,
    'Thursday': false,
    'Friday': false,
  };
  double _hourlyRate = 10.0;
  double get hourlyRate => _hourlyRate;

  Map<String, bool> get availabilityMap => _availabilityMap;
  bool _canContinueToPricing = false;

  bool get canContinueToPricing => _canContinueToPricing;
  set setCanContinueToPricing(bool value) {
    if (_canContinueToPricing != value) {
      _canContinueToPricing = true;
      notifyListeners();
    }
  }

  set setAvailabilityMap(String key) {
    _availabilityMap[key] = !_availabilityMap[key]!;
    notifyListeners();
  }

  set setHourlyRate(double value) {
    if (_hourlyRate != value) {
      _hourlyRate = value;
      notifyListeners();
    }
  }

  File? _profilePic;
  File? get profilePic => _profilePic;

  String? _profilePicString;
  String? get profilePicString => _profilePicString;

  set setProfilePic(File? pic) {
    if (_profilePic != pic) {
      _profilePic = pic;
      notifyListeners();
    }
  }

  set setProfilePicString(String? pic) {
    if (_profilePicString != pic) {
      _profilePicString = pic;
      notifyListeners();
    }
  }
}
