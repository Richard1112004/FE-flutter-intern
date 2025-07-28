import 'package:begining/model/user.dart';
import 'package:begining/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class RegisterAPI {
  Future<bool> saveUserToBackend(User firebaseUser) async {
    final url = Uri.parse(
      'https://02f4504e54e1.ngrok-free.app/api/v1/user/register',
    );

    final requestBody = {
      'email': firebaseUser.email,
      'password': firebaseUser.password,
      'phone': firebaseUser.phone,
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
        print('✅ User saved to backend successfully.');
        return true;
      } else {
        try {
          final error = jsonDecode(response.body);
          print(
            '❌ [Server Error] ${error['message'] ?? 'Unknown error message'}',
          );
        } catch (e) {
          print('❌ [Decode Error] Response không phải JSON:');
          print(response.body);
        }
        return false;
      }
    } catch (e) {
      print('❌ [Network Error] Không kết nối được đến server: $e');
      return false;
    }
  }
}
