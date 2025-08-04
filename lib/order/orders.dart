import 'package:begining/api/instalmentPlan/plan_API.dart';
import 'package:begining/api/order/order_API.dart';
import 'package:begining/model/CartItem.dart';
import 'package:begining/model/order.dart';
import 'package:begining/model/product.dart';
import 'package:begining/order/order_detail.dart';
import 'package:begining/order/order_detail_track.dart';
import 'package:begining/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  final OrderApi orderApi = OrderApi();
  final PlanApi planApi = PlanApi();
  Future<List<Order>> _fetchOrder() async {
    await orderApi.getAllOrders();
    return Order.getMockOrders();
  }

  late Future<List<Order>> _futureOrders;

  @override
  void initState() {
    super.initState();
    _futureOrders = _fetchOrder();
    planApi.getAllInstallmentPlans();
  }

  Widget orderCard(Order order, BuildContext context) {
    print("Order.orders: ${Order.orders}");
    print(CartItem.cartItems);
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OrderDetail(order: order)),
      ),
      child: Row(
        children: [
          Card(
            child: Image(
              image: AssetImage(
                Product.getMockProductById(
                  CartItem.getMockCartItemsByOrderId(order.id)[0].product_id,
                )!.image,
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final orders = Order.getMockOrders();

    final userProvider = Provider.of<UserProvider>(context);
    // print('=== ORDERS DEBUG ===');
    // print('Total orders: ${orders.length}');

    // if (orders.isNotEmpty) {
    //   print('First order ID: ${orders[0].id}');
    //   print('First order status: ${orders[0].status}');
    //   print('First order date: ${orders[0].createdAt}');
    // }
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
      body: SingleChildScrollView(
        child: Center(
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
                      backgroundImage: userProvider.isLoggedGoogle
                          ? NetworkImage(userProvider.user!.photoUrl!)
                          : AssetImage('assets/profile/user.png')
                                as ImageProvider,
                      backgroundColor: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'History of Orders',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                // InkWell(
                //   onTap: () => Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) => OrderDetail()),
                //   ),
                //   child: Row(
                //     children: [
                //       Card(
                //         child: Image(
                //           image: AssetImage('assets/products/iphone_15.png'),
                //           width: 120,
                //           height: 120,
                //         ),
                //       ),
                //       SizedBox(width: 10),
                //       Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Text(
                //             'Order order_0',
                //             style: TextStyle(
                //               fontSize: 18,
                //               fontWeight: FontWeight.bold,
                //               fontFamily: 'Raleway',
                //             ),
                //           ),
                //           SizedBox(height: 5),
                //           Text(
                //             'Order Date: 2025-07-14',
                //             style: TextStyle(
                //               fontSize: 18,
                //               fontWeight: FontWeight.w500,
                //             ),
                //           ),
                //           SizedBox(height: 5),
                //           Text(
                //             'Order Status: shipped',
                //             style: TextStyle(
                //               fontSize: 18,
                //               fontWeight: FontWeight.w500,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
                FutureBuilder<List<Order>>(
                  future: _futureOrders,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(color: Colors.blue),
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No orders available'));
                    } else {
                      final orders = snapshot.data!;
                      return Column(
                        children: List.generate(
                          orders.length,
                          (i) => Column(
                            children: [
                              orderCard(orders[i], context),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
