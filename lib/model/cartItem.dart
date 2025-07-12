// First, you need to define CartItem and Order classes
class CartItem {
  final String id;
  final String productName;
  final int quantity;
  final double price;
  final double term;
  final String userId; // Added userId to link to User
  final String orderId; // Added productId to link to Product

  CartItem({
    required this.id,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.term,
    required this.userId, // Initialize userId
    required this.orderId, // Initialize orderId
  });

  // Factory constructor for creating CartItem from Map
  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'] ?? '',
      productName: map['productName'] ?? '',
      quantity: map['quantity'] ?? 0,
      price: map['price']?.toDouble() ?? 0.0,
      term: map['term']?.toDouble() ?? 0.0,
      userId: map['userId'] ?? '',
      orderId: map['orderId'] ?? '',
    );
  }

  // Mock data
  static List<CartItem> getMockCartItems() {
    return [
      CartItem(
        id: 'cart_1',
        productName: 'Laptop Pro 15"',
        quantity: 1,
        price: 1299.99,
        term: 6,
        userId: '1', // John Doe
        orderId: 'order_1',
      ),
      CartItem(
        id: 'cart_2',
        productName: 'Wireless Headphones',
        quantity: 2,
        price: 149.99,
        term: 12,
        userId: '1', // John Doe
        orderId: 'order_1',
      ),
      CartItem(
        id: 'cart_3',
        productName: 'Smartphone 128GB',
        quantity: 1,
        price: 699.99,
        term: 9,
        userId: '2', // Jane Smith
        orderId: 'order_2',
      ),
      CartItem(
        id: 'cart_4',
        productName: 'Gaming Mouse',
        quantity: 1,
        price: 79.99,
        term: 6,
        userId: '3', // Mike Johnson
        orderId: 'order_3',
      ),
      CartItem(
        id: 'cart_5',
        productName: 'Monitor 27" 4K',
        quantity: 1,
        price: 449.99,
        term: 12,
        userId: '3', // Mike Johnson
        orderId: 'order_3',
      ),
      CartItem(
        id: 'cart_6',
        productName: 'Mechanical Keyboard',
        quantity: 1,
        price: 129.99,
        term: 9,
        userId: '4', // Sarah Wilson
        orderId: 'order_4',
      ),
      CartItem(
        id: 'cart_7',
        productName: 'Tablet 10"',
        quantity: 1,
        price: 299.99,
        term: 12,
        userId: '5', // David Brown
        orderId: 'order_5',
      ),
      CartItem(
        id: 'cart_8',
        productName: 'External SSD 1TB',
        quantity: 2,
        price: 89.99,
        term: 6,
        userId: '5', // David Brown
        orderId: 'order_5',
      ),
    ];
  }

  // Get mock cart items for a specific user
  static List<CartItem> getMockCartItemsByUserId(String userId) {
    return getMockCartItems().where((item) => item.userId == userId).toList();
  }

  // Get mock cart items for a specific order
  static List<CartItem> getMockCartItemsByOrderId(String orderId) {
    return getMockCartItems().where((item) => item.orderId == orderId).toList();
  }

  // Get a single mock cart item
  static CartItem getMockCartItem() {
    return getMockCartItems().first;
  }
}
