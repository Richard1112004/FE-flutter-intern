class Order {
  String id;
  final String userId;
  final DateTime createdAt;
  final double total;
  final String status;
  static List<Order> orders = [];

  Order({
    this.id = '',
    required this.userId,
    required this.createdAt,
    required this.total,
    required this.status,
  }) {
    orders.add(this);
  }

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

  @override
  String toString() {
    return 'Order{id: $id, userId: $userId, createdAt: $createdAt, total: \$${total.toStringAsFixed(2)}, status: $status}';
  }

  // Mock data
  static List<Order> getMockOrders() {
    return orders;
  }


  static createOrder(
    String id,
    String userId,
    DateTime createdAt,
    double total,
    String status,
  ) {
    return Order(
      id: id,
      userId: userId,
      createdAt: createdAt,
      total: total,
      status: status,
    );
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
