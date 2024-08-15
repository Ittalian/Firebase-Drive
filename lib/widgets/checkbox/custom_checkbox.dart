import 'package:flutter/foundation.dart';

class CustomCheckbox extends ChangeNotifier {
  bool _isChecked = false;
  bool get isChecked => _isChecked;

  void handleCheckbox(bool? value) {
    _isChecked = value ?? false;
    notifyListeners();
  }
}
