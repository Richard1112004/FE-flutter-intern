import 'package:begining/cart/view_cart.dart';
import 'package:begining/profile/my_profile.dart';
import 'package:begining/provider/user_provider.dart';
import 'package:begining/screen/home_screen.dart';
import 'package:begining/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigationProvider with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;
  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void setIndex(int index, BuildContext context) {
    _currentIndex = index;

    final userProvider = Provider.of<UserProvider>(context, listen: false);
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
        if (!userProvider.isLoggedIn) {
          // If user is not logged in, show a message or redirect to login
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
          return;
        }
        else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ViewCart()),
          );
        }
        break;
      case 2:
        // Navigate to Profile Screen
        if (!userProvider.isLoggedIn) {
          // If user is not logged in, show a message or redirect to login
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MyProfile()),
          );
        }
        break;
    }
    notifyListeners();
  }
}
