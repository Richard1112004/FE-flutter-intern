import 'package:begining/model/CartItem.dart';
import 'package:begining/model/order.dart';
import 'package:begining/model/product.dart';
import 'package:begining/order/order_detail_track.dart';
import 'package:begining/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Orders extends StatelessWidget {
  Widget orderCard(Order order, BuildContext context) {
    print(Order.orders);
    print(CartItem.cartItems);
    return Row(
      children: [
        Card(
          child: Image(
            image: AssetImage(
              order.image, // Assuming order.image is a valid asset path
            ),
            width: 120,
            height: 120,
          ),
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order ${order.id}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Raleway',
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Order Date: ${order.createdAt.toLocal().toString().split(' ')[0]}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 5),
            Text(
              'Order Status: ${order.status}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ],
    );
  }

  const Orders({super.key});
  @override
  Widget build(BuildContext context) {
    final orders = Order.getMockOrders();
    final userProvider = Provider.of<UserProvider>(context);
    print('=== ORDERS DEBUG ===');
    print('Total orders: ${orders.length}');

    if (orders.isNotEmpty) {
      print('First order ID: ${orders[0].id}');
      print('First order status: ${orders[0].status}');
      print('First order date: ${orders[0].createdAt}');
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, 'refresh');
          },
        ),
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
                    'History of Orders',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrderDetail()),
                ),
                child: Row(
                  children: [
                    Card(
                      child: Image(
                        image: AssetImage('assets/products/iphone_15.png'),
                        width: 120,
                        height: 120,
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order order_0',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Raleway',
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Order Date: 2025-07-14',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Order Status: shipping',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ...List.generate(
                Order.getMockOrders().length,
                (i) => Column(
                  children: [
                    SizedBox(height: 20),
                    orderCard(Order.getMockOrders()[i], context),
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
