import 'package:begining/order/order_detail_chart.dart';
import 'package:begining/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderDetailTrack extends StatelessWidget {
  const OrderDetailTrack({super.key, required this.productName});
  final String productName;

  Widget _buildTimelineItem({
    required String description,
    required bool isCompleted,
    required String status,
    required String date,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        children: [
          SizedBox(
            width: 60,
            child: Column(
              children: [
                if (!isFirst)
                  Expanded(
                    child: Container(
                      color: isCompleted
                          ? Color(0xFF007FFF)
                          : const Color.fromARGB(255, 190, 43, 33),
                      width: 10,
                    ),
                  ),
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    color: isCompleted
                        ? Color(0xFF007FFF)
                        : const Color.fromARGB(255, 190, 43, 33),
                    shape: BoxShape.circle,
                  ),
                  child: isCompleted
                      ? Icon(Icons.check, color: Colors.white, size: 16)
                      : Icon(Icons.close, color: Colors.white, size: 16),
                ),
                // if (isFirst)
                //   Container(
                //     width: 10,
                //     height: 10,
                //     color: isCompleted
                //         ? Color(0xFF007FFF)
                //         : const Color.fromARGB(255, 190, 43, 33),
                //   ),
                if (!isLast)
                  Container(
                    width: 10,
                    height: 10,
                    color: isCompleted
                        ? Color(0xFF007FFF)
                        : const Color.fromARGB(255, 190, 43, 33),
                  ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  Text(
                    status,
                    style: TextStyle(
                      fontSize: 16,
                      color: isCompleted
                          ? Color(0xFF007FFF)
                          : const Color.fromARGB(255, 190, 43, 33),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(date, style: TextStyle(fontSize: 14)),
                  SizedBox(height: 4),
                  Text(description, style: TextStyle(fontSize: 14)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(productName),
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
                    'Track product',
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
                                OrderDetailChart(productName: productName),
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
                  SizedBox(width: 0),
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.fire_truck, color: Colors.white),
                    onPressed: () {
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
              _buildTimelineItem(
                date: '2023-10-01',
                status: 'Order Placed',
                description: 'Your order is started',
                isCompleted: false,
              ),
              _buildTimelineItem(
                date: '2023-10-02',
                status: 'Processing',
                description: 'Your order is being processed.',
                isCompleted: false,
              ),
              _buildTimelineItem(
                date: '2023-10-03',
                status: 'Shipped',
                description: 'Your order has been shipped.',
                isCompleted: true,
                isLast: true,
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
