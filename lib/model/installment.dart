class Installment {
  int id;
  final double installment_amount;
  double late_fee;
  final DateTime due_date;
  final DateTime start_date;
  final int total_month;
  final int cart_item_id;
  final String status;
  static List<Installment> installments = [];

  Installment({
    this.id = 0,
    required this.installment_amount,
    required this.late_fee,
    required this.due_date,
    required this.start_date,
    required this.total_month,
    required this.cart_item_id,
    required this.status,
  }) {
    installments.add(this);
  }

  factory Installment.fromMap(Map<String, dynamic> map) {
    return Installment(
      id: map['id'] ?? 0,
      installment_amount:
          (map['installmentAmount'] ?? map['installment_amount'] ?? 0)
              .toDouble(),
      late_fee: (map['lateFee'] ?? map['late_fee'] ?? 0).toDouble(),
      due_date:
          DateTime.tryParse(map['dueDate'] ?? map['due_date'] ?? '') ??
          DateTime.now(),
      start_date:
          DateTime.tryParse(map['startDate'] ?? map['start_date'] ?? '') ??
          DateTime.now(),
      total_month: map['totalMonth'] ?? map['total_month'] ?? 0,
      cart_item_id: map['cartItem']?['id'] ?? map['cart_item_id'] ?? 0,
      status: map['status'] ?? '',
    );
  }

  @override
  String toString() {
    return 'Installment{id: $id, installment_amount: \$${installment_amount.toStringAsFixed(2)}, late_fee: \$${late_fee.toStringAsFixed(2)}, due_date: $due_date, start_date: $start_date, total_month: $total_month, cart_item_id: $cart_item_id, status: $status}';
  }

  static Installment getInstallmentsByCartItemId(int cartItemId) {
    return installments.where((installment) => installment.cart_item_id == cartItemId).first;
  }

  static Installment getInstallmentById(int id) {
    return installments.firstWhere((installment) => installment.id == id);
  }
}
