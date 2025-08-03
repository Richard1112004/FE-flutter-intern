import 'package:begining/api/auth/id_token.dart';
import 'package:begining/model/CartItem.dart';
import 'package:begining/model/order.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PlanApi {
  final IdToken _idToken = IdToken();

  Future<Map<String, dynamic>> createInstallmentPlan({
    required int cartItemId,
    required int totalMonth,
    required double installmentAmount,
    required double lateFee,
    required String status,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final String? authToken = prefs.getString('auth_token');

    try {
      final String apiUrl = "${dotenv.env['BASE_URL']}/api/v1/installment-plan";

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          "accept": "*/*",
          "Authorization": "Bearer $authToken",
        },
        body: jsonEncode({
          "cartItemId": cartItemId,
          "totalMonth": totalMonth,
          "installmentAmount": installmentAmount,
          "lateFee": lateFee,
          "status": status,
          "startDate": startDate.toIso8601String().split('T')[0],
          "endDate": endDate.toIso8601String().split('T')[0],
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        print("Installment plan created successfully: $responseData");
        return responseData;
      } else {
        print("Failed to create installment plan: ${response.statusCode}");
        print("Response body: ${response.body}");
        throw Exception("Failed to create installment plan");
      }
    } catch (e) {
      print("Error creating installment plan: $e");
      throw Exception("Failed to create installment plan");
    }
  }
}