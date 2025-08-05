import 'package:begining/api/auth/id_token.dart';
import 'package:begining/model/CartItem.dart';
import 'package:begining/model/installment.dart';
import 'package:begining/model/notification.dart';
import 'package:begining/model/order.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
class NotificationApi {
  Future<List<NotificationModel>> getAllNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final String? authToken = prefs.getString('auth_token');
    final String apiUrl = "${dotenv.env['BASE_URL']}/api/v1/notifications";

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          "accept": "*/*",
          "Authorization": "Bearer $authToken",
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final List<dynamic> data = responseData['data'];
        NotificationModel.clearNotifications(); // Clear existing notifications

        return data.map((item) => NotificationModel.fromMap(item)).toList();
      } else {
        throw Exception("Failed to fetch notifications: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching notifications: $e");
    }
  }

  Future<NotificationModel> updateNotificationRead({
    required int notificationId,
    required bool isRead,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final String? authToken = prefs.getString('auth_token');

    final String apiUrl =
        "${dotenv.env['BASE_URL']}/api/v1/notifications/$notificationId";

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          "accept": "*/*",
          "Authorization": "Bearer $authToken",
        },
        body: jsonEncode({
          "read": isRead,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final Map<String, dynamic> data = responseData['data'];
        print("Notification updated successfully: $data");
        return NotificationModel.fromMap(data);
      } else {
        print("Failed to update notification: ${response.statusCode}");
        print("Response body: ${response.body}");
        throw Exception("Failed to update notification");
      }
    } catch (e) {
      print("Error updating notification: $e");
      throw Exception("Error updating notification");
    }
  }
}
