import 'package:begining/model/user.dart';
import 'package:begining/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
class LoginAPI {
  final String baseUrl = dotenv.env['BASE_URL'] ?? '';
  Future<bool> loginUser(String email, String password) async {
    final url = Uri.parse(
      '$baseUrl/api/v1/auth/user/login',
    );

    final requestBody = {
      'email': email,
      'password': password,
    };

    print('📤 [Request] Sending to $url');
    print('📤 [Request Body] $requestBody');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      print('📥 [Response Code] ${response.statusCode}');
      print('📥 [Raw Body] ${response.body}');

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        final token = responseBody['data'];

        if (token != null) {
          print('✅ Login successful. Token: $token');

          // 👉 Nếu bạn muốn lưu token để dùng sau:
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('auth_token', token);
          final tokenTest = prefs.getString('auth_token');
          print('📦 Token saved: $tokenTest');

          prefs.setBool('is_logged_in', true);
          return true;
        } else {
          print('❌ Đăng nhập thành công nhưng không nhận được token.');
          return false;
        }
      } else {
        try {
          final error = jsonDecode(response.body);
          print('❌ [Server Error] ${error['message'] ?? 'Unknown error'}');
        } catch (_) {
          print('❌ [Decode Error] Không thể phân tích JSON: ${response.body}');
        }
        return false;
      }
    } catch (e) {
      print('❌ [Network Error] Không kết nối được đến server: $e');
      return false;
    }
  }
}