import 'package:begining/api/instalmentPlan/plan_API.dart';
import 'package:begining/api/payment/paymentAPI.dart';
import 'package:begining/model/installment.dart';
import 'package:begining/model/payment.dart';
import 'package:begining/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';

class OrderDetailChart extends StatefulWidget {
  const OrderDetailChart({
    super.key,
    required this.productName,
    required this.installment_plan_id,
  });
  final String productName;
  final int installment_plan_id;

  @override
  State<OrderDetailChart> createState() => _OrderDetailChartState();
}

class _OrderDetailChartState extends State<OrderDetailChart> {
  final Paymentapi paymentapi = Paymentapi();
  final PlanApi planApi = PlanApi();
  @override
  void initState() {
    super.initState();
    fetchPayments();
  }

  DateTime addMonths(DateTime date, int months) {
    int newMonth = date.month + months;
    int yearOffset = (newMonth - 1) ~/ 12;
    int month = ((newMonth - 1) % 12) + 1;
    int year = date.year + yearOffset;

    // Lấy ngày tối đa của tháng mới
    int dayInMonth = DateTime(year, month + 1, 0).day;

    return DateTime(year, month, date.day > dayInMonth ? dayInMonth : date.day);
  }

  int calculateMonthsPaid(List<Payment> payments, int installmentPlanId) {
    return payments
        .where(
          (payment) =>
              payment.installment_plan_id == installmentPlanId &&
              (payment.status == 'PAID' || payment.status == 'PAID LATE'),
        )
        .length;
  }

  Future<List<Payment>> fetchPayments() async {
    try {
      return await paymentapi.getPayments(widget.installment_plan_id);
    } catch (e) {
      print("Error fetching payments: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    print(
      "Building OrderDetailChart for ${widget.productName} with installment_plan_id: ${widget.installment_plan_id}",
    );

    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productName),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder<List<Payment>>(
        future: paymentapi.getPayments(widget.installment_plan_id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.blueAccent),
            );
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No payment data available'));
          }

