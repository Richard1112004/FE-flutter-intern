import 'package:begining/api/auth/id_token.dart';
import 'package:begining/model/cartItem.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CartAPI {
  final IdToken _idToken = IdToken();
  Future<void> addToCart(int productId) async {
    final String? rawUserId = await _idToken.getUserIdFromToken();
    final int? userId = rawUserId != null ? int.tryParse(rawUserId) : null;
    final prefs = await SharedPreferences.getInstance();
    final String? authToken = await prefs.getString('auth_token');
    try {
      final String apiUrl = "${dotenv.env['BASE_URL']}/api/v1/cart-item";
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          "accept": "*/*",
          "Authorization": "Bearer $authToken",
        },
        body: jsonEncode({
          "productId": productId,
          "quantity": 1, // Assuming a default quantity of 1
          "orderId": null, // Assuming no order ID for now
          "term": 0,
          "clear": false,
          "userId": userId,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final Map<String, dynamic> data = responseData['data'];

        CartItem cartItem = CartItem.fromMap(data);

        print("Item added to cart: ${cartItem.toString()}");

        CartItem.cartItems.add(cartItem);

        print("Item added to cart successfully: ${cartItem.id}");
      } else {
        print("Failed to add item to cart: ${response.statusCode}");
        print("Response body: ${response.body}");
        throw Exception("Failed to add item to cart");
      }
    } catch (e) {
      print("Error adding to cart: $e");
      throw Exception("Failed to add item to cart");
    }
  }
}
