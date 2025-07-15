import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:begining/provider/user_provider.dart';

class AuthService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  static Future<void> signOut(BuildContext context) async {
    try {
      // Kiểm tra xem có user nào đang đăng nhập không
      final currentUser = _googleSignIn.currentUser;

      if (currentUser != null) {
        // Chỉ signOut nếu có user
        await _googleSignIn.signOut();
        print('Google sign out successful');
      } else {
        print('No user to sign out');
      }

      // Disconnect có thể fail, nên bỏ qua lỗi này
      try {
        await _googleSignIn.disconnect();
        print('Google disconnect successful');
      } catch (disconnectError) {
        print('Disconnect failed (this is normal): $disconnectError');
        // Không cần throw lỗi này vì disconnect thường fail
      }

      // Clear user từ provider (luôn thực hiện)
      if (context.mounted) {
        Provider.of<UserProvider>(context, listen: false).setUser(null);
      }

      print('User signed out successfully');
    } catch (error) {
      print('Sign out error: $error');
      // Vẫn clear user local nếu có lỗi
      if (context.mounted) {
        Provider.of<UserProvider>(context, listen: false).setUser(null);
      }
    }
  }

  static Future<GoogleSignInAccount?> signIn() async {
    try {
      final account = await _googleSignIn.signIn();
      print('Sign in result: ${account?.email ?? 'null'}');
      return account;
    } catch (error) {
      print('Sign in error: $error');
      return null;
    }
  }
}
