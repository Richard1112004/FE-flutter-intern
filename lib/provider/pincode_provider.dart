import 'package:flutter/material.dart';

class PinCodeProvider with ChangeNotifier {
  String _enteredPin = '';
  bool _isPinVisible = false;
  bool _isCompleted = false;

  String get enteredPin => _enteredPin;
  bool get isPinVisible => _isPinVisible;
  bool get isCompleted => _isCompleted;

  void addDigit(int digit) {
    if (_enteredPin.length < 4) {
      _enteredPin += digit.toString();
      if (_enteredPin.length == 4) {
        _isCompleted = true;
      }
      notifyListeners();
    }
  }

  void removeLastDigit() {
    if (_enteredPin.isNotEmpty) {
      _enteredPin = _enteredPin.substring(0, _enteredPin.length - 1);
      notifyListeners();
    }
  }

  void togglePinVisibility() {
    _isPinVisible = !_isPinVisible;
    notifyListeners();
  }

  void resetPin() {
    _enteredPin = '';
    notifyListeners();
  }
}