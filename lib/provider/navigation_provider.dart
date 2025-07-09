import 'package:begining/cart/view_cart.dart';
import 'package:begining/profile/my_profile.dart';
import 'package:begining/screen/home_screen.dart';
import 'package:flutter/material.dart';

class NavigationProvider with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setIndex(int index, BuildContext context) {
    _currentIndex = index;
    switch (index) {
      case 0:
        // Navigate to Home Screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
        break;
      case 1:
        // Navigate to Cart Screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ViewCart()),
        );
        break;
      case 2:
        // Navigate to Profile Screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MyProfile()),
        );
        break;
    }
    notifyListeners();
  }
}
