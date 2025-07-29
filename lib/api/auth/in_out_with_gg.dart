import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:begining/provider/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
    final String baseUrl = dotenv.env['BASE_URL'] ?? '';
    try {
      print('🔑 Bắt đầu đăng nhập Google...');
      final account = await _googleSignIn.signIn();
      print('📧 Sign in result: ${account?.email ?? 'null'}');

      final ggauth = await account?.authentication;
      final idToken = ggauth?.idToken;

      if (idToken == null) {
        print('❌ Không lấy được idToken từ Google');
        return null;
      }

      print('📤 Gửi idToken lên server... ${idToken}');
      final response = await http.post(
        Uri.parse('${baseUrl}/api/v1/user/google'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'idToken': idToken}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final jwtToken = data['data']; // backend trả về key 'data'
        print('✅ Nhận JWT Token thành công: $jwtToken');
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('is_logged_in', true);
        await prefs.setBool('isLoggedGoogle', true);
      } else {
        print(
          '⚠️ Đăng nhập thất bại: ${response.statusCode}, body: ${response.body}',
        );
      }

      return account;
    } catch (error) {
      print('🔥 Sign in error: $error');
      return null;
    }
  }
}
