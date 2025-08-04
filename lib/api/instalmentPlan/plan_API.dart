import 'package:begining/api/auth/id_token.dart';
import 'package:begining/model/CartItem.dart';
import 'package:begining/model/installment.dart';
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
        final installmentResponse = jsonDecode(response.body);
        print("Installment plan created successfully: $installmentResponse");
        return installmentResponse;
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

  Future<List<Installment>> getAllInstallmentPlans() async {
    final prefs = await SharedPreferences.getInstance();
    final String? authToken = prefs.getString('auth_token');

    final String apiUrl =
        "${dotenv.env['BASE_URL']}/api/v1/installment-plan/all";

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
        final List<Installment> installments = data
            .map((item) => Installment.fromMap(item))
            .toList();
        print("Installment.installments: ${Installment.installments}");
        return installments;
      } else {
        throw Exception(
          "Failed to fetch installment plans: ${response.statusCode}",
        );
      }
    } catch (e) {
      throw Exception("Error fetching installment plans: $e");
    }
  }

  Future<void> updateInstallmentPlanLateFee({
    required int planId,
    required double lateFee,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final String? authToken = prefs.getString('auth_token');

    final String apiUrl =
        "${dotenv.env['BASE_URL']}/api/v1/installment-plan/$planId";

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          "accept": "*/*",
          "Authorization": "Bearer $authToken",
        },
        body: jsonEncode({"lateFee": lateFee}),
      );

      if (response.statusCode == 200) {
        print(
          "Installment plan late fee updated successfully: ${response.body}",
        );
        Installment.getInstallmentById(planId).late_fee = lateFee;
      } else {
        print("Failed to update installment plan: ${response.statusCode}");
        print("Response body: ${response.body}");
        throw Exception("Failed to update installment plan");
      }
    } catch (e) {
      print("Error updating installment plan: $e");
      throw Exception("Failed to update installment plan");
    }
  }
}
