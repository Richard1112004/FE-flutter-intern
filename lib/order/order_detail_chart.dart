import 'package:begining/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';

class OrderDetailChart extends StatefulWidget {
  const OrderDetailChart({super.key, required this.productName});
  final String productName;

  @override
  State<OrderDetailChart> createState() => _OrderDetailChartState();
}

class _OrderDetailChartState extends State<OrderDetailChart> {
  bool isPaid = false; // Trạng thái thanh toán

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productName),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
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
                          : const AssetImage('assets/profile/user.png') as ImageProvider,
                      backgroundColor: Colors.white,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Chart product',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.bar_chart_sharp, color: Colors.white),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderDetailChart(productName: widget.productName),
                          ),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
                        shape: MaterialStateProperty.all<CircleBorder>(const CircleBorder()),
                        padding: MaterialStateProperty.all(const EdgeInsets.all(4)),
                        minimumSize: MaterialStateProperty.all(const Size(24, 24)),
                      ),
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.fire_truck, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
                        shape: MaterialStateProperty.all<CircleBorder>(const CircleBorder()),
                        padding: MaterialStateProperty.all(const EdgeInsets.all(4)),
                        minimumSize: MaterialStateProperty.all(const Size(24, 24)),
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
                            sections: [
                              PieChartSectionData(
                                showTitle: false,
                                value: 20,
                                borderSide: const BorderSide(color: Colors.black, width: 1),
                                color: Colors.white,
                                radius: 50,
                              ),
                              PieChartSectionData(
                                showTitle: false,
                                value: 20,
                                borderSide: const BorderSide(color: Colors.black, width: 1),
                                color: Colors.white,
                                radius: 50,
                              ),
                              PieChartSectionData(
                                showTitle: false,
                                value: 20,
                                borderSide: const BorderSide(color: Colors.black, width: 1),
                                color: Colors.green,
                                radius: 50,
                              ),
                              PieChartSectionData(
                                showTitle: false,
                                value: 20,
                                borderSide: const BorderSide(color: Colors.black, width: 1),
                                color: Colors.green,
                                radius: 50,
                              ),
                              PieChartSectionData(
                                showTitle: false,
                                value: 20,
                                color: isPaid ? Colors.green : Colors.red,
                                borderSide: const BorderSide(color: Colors.black, width: 1),
                                radius: 50,
                              ),
                            ],
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
                            LegendItem(color: Colors.green, text: '10/04/2025'),
                            LegendItem(color: Colors.green, text: '10/05/2025'),
                            LegendItem(color: isPaid ? Colors.green : Colors.red, text: '10/06/2025'),
                            LegendItem(color: Colors.white, text: '10/07/2025'),
                            LegendItem(color: Colors.white, text: '10/08/2025'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Text('Months Paid: ${isPaid ? 3 : 2} of 5',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
                const SizedBox(height: 10),
                const Text('Remaining Balance: \$1000',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
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
                  rows: [
                    const DataRow(
                      cells: [
                        DataCell(Text('10/04/2025')),
                        DataCell(Text('\$ 170')),
                        DataCell(Text('Paid')),
                      ],
                    ),
                    const DataRow(
                      cells: [
                        DataCell(Text('10/05/2025')),
                        DataCell(Text('\$ 170')),
                        DataCell(Text('Paid')),
                      ],
                    ),
                    DataRow(
                      cells: [
                        const DataCell(Text('10/06/2025')),
                        const DataCell(Text('\$ 170')),
                        DataCell(
                          Text(
                            isPaid ? 'Paid' : 'Overdue',
                            style: TextStyle(color: isPaid ? Colors.green : Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color(0xFF007FFF),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        isPaid = true;
                      });
                    },
                    child: const Text('Pay Right Now',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ),
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
