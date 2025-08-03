import 'package:begining/api/auth/id_token.dart';
import 'package:begining/model/CartItem.dart';
import 'package:begining/model/order.dart';
import 'package:begining/model/payment.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Paymentapi {
  Future<Payment> createPayment({
    required int installmentPlanId,
    required double amount,
    required String status,
    required DateTime dueDate,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final String? authToken = prefs.getString('auth_token');

    try {
      final String apiUrl = "${dotenv.env['BASE_URL']}/api/v1/payment";

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          "accept": "*/*",
          "Authorization": "Bearer $authToken",
        },
        body: jsonEncode({
          "installmentId": installmentPlanId,
          "status": status,
          "due_date": dueDate.toIso8601String().split('T')[0],
          "amount": amount,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final Map<String, dynamic> data = responseData['data'];
        print("Payment created successfully: $data");

        return Payment.fromMap(data);
      } else {
        print("Failed to create payment: ${response.statusCode}");
        print("Response body: ${response.body}");
        throw Exception("Failed to create payment");
      }
    } catch (e) {
      print("Error creating payment: $e");
      throw Exception("Failed to create payment");
    }
  }
}
