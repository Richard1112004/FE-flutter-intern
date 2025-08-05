import 'package:begining/api/auth/id_token.dart';
import 'package:begining/model/CartItem.dart';
import 'package:begining/model/order.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class OrderApi {
  final IdToken _idToken = IdToken();

  Future<Map<String, dynamic>> createOrder({
    required String status,
    required double total,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final String? authToken = prefs.getString('auth_token');

    // Lấy user_id từ token
    final String? rawUserId = await _idToken.getUserIdFromToken();
    final int? userId = rawUserId != null ? int.tryParse(rawUserId) : null;

    try {
      final String apiUrl = "${dotenv.env['BASE_URL']}/api/v1/orders";

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          "accept": "*/*",
          "Authorization": "Bearer $authToken",
        },
        body: jsonEncode({"status": status, "total": total, "user_id": userId}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        print("Order created successfully: $responseData");
        return responseData;
      } else {
        print("Failed to create order: ${response.statusCode}");
        print("Response body: ${response.body}");
        throw Exception("Failed to create order");
      }
    } catch (e) {
      print("Error creating order: $e");
      throw Exception("Failed to create order");
    }
  }

  // GET all orders
  Future<List<Order>> getAllOrders() async {
    final String? rawUserId = await _idToken.getUserIdFromToken();
    final int? userId = rawUserId != null ? int.tryParse(rawUserId) : null;
    final prefs = await SharedPreferences.getInstance();
    final String? authToken = prefs.getString('auth_token');

    try {
      final String apiUrl = "${dotenv.env['BASE_URL']}/api/v1/orders/all/$userId";
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

        // Clear orders trước khi thêm mới
        Order.orders.clear();
        data.map((item) => Order.fromMap(item)).toList();
        print("Order.orders: ${Order.orders} orders fetched successfully");
        return Order.orders;
      } else {
        print("Failed to fetch orders: ${response.statusCode}");
        print("Response body: ${response.body}");
        throw Exception("Failed to fetch orders");
      }
    } catch (e) {
      print("Error fetching orders: $e");
      throw Exception("Failed to fetch orders");
    }
  }
}
