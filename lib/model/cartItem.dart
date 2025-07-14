// First, you need to define CartItem and Order classes
import 'package:provider/provider.dart';

class CartItem {
  final String id;
  int quantity;
  double term;
  final String userId; // Added userId to link to User
  final String orderId; // Added productId to link to Product
  final String product_id;

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

  // Factory constructor for creating CartItem from Map
  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'] ?? '',
      quantity: map['quantity'] ?? 0,
      term: map['term']?.toDouble() ?? 0.0,
      userId: map['userId'] ?? '',
      orderId: map['orderId'] ?? '',
      product_id: map['product_id'] ?? '',
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

  static final CartItem iPhone_16 = CartItem(
    id: 'cart_1',
    quantity: 1,
    term: 0,
    userId: '1',
    orderId: 'order_1',
    product_id: 'prod_1',
  );
  static final CartItem iPhone_15 = CartItem(
    id: 'cart_2',
    quantity: 1,
    term: 0,
    userId: '1',
    orderId: 'order_1',
    product_id: 'prod_2',
  );

  static createCartItem(
    String id,
    String productName,
    int quantity,
    double price,
    double term,
    String userId,
    String orderId,
    String productId,
  ) {
    print(CartItem.iPhone_15);
    print(CartItem.iPhone_16);
    print(productId);
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

  static decreaseCartItemQuantity(String productId) {
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

  static increaseCartItemQuantity(String productId) {
    // Find the index of the item to increase
    int indexToIncrease = cartItems.indexWhere(
      (item) => item.product_id == productId,
    );
    if (indexToIncrease != -1) {
      // Increase the quantity by 1
      cartItems[indexToIncrease].quantity += 1;
    }
  }

  static removeCurrentCartItem(String productId) {
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
  static List<CartItem> getMockCartItemsByUserId(String userId) {
    return getMockCartItems().where((item) => item.userId == userId).toList();
  }

  // Get mock cart items for a specific order
  static List<CartItem> getMockCartItemsByOrderId(String orderId) {
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
}
