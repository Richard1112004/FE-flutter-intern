import 'package:flutter/material.dart';

class RepeatPasswordProvider with ChangeNotifier {
  bool _currentIndex = false;

  bool get currentIndex => _currentIndex;

  void setIndex(bool index) {
    _currentIndex = index;
    notifyListeners();
  }
}