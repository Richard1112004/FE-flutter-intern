import 'package:begining/model/user.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserProvider with ChangeNotifier {
  GoogleSignInAccount? _user;
  String _email = '';
  String _name = '';
  String _phone = '';
  String _password = '';

  GoogleSignInAccount? get user => _user;
  String get email => _email;
  String get name => _name;
  String get phone => _phone;
  String get password => _password;

  void setEmail(String email) {
    _email = email;
  }

  void setName(String name) {
    _name = name;
  }

  void setPhone(String phone) {
    _phone = phone;
  }

  void setPassword(String password) {
    _password = password;
  }

  void setUser(GoogleSignInAccount? user) {
    _user = user;
    if (user != null) {
      User.createGoogleUser(
        user?.email ?? '',
        user?.displayName ?? '',
        user?.photoUrl ?? '',
      );
    }
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }

  bool get isLoggedGoogle => _user != null;

  bool get isLoggedIn => User.userExistsCheck();
}
