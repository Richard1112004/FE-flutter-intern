import 'package:begining/model/CartItem.dart';
import 'package:begining/model/order.dart';
import 'package:begining/model/product.dart';
import 'package:begining/order/order_detail_track.dart';
import 'package:begining/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderDetail extends StatelessWidget {
  final Order? order;
  const OrderDetail({super.key, this.order});
  Widget orderProduct(
    Order? order,
    int index,
    String imagePath,
    String productName,
    double productPrice,
  ) {
    return Row(
      children: [
        Card(
          child: Image(image: AssetImage(imagePath), width: 120, height: 120),
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order ${order?.id ?? '#92287158'}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Raleway',
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Name: $productName',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 5),
            Text(
              'Price: \$${productPrice.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Raleway',
              ),
            ),
          ],
        ),
      ],
    );
  }

  List<Widget> _buildOrderProducts(BuildContext context) {
    // Luôn dùng dữ liệu thật
    final List<Product> products = CartItem.getMockCartItemsByOrderId(order!.id)
        .map((item) => Product.getMockProductById(item.product_id))
        .whereType<Product>() // bỏ null
        .toList();

    List<Widget> widgets = [];

    for (int i = 0; i < products.length; i++) {
      final productWidget = orderProduct(
        order,
        i,
        products[i].image,
        products[i].name,
        products[i].price,
      );

      // Nếu đơn hàng là SHIPPED thì bọc trong InkWell
      widgets.add(
        order?.status == "SHIPPED"
            ? InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        OrderDetailTrack(productName: products[i].name),
                  ),
                ),
                child: productWidget,
              )
            : productWidget,
      );

      if (i < products.length - 1) {
        widgets.add(SizedBox(height: 20));
      }
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Order ${order?.id ?? '#92287158'}'),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, 'refresh');
          },
        ),
      ),
      body: SingleChildScrollView(
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
                        : AssetImage('assets/profile/user.png')
                              as ImageProvider,
                    backgroundColor: Colors.white,
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Products',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ...(_buildOrderProducts(context)),
            ],
          ),
        ),
      ),
    );
  }
}
