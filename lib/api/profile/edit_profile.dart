import 'dart:convert';
import 'package:begining/api/auth/id_token.dart';
import 'package:begining/model/user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileAPI {
  final IdToken _idToken = IdToken();

  /// Update User Profile
  Future<void> updateUserProfile({
    String? name,
    String? phone,
    String? province,
    String? street,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final String? authToken = prefs.getString('auth_token');
    final String? rawUserId = await _idToken.getUserIdFromToken();
    final int? userId = rawUserId != null ? int.tryParse(rawUserId) : null;

    try {
      final String apiUrl =
          "${dotenv.env['BASE_URL']}/api/v1/user/profile/$userId";

      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          "accept": "*/*",
          "Authorization": "Bearer $authToken",
        },
        body: jsonEncode({
          "name": name,
          "phone": phone,
          "province": province,
          "street": street,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final Map<String, dynamic> data = responseData['data'];

        print("User profile updated successfully: ${responseData['message']}");
        final currentUser = User.getMockUser();
        currentUser.name = data['name'] ?? currentUser.name;
        currentUser.phone = data['phone'] ?? currentUser.phone;
        currentUser.province = data['province'] ?? currentUser.province;
        currentUser.street = data['street'] ?? currentUser.street;
      } else {
        print("Failed to update user profile: ${response.statusCode}");
        print("Response body: ${response.body}");
        throw Exception("Failed to update user profile");
      }
    } catch (e) {
      print("Error updating user profile: $e");
      throw Exception("Failed to update user profile");
    }
  }
}
