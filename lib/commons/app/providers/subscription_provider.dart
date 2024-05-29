import 'package:mentormeister/core/utils/basic_screen_imports.dart';

class SubscriptionProvider extends ChangeNotifier {
  SubscriptionProvider();

  bool _isSubscribed = false;
  bool get isSubscribed => _isSubscribed;

  String _package = "Free";
  DateTime _validTill = DateTime.now();
  double _price = 0;

  String get package => _package;
  DateTime get validTill => _validTill;
  double get price => _price;

  set isSubscribed(bool value) {
    if (_isSubscribed != value) {
      _isSubscribed = value;
      Future.delayed(
        Duration.zero,
        notifyListeners,
      );
    }
  }

  set package(String value) {
    if (_package != value) {
      _package = value;
      Future.delayed(
        Duration.zero,
        notifyListeners,
      );
    }
  }

  set validTill(DateTime value) {
    if (_validTill != value) {
      _validTill = value;
      Future.delayed(
        Duration.zero,
        notifyListeners,
      );
    }
  }

  set price(double value) {
    if (_price != value) {
      _price = value;
      Future.delayed(
        Duration.zero,
        notifyListeners,
      );
    }
  }
}
