import 'package:begining/model/CartItem.dart';
import 'package:begining/model/product.dart';
import 'package:begining/model/user.dart';
import 'package:begining/order/orders.dart';
import 'package:begining/profile/shipping_address.dart';
import 'package:begining/provider/cart_provider.dart';
import 'package:begining/provider/navigation_provider.dart';
import 'package:begining/screen/navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:select_dialog/select_dialog.dart';

class ViewCart extends StatefulWidget {
  const ViewCart({super.key});

  @override
  State<ViewCart> createState() => _ViewCartState();
}

class _ViewCartState extends State<ViewCart> {
  User user = User.getMockUser();
  final plans = [
    {
      "duration": "6 months",
      "price": "\$230 per month",
      "type": "0% installment plan",
    },
    {
      "duration": "9 months",
      "price": "\$155 per month",
      "type": "0% installment plan",
    },
    {
      "duration": "12 months",
      "price": "\$117 per month",
      "type": "0% installment plan",
    },
  ];
  @override
  void initState() {
    super.initState();
    try {
      user = User.getMockUser();
    } catch (e) {
      print('Error loading user: $e');
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Set the current index to the cart screen
      Provider.of<NavigationProvider>(
        context,
        listen: false,
      ).setCurrentIndex(1);
    });
  }

  Widget cartItem(CartItem cartItem, BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Row(
      children: [
        Image(
          image: AssetImage(
            Product.getMockProductById(cartItem.product_id)!.image,
          ),
          width: 120,
          height: 120,
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.025),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      Product.getMockProductById(cartItem.product_id)!.name,
                      style: TextStyle(fontSize: 15, fontFamily: 'Nunito Sans'),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Color(0xFFD97474)),
                    onPressed: () {
                      cartProvider.removeCartItem(cartItem.product_id);
                    },
                  ),
                ],
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.0025),
              TextButton(
                onPressed: () => {
                  SelectDialog.showModal<Map<String, dynamic>>(
                    context,
                    label: "Installment options",
                    items: plans,
                    itemBuilder: (context, item, _) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xFF004BFE),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Text(
                                  item["duration"],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF004BFE),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item["price"],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Raleway',
                                      ),
                                    ),
                                    Text(
                                      item["type"],
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(
                                          0.6,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    onChange: (selectedPlan) {
                      String durationString = selectedPlan["duration"];
                      cartItem.term = double.parse(
                        durationString.split(' ')[0],
                      ); // Extract "6" and convert to 6.0
                      cartProvider.setSelectionPlan(selectedPlan["duration"]);
                    },
                  ),
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Color(0xFF004BFE)),
                  foregroundColor: WidgetStatePropertyAll(Colors.white),
                  shadowColor: WidgetStatePropertyAll(
                    Colors.black.withOpacity(0.5),
                  ),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  // minimumSize: WidgetStatePropertyAll(
                  //   const Size(double.infinity, 50),
                  // ),
                ),
                child: Text(
                  cartItem.term == 0 ? 'Choose' : cartItem.term.toInt().toString() + ' months',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.005),
              Row(
                children: [
                  Text(
                    '\$${Product.getMockProductById(cartItem.product_id)!.price.toString()}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontFamily: 'Raleway',
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.075),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.remove_circle_outline,
                          color: Color(0xFF004BFE),
                        ),
                        onPressed: () {
                          // Handle decrease quantity
                          cartProvider.decreaseCartItemQuantity(
                            cartItem.product_id,
                          );
                        },
                      ),
                      Text(
                        cartItem.quantity.toString(),
                        style: TextStyle(fontSize: 16),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.add_circle_outline,
                          color: Color(0xFF004BFE),
                        ),
                        onPressed: () {
                          // Handle increase quantity
                          cartProvider.increaseCartItemQuantity(
                            cartItem.product_id,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final plans = [
      {
        "duration": "6 months",
        "price": "\$230 per month",
        "type": "0% installment plan",
      },
      {
        "duration": "9 months",
        "price": "\$155 per month",
        "type": "0% installment plan",
      },
      {
        "duration": "12 months",
        "price": "\$117 per month",
        "type": "0% installment plan",
      },
    ];
    return WillPopScope(
      onWillPop: () async {
        return false; // Allow the pop action
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Cart',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nunito Sans',
                      ),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                  CircleAvatar(
                    radius: 15, // Bán kính
                    backgroundColor: Color.fromARGB(
                      255,
                      154,
                      169,
                      184,
                    ), // Màu nền
                    child: Text(
                      CartItem.cartItems.length.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.025),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xFFF9F9F9),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Shipping Address',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Nunito Sans',
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            (user.province.isNotEmpty && user.street.isNotEmpty)
                                ? '${user.province}, ${user.street}'
                                : 'Province/City, District, Ward, Street',
                            // 'asdasda',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Nunito Sans',
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Spacer(),
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: Color(0xFF004BFE),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(Icons.edit, color: Colors.white),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ShippingAddress(), // Replace with your address editing screen
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Add cart items here
              // For example, you can use a ListView to display items in the cart
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        cartItem(CartItem.iPhone_15, context),
                        cartItem(CartItem.iPhone_16, context),
                        for (int i = 2; i < CartItem.cartItems.length; i++)
                          cartItem(CartItem.cartItems[i], context),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xFFF9F9F9),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Total \$2,199.00',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Raleway',
                              ),
                            ),
                          ),
                          Spacer(),
                          TextButton(
                            onPressed: () {
                              print(User.getMockUsers());
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Orders(),
                                ),
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                Color(0xFF004BFE),
                              ),
                              foregroundColor: WidgetStatePropertyAll(
                                Colors.white,
                              ),
                              shadowColor: WidgetStatePropertyAll(
                                Colors.black.withOpacity(0.5),
                              ),
                              shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              minimumSize: WidgetStatePropertyAll(
                                const Size(120, 40),
                              ),
                            ),
                            child: Text(
                              'Checkout',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Navigation(),
      ),
    );
  }
}
