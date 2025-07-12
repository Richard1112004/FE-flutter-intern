class Order {
  final String id;
  final String userId;
  final DateTime createdAt;
  final double total;
  final String status;

  Order({
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.total,
    required this.status,
  });

  // Factory constructor for creating Order from Map
  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      createdAt: DateTime.parse(
        map['createdAt'] ?? DateTime.now().toIso8601String(),
      ),
      total: map['total']?.toDouble() ?? 0.0,
      status: map['status'] ?? '',
    );
  }

  // Mock data
  static List<Order> getMockOrders() {
    return [
      Order(
        id: 'order_1',
        userId: '1', // John Doe
        createdAt: DateTime.now().subtract(Duration(days: 5)),
        total: 1599.97, // Laptop Pro + 2x Wireless Headphones
        status: 'delivered',
      ),
      Order(
        id: 'order_2',
        userId: '2', // Jane Smith
        createdAt: DateTime.now().subtract(Duration(days: 3)),
        total: 699.99, // Smartphone
        status: 'shipped',
      ),
      Order(
        id: 'order_3',
        userId: '3', // Mike Johnson
        createdAt: DateTime.now().subtract(Duration(days: 2)),
        total: 529.98, // Gaming Mouse + Monitor
        status: 'processing',
      ),
      Order(
        id: 'order_4',
        userId: '4', // Sarah Wilson
        createdAt: DateTime.now().subtract(Duration(days: 1)),
        total: 129.99, // Mechanical Keyboard
        status: 'confirmed',
      ),
      Order(
        id: 'order_5',
        userId: '5', // David Brown
        createdAt: DateTime.now().subtract(Duration(hours: 12)),
        total: 479.97, // Tablet + 2x External SSD
        status: 'pending',
      ),
    ];
  }

  // Get mock orders for a specific user
  static List<Order> getMockOrdersByUserId(String userId) {
    return getMockOrders().where((order) => order.userId == userId).toList();
  }

  // Get a single mock order
  static Order getMockOrder() {
    return getMockOrders().first;
  }

  // Get mock order by ID
  static Order? getMockOrderById(String orderId) {
    try {
      return getMockOrders().firstWhere((order) => order.id == orderId);
    } catch (e) {
      return null;
    }
  }
}
