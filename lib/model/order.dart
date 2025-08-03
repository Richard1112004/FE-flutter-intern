class Order {
  int id;
  final String userId;
  final DateTime createdAt;
  final double total;
  final String status;
  static List<Order> orders = [];

  Order({
    this.id = 0,
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
      id: map['id'] ?? 0,
      userId: map['user']?['id']?.toString() ?? '',
      createdAt: DateTime.tryParse(map['createdAt'] ?? '') ?? DateTime.now(),
      total: (map['total'] ?? 0).toDouble(),
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
    int id,
    String userId,
    DateTime createdAt,
    List<String> image,
    List<int> productID,
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
