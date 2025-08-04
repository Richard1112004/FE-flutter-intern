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

  Future<List<Payment>> getPayments(int installment_plan_id) async {
    final prefs = await SharedPreferences.getInstance();
    final String? authToken = prefs.getString('auth_token');

    final String apiUrl =
        "${dotenv.env['BASE_URL']}/api/v1/payment/$installment_plan_id";

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
        Payment.payments.clear(); // Clear previous payments
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final List<dynamic> data = responseData['data'];
        print("Payments fetched successfully: $data");
        final dataReturned = data.map((item) => Payment.fromMap(item)).toList();
        print("All Payments: ${Payment.payments}");
        return dataReturned;
      } else {
        throw Exception("Failed to fetch payments: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching payments: $e");
    }
  }

  Future<void> updatePayment({
    required int paymentId,
    required String status,
    required DateTime paidDate,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final String? authToken = prefs.getString('auth_token');

    final String apiUrl = "${dotenv.env['BASE_URL']}/api/v1/payment/$paymentId";

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          "accept": "*/*",
          "Authorization": "Bearer $authToken",
        },
        body: jsonEncode({
          "status": status,
          "paid_date": paidDate.toIso8601String(), 
        }),
      );

      if (response.statusCode == 200) {
        print("Payment updated successfully: ${response.body}");
      } else {
        print("Failed to update payment: ${response.statusCode}");
        print("Response body: ${response.body}");
        throw Exception("Failed to update payment");
      }
    } catch (e) {
      print("Error updating payment: $e");
      throw Exception("Failed to update payment");
    }
  }
}