          final payments = snapshot.data!
            ..sort((a, b) => a.due_date.compareTo(b.due_date));
          print("Payments fetched: ${payments}");
          final monthPaid = calculateMonthsPaid(
            payments,
            widget.installment_plan_id,
          );
          return SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: userProvider.isLoggedGoogle
                              ? NetworkImage(userProvider.user!.photoUrl!)
                              : const AssetImage('assets/profile/user.png')
                                    as ImageProvider,
                          backgroundColor: Colors.white,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Chart product',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(
                            Icons.bar_chart_sharp,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderDetailChart(
                                  productName: widget.productName,
                                  installment_plan_id:
                                      widget.installment_plan_id,
                                ),
                              ),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.blueAccent,
                            ),
                            shape: MaterialStateProperty.all<CircleBorder>(
                              const CircleBorder(),
                            ),
                            padding: MaterialStateProperty.all(
                              const EdgeInsets.all(4),
                            ),
                            minimumSize: MaterialStateProperty.all(
                              const Size(24, 24),
                            ),
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(
                            Icons.fire_truck,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.blueAccent,
                            ),
                            shape: MaterialStateProperty.all<CircleBorder>(
                              const CircleBorder(),
                            ),
                            padding: MaterialStateProperty.all(
                              const EdgeInsets.all(4),
                            ),
                            minimumSize: MaterialStateProperty.all(
                              const Size(24, 24),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 200,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: PieChart(
                              PieChartData(
                                sections: List.generate(
                                  Installment.getInstallmentById(
                                    widget.installment_plan_id,
                                  ).total_month,
                                  (index) {
                                    Color color = Colors.white;

                                    if (index < payments.length) {
                                      if (payments[index].status == "OVERDUE") {
                                        color = Colors.red;
                                      } else if (payments[index].status ==
                                          "PAID") {
                                        color = Colors.green;
                                      } else if (payments[index].status ==
                                          "PAID LATE") {
                                        color = Colors.yellow;
                                      }
                                    }

                                    return PieChartSectionData(
                                      showTitle: false,
                                      value:
                                          100 /
                                          Installment.getInstallmentById(
                                            widget.installment_plan_id,
                                          ).total_month,
                                      borderSide: const BorderSide(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                      color: color,
                                      radius: 50,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...List.generate(
                                  Installment.getInstallmentById(
                                    widget.installment_plan_id,
                                  ).total_month,
                                  (index) {
                                    Color color = Colors.white;
                                    DateTime dueDate;

                                    if (index < payments.length) {
                                      final paymentStatus =
                                          payments[index].status;
                                      if (paymentStatus == "OVERDUE") {
                                        color = Colors.red;
                                      } else if (paymentStatus == "PAID") {
                                        color = Colors.green;
                                      } else if (paymentStatus == "PAID LATE") {
                                        color = Colors.yellow;
                                      }
                                      dueDate = payments[index].due_date;
                                    } else {
                                      // Tính ngày đến hạn tiếp theo nếu chưa có payment
                                      dueDate = addMonths(
                                        payments.isNotEmpty
                                            ? payments.last.due_date
                                            : DateTime.now(),
                                        index - payments.length + 1,
                                      );
                                    }

                                    return LegendItem(
                                      color: color,
                                      text: dueDate.toString().split(' ')[0],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Months Paid: ${payments.where((p) => p.status == "PAID" || p.status == "PAID LATE").length} of ${Installment.getInstallmentById(widget.installment_plan_id).total_month}',

                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Remaining Balance: \$${((Installment.getInstallmentById(widget.installment_plan_id).total_month - calculateMonthsPaid(payments, widget.installment_plan_id)) * payments.last.amount).toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 20),
                    DataTable(
                      dataRowColor: MaterialStateProperty.all(Colors.white),
                      dataRowHeight: 40,
                      headingRowHeight: 40,
                      headingRowColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 164, 188, 244),
                      ),
                      columns: const [
                        DataColumn(label: Text('Due Date')),
                        DataColumn(label: Text('Amount')),
                        DataColumn(label: Text('Status')),
                      ],
                      rows: List.generate(
                        Installment.getInstallmentById(
                          widget.installment_plan_id,
                        ).total_month,
                        (index) {
                          final isPaid = index < payments.length;
                          final dueDate = isPaid
                              ? payments[index].due_date
                              : addMonths(
                                  payments.last.due_date,
                                  index - payments.length + 1,
                                );
                          final amount = isPaid
                              ? payments[index].amount
                              : payments
                                    .last
                                    .amount; // lấy giá trị cuối cho các tháng sau
                          final status = isPaid
                              ? payments[index].status
                              : 'Upcoming';

                          return DataRow(
                            cells: [
                              DataCell(Text(dueDate.toString().split(' ')[0])),
                              DataCell(Text('${amount.toStringAsFixed(2)}')),
                              DataCell(
                                Text(
                                  status,
                                  style: TextStyle(
                                    color: isPaid
                                        ? (status == "OVERDUE"
                                              ? Colors.red
                                              : (status == "PAID"
                                                    ? Colors.green
                                                    : status == "PAID LATE"
                                                    ? Colors.orange
                                                    : Colors.grey))
                                        : Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Check if last payment is paid and today's date has passed the last payment's due date
                    if (payments.isNotEmpty &&
                        (payments.last.status == 'OVERDUE' ||
                            payments.last.status == 'PENDING'))
                      Center(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFF007FFF),
                            ),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                            ),
                          ),
                          onPressed: () {
                            // Find first payment with OVERDUE or PENDING status
                            final paymentToPay = payments.firstWhere(
                              (payment) =>
                                  payment.installment_plan_id ==
                                      widget.installment_plan_id &&
                                  (payment.status == 'OVERDUE' ||
                                      payment.status == 'PENDING'),
                              orElse: () => throw Exception(
                                'No overdue or pending payment found',
                              ),
                            );

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Confirm Payment"),
                                  content: Text(
                                    "Are you sure you want to pay this ${paymentToPay.status.toLowerCase()} installment now?",
                                  ),
                                  actions: [
                                    TextButton(
                                      child: const Text(
                                        "Cancel",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: const Text(
                                        "Pay",
                                        style: TextStyle(
                                          color: Color(0xFF007FFF),
                                          fontSize: 16,
                                        ),
                                      ),
                                      onPressed: () async {
                                        Navigator.of(context).pop();

                                        if (paymentToPay.status == 'OVERDUE') {
                                          // For OVERDUE: update to PAID LATE and reset late fee
                                          await paymentapi.updatePayment(
                                            paymentId: paymentToPay.id,
                                            status: "PAID LATE",
                                            paidDate: DateTime.now(),
                                          );

                                          // Reset late fee for overdue payments
                                          await planApi
                                              .updateInstallmentPlanLateFee(
                                                planId:
                                                    widget.installment_plan_id,
                                                lateFee: 0.0,
                                              );
                                        } else if (paymentToPay.status ==
                                            'PENDING') {
                                          // For PENDING: update to PAID only
                                          await paymentapi.updatePayment(
                                            paymentId: paymentToPay.id,
                                            status: "PAID",
                                            paidDate: DateTime.now(),
                                          );
                                        }

                                        // Refresh UI
                                        setState(() {});

                                        // Hiện popup thành công
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text(
                                                "Payment Successful",
                                              ),
                                              content: Text(
                                                "Your ${paymentToPay.status.toLowerCase()} payment has been paid successfully.",
                                              ),
                                              actions: [
                                                TextButton(
                                                  child: const Text("OK"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: const Text(
                            'Pay Right Now',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String text;
  const LegendItem({super.key, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 15,
          height: 15,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1),
              color: color,
            ),
          ),
        ),
        const SizedBox(width: 5),
        Text(text, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}
