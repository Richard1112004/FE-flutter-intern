class Payment {
  int id;
  final double amount;
  final int installment_plan_id;
  final String status;
  final DateTime due_date;
  final DateTime paid_date;
  static List<Payment> payments = [];

  Payment({
    this.id = 0,
    required this.amount,
    required this.installment_plan_id,
    required this.status,
    required this.due_date,
    required this.paid_date,
  }) {
    payments.add(this);
  }

  factory Payment.fromMap(Map<String, dynamic> map) {
    return Payment(
      id: map['id'] ?? 0,
      amount: (map['amount'] ?? 0).toDouble(),
      installment_plan_id: map['installmentPlan']?['id'] ?? 0,
      status: map['status'] ?? '',
      due_date: DateTime.tryParse(map['dueDate'] ?? '') ?? DateTime.now(),
      paid_date: DateTime.tryParse(map['paidDate'] ?? '') ?? DateTime.now(),
    );
  }

  @override
  String toString() {
    return 'Payment{id: $id, amount: \$${amount.toStringAsFixed(2)}, installment_plan_id: $installment_plan_id, status: $status, due_date: $due_date, paid_date: $paid_date}';
  }
}
