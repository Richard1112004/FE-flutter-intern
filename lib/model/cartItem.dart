// First, you need to define CartItem and Order classes
import 'dart:ffi';

import 'package:provider/provider.dart';

class CartItem {
  final int id;
  int quantity;
  double term;
  final int userId; // Added userId to link to User
  int? orderId; // Added productId to link to Product
  final int product_id;

  static List<CartItem> cartItems = [];

  CartItem({
    required this.id,
    required this.quantity,
    required this.term,
    required this.userId, // Initialize userId
    required this.orderId, // Initialize orderId
    required this.product_id,
  }) {
    cartItems.add(this);
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'] ?? 0,
      quantity: map['quantity'] ?? 0,
      term: (map['term'] ?? 0).toDouble(),
      userId: map['user']?['id'] ?? 0,
      orderId: map['order']?['id'],
      product_id: map['product']?['id'] ?? 0,
    );
  }

  // String representation of CartItem
  @override
  String toString() {
    return 'CartItem{id: $id, quantity: $quantity, term: $term, userId: $userId, orderId: $orderId, product_id: $product_id}';
  }

  // Mock data
  static List<CartItem> getMockCartItems() {
    return cartItems;
  }

  static createCartItem(
    int id,
    String productName,
    int quantity,
    double price,
    double term,
    int userId,
    int orderId,
    int productId,
  ) {
    // Check if product already exists in cart
    int existingItemIndex = cartItems.indexWhere(
      (item) => item.product_id == productId,
    );
    print(existingItemIndex);
    if (existingItemIndex != -1) {
      // Product exists, increment quantity by 1

      cartItems[existingItemIndex].quantity += 1;
    } else {
      // Product doesn't exist, create new CartItem
      CartItem(
        id: id,
        quantity: quantity,
        term: term,
        userId: userId,
        orderId: orderId,
        product_id: productId,
      );
    }
  }

  static decreaseCartItemQuantity(int productId) {
    // Find the index of the item to decrease
    int indexToDecrease = cartItems.indexWhere(
      (item) => item.product_id == productId,
    );
    if (indexToDecrease != -1) {
      // Decrease the quantity by 1
      if (cartItems[indexToDecrease].quantity > 1) {
        cartItems[indexToDecrease].quantity -= 1;
      }
    }
  }

  static increaseCartItemQuantity(int productId) {
    // Find the index of the item to increase
    int indexToIncrease = cartItems.indexWhere(
      (item) => item.product_id == productId,
    );
    if (indexToIncrease != -1) {
      // Increase the quantity by 1
      cartItems[indexToIncrease].quantity += 1;
    }
  }

  static removeCurrentCartItem(int productId) {
    // Find the index of the item to remove
    int indexToRemove = cartItems.indexWhere(
      (item) => item.product_id == productId,
    );
    if (indexToRemove != -1) {
      // Remove the item from the list
      cartItems.removeAt(indexToRemove);
    }
  }

  // Get mock cart items for a specific user
  static List<CartItem> getMockCartItemsByUserId(int userId) {
    return getMockCartItems().where((item) => item.userId == userId).toList();
  }

  static CartItem? getMockCartItemById(int id) {
    try {
      return getMockCartItems().firstWhere((item) => item.id == id);
    } catch (e) {
      return null;
    }
  }

  // Get mock cart items for a specific order
  static List<CartItem> getMockCartItemsByOrderId(int orderId) {
    print('Searching for orderId: $orderId');
    return getMockCartItems().where((item) {
      print('Item orderId: ${item.orderId}');
      return item.orderId == orderId;
    }).toList();
  }

  // Get a single mock cart item
  static CartItem getMockCartItem() {
    return getMockCartItems().first;
  }

  static clearCartItems() {
    cartItems.clear();
  }
}
