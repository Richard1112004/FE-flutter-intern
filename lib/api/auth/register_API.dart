import 'package:begining/model/user.dart';
import 'package:begining/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

class RegisterAPI {
  final String baseUrl = dotenv.env['BASE_URL'] ?? '';
  Future<bool> saveUserToBackend(firebase.User? firebaseUser, String password, String phone) async {
    final url = Uri.parse(
      '$baseUrl/api/v1/user/firebase',
    );

    final requestBody = {
      'idToken': await firebaseUser?.getIdToken(),
      'phone': phone,
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
