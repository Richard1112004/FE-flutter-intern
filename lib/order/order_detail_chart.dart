import 'package:begining/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';

class OrderDetailChart extends StatelessWidget {
  const OrderDetailChart({super.key});
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order #92287158'),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: userProvider.isLoggedIn
                        ? NetworkImage(userProvider.user!.photoUrl!)
                        : AssetImage('assets/profile/user.png') as ImageProvider,
                    backgroundColor: Colors.white,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Chart order',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.bar_chart_sharp, color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderDetailChart(),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.blueAccent,
                      ),
                      shape: MaterialStateProperty.all<CircleBorder>(
                        CircleBorder(),
                      ),
                      padding: MaterialStateProperty.all(EdgeInsets.all(4)),
                      minimumSize: MaterialStateProperty.all(
                        Size(24, 24),
                      ), // Kích thước tối thiểu
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.fire_truck, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.blueAccent,
                      ),
                      shape: MaterialStateProperty.all<CircleBorder>(
                        CircleBorder(),
                      ),
                      padding: MaterialStateProperty.all(EdgeInsets.all(4)),
                      minimumSize: MaterialStateProperty.all(
                        Size(24, 24),
                      ), // Kích thước tối thiểu
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Add your order details here
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
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                              value: 20,
                              color: Colors.white,
                              radius: 50,
                            ),
                            PieChartSectionData(
                              showTitle: false,
                              value: 20,
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                              color: Colors.white,
                              radius: 50,
                            ),
                            PieChartSectionData(
                              showTitle: false,
                              value: 20,
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                              color: Colors.green,
                              radius: 50,
                            ),
                            PieChartSectionData(
                              showTitle: false,
                              value: 20,
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                              color: Colors.green,
                              radius: 50,
                            ),
                            PieChartSectionData(
                              showTitle: false,
                              value: 20,
                              color: Colors.red,
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                              radius: 50,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 15,
                                height: 15,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                              SizedBox(width: 5),
                              Text(
                                '10/04/2025',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 15,
                                height: 15,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                              SizedBox(width: 5),
                              Text(
                                '10/04/2025',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 15,
                                height: 15,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              SizedBox(width: 5),
                              Text(
                                '10/04/2025',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 15,
                                height: 15,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width: 5),
                              Text(
                                '10/04/2025',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 15,
                                height: 15,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width: 5),
                              Text(
                                '10/04/2025',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Months Paid: 2 of 5',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 10),
              Text(
                'Remaining Balance: \$1000',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 20),
              DataTable(
                dataRowColor: MaterialStateProperty.all(Colors.white),
                dataRowHeight: 40,
                headingRowHeight: 40,
                headingRowColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 164, 188, 244),
                ),
                columns: [
                  DataColumn(label: Text('Due Date')),
                  DataColumn(label: Text('Amount')),
                  DataColumn(label: Text('Status')),
                ],
                rows: [
                  DataRow(
                    cells: [
                      DataCell(Text(('10/04/2025'))),
                      DataCell(Text('\$ 170')),
                      DataCell(Text('Paid')),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Text(('10/05/2025'))),
                      DataCell(Text('\$ 170')),
                      DataCell(Text('Paid')),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Text(('10/06/2025'))),
                      DataCell(Text('\$ 170')),
                      DataCell(Text('Overdue', style: TextStyle(color: Colors.red))),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
