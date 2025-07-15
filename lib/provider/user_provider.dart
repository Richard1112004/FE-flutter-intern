import 'package:begining/model/user.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserProvider with ChangeNotifier {
  GoogleSignInAccount? _user;

  GoogleSignInAccount? get user => _user;

  void setUser(GoogleSignInAccount? user) {
    _user = user;
    User.createGoogleUser(
        user?.email ?? '',
        user?.displayName ?? '',
        user?.photoUrl ?? '',
      );
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }

  bool get isLoggedIn => _user != null;
}
