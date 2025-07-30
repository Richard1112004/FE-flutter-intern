import 'package:begining/model/user.dart';
import 'package:begining/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class ForgotApi {
  Future<bool> checkUserExists(String email) async {
    final String apiUrl = "${dotenv.env['BASE_URL']}/api/v1/user/check-email";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"email": email}),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print("Error: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("Exception: $e");
      return false;
    }
  }

  String createJwtToken({
    required String id,
    required String email,
    required String role,
    required String secretKeyBase64,
    required int ttlMillis,
  }) {
    final jwt = JWT(
      {
        'scope': role,
        'iat': DateTime.now().millisecondsSinceEpoch ~/ 1000, // issued at
        'nbf': DateTime.now().millisecondsSinceEpoch ~/ 1000, // not before
        'exp':
            (DateTime.now().millisecondsSinceEpoch + ttlMillis) ~/
            1000, // expiry
      },
      jwtId: id,
      subject: email,
    );

    return jwt.sign(SecretKey(secretKeyBase64, isBase64Encoded: true), algorithm: JWTAlgorithm.HS256);
  }

  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    final url = Uri.parse('${dotenv.env['BASE_URL']}/api/v1/user/password');
    print("🔗 Reset Password URL: $url");
    print("🔑 Token: $token");
    print("🔐 New Password: $newPassword");
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'newPassword': newPassword, 'token': token}),
    );

    if (response.statusCode == 200) {
      print("✅ Password reset successful: ${response.body}");
    } else {
      print("❌ Failed: ${response.statusCode} => ${response.body}");
    }
  }
}
