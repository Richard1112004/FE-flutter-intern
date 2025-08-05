import 'package:begining/api/auth/id_token.dart';
import 'package:begining/model/CartItem.dart';
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

        CartItem.fromMap(data);

        // CartItem.cartItems.add(cartItem);

        print("Cart items after addition: ${CartItem.cartItems}");
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

  Future<List<CartItem>> getCartItems() async {
    final String? rawUserId = await _idToken.getUserIdFromToken();
    final int? userId = rawUserId != null ? int.tryParse(rawUserId) : null;
    final prefs = await SharedPreferences.getInstance();
    final String? authToken = await prefs.getString('auth_token');
    try {
      final String apiUrl = "${dotenv.env['BASE_URL']}/api/v1/cart-item/all/$userId";
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

        CartItem.cartItems.clear();
        for (var item in data) {
          CartItem.fromMap(item);
        }

        return CartItem.cartItems;
      } else {
        print("Failed to fetch cart items: ${response.statusCode}");
        print("Response body: ${response.body}");
        throw Exception("Failed to fetch cart items");
      }
    } catch (e) {
      print("Error fetching cart items: $e");
      throw Exception("Failed to fetch cart items");
    }
  }

  Future<void> updateCartItemTerm(int cartItemId, int term) async {
    final prefs = await SharedPreferences.getInstance();
    final String? authToken = prefs.getString('auth_token');

    try {
      final String apiUrl = "${dotenv.env['BASE_URL']}/api/v1/cart-item/$cartItemId";

      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          "accept": "*/*",
          "Authorization": "Bearer $authToken",
        },
        body: jsonEncode({
          "term": term
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        print("Cart item updated successfully: ${responseData['message']}");
      } else {
        print("Failed to update cart item: ${response.statusCode}");
        print("Response body: ${response.body}");
        throw Exception("Failed to update cart item");
      }
    } catch (e) {
      print("Error updating cart item: $e");
      throw Exception("Failed to update cart item");
    }
  }
  Future<void> updateCartItemOrderIdClear(int cartItemId, int orderId, bool clear) async {
    final prefs = await SharedPreferences.getInstance();
    final String? authToken = prefs.getString('auth_token');

    try {
      final String apiUrl = "${dotenv.env['BASE_URL']}/api/v1/cart-item/$cartItemId";

      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          "accept": "*/*",
          "Authorization": "Bearer $authToken",
        },
        body: jsonEncode({
          "orderId": orderId,
          "clear": clear
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        print("Cart item updated successfully: ${responseData['message']}");
      } else {
        print("Failed to update cart item: ${response.statusCode}");
        print("Response body: ${response.body}");
        throw Exception("Failed to update cart item");
      }
    } catch (e) {
      print("Error updating cart item: $e");
      throw Exception("Failed to update cart item");
    }
  }
}
