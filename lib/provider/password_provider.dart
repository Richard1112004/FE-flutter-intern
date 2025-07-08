import 'package:flutter/material.dart';

class PasswordProvider with ChangeNotifier {
  bool _currentIndex = false;

  bool get currentIndex => _currentIndex;

  void setIndex(bool index) {
    _currentIndex = index;
    notifyListeners();
  }
}