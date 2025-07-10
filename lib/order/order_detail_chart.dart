import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
class OrderDetailChart extends StatelessWidget {
  const OrderDetailChart({super.key});
  @override
  Widget build(BuildContext context) {
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
                    backgroundImage: AssetImage('assets/profile/user.png'),
                    backgroundColor: Colors.white,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Track you order',
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
                            builder: (context) =>
                                OrderDetailChart(),
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
                          Text(
                            'Order Status',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Text('Processing', style: TextStyle(fontSize: 14)),
                          SizedBox(height: 10),
                          Text('Estimated Delivery', style: TextStyle(fontSize: 14)),
                          SizedBox(height: 10),
                          Text('In Transit', style: TextStyle(fontSize: 14)),
                          SizedBox(height: 10),
                          Text('Delivered', style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}