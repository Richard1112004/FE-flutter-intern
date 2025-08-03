import 'package:begining/api/cart/cart_API.dart';
import 'package:begining/model/CartItem.dart';
import 'package:begining/model/order.dart';
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
  late CartProvider cartProvider;
  final CartAPI cartAPI = CartAPI();
  Future<void> fetchCartItems() async {
    try {
      await cartAPI.getCartItems();
      setState(() {});
    } catch (e) {
      print('Error loading cart items: $e');
    }
  }

  List<Map<String, dynamic>> getPlansForProduct(CartItem cartItem) {
    Product product = Product.getMockProductById(cartItem.product_id)!;
    double price = product.price * cartItem.quantity;

    return [
      {
        "duration": "6 months",
        "price":
            '\$${((product.price - (product.price / 10)) / 6 + 5).toStringAsFixed(2)} per month',
        "type": "0% installment plan",
        "originalPrice": price,
        "months": 6,
      },
      {
        "duration": "9 months",
        "price":
            '\$${((product.price - (product.price / 10)) / 9 + 10).toStringAsFixed(2)} per month',
        "type": "0% installment plan",
        "originalPrice": price,
        "months": 9,
      },
      {
        "duration": "12 months",
        "price":
            '\$${((product.price - (product.price / 10)) / 12 + 15).toStringAsFixed(2)} per month',
        "type": "0% installment plan",
        "originalPrice": price,
        "months": 12,
      },
    ];
  }

  @override
  void initState() {
    super.initState();
    try {
      user = User.getMockUser();
      fetchCartItems();
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

  void _goToOrdersPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Orders()),
    );

    if (result == 'refresh') {
      setState(() {
        print('Cart has been refreshed after placing an order');
      });
    }
  }

  Widget cartItem(CartItem cartItem, BuildContext context) {
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
                    items: getPlansForProduct(cartItem),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                        color: Colors.black.withOpacity(0.6),
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
                  cartItem.term == 0
                      ? 'Choose'
                      : cartItem.term.toInt().toString() + ' months',
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
    cartProvider = Provider.of<CartProvider>(context);
    bool isCartEmpty = CartItem.cartItems.isEmpty;
    print(CartItem.cartItems);
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
                                final result = Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ShippingAddress(), // Replace with your address editing screen
                                  ),
                                );
                                result.then((value) {
                                  if (value == 'refresh') {
                                    setState(() {
                                      print('Shipping address updated');
                                    });
                                  }
                                });
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
                    child: CartItem.cartItems.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                ),
                                Text(
                                  'No products in cart',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Nunito Sans',
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Column(
                            children: [
                              for (
                                int i = 0;
                                i < CartItem.cartItems.length;
                                i++
                              ) ...[
                                Builder(
                                  builder: (context) {
                                    final item = CartItem.cartItems[i];
                                    print(
                                      "Cart Item #$i -> "
                                      "ID: ${item.id}, "
                                      "Product ID: ${item.product_id}, "
                                      "Quantity: ${item.quantity}, "
                                      "Term: ${item.term}, "
                                      "User ID: ${item.userId}, "
                                      "Order ID: ${item.orderId}",
                                    );
                                    return cartItem(item, context);
                                  },
                                ),
                              ],
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
                              'Total \$${CartItem.cartItems.fold(0.0, (total, item) => total + Product.getMockProductById(item.product_id)!.price * item.quantity).toStringAsFixed(2)}',
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
                              print(Order.orders);
                              if (!isCartEmpty) {
                                for (
                                  int i = 0;
                                  i < CartItem.cartItems.length;
                                  i++
                                ) {
                                  if (CartItem.cartItems[i].term == 0) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Please choose a plan for all products',
                                        ),
                                      ),
                                    );
                                    return;
                                  }
                                }
                                for (
                                  int i = 0;
                                  i < CartItem.cartItems.length;
                                  i++
                                ) {
                                  CartItem.cartItems[i].orderId =
                                      Order.orders.length + 1;
                                }
                                Order.createOrder(
                                  'order_${Order.orders.length + 1}',
                                  user.id,
                                  DateTime.now(),
                                  CartItem.cartItems
                                      .map(
                                        (item) => Product.getMockProductById(
                                          item.product_id,
                                        )!.image,
                                      )
                                      .toList(),
                                  CartItem.cartItems
                                      .map((item) => item.product_id)
                                      .toList(),
                                  CartItem.cartItems.fold(
                                    0.0,
                                    (total, item) =>
                                        total +
                                        Product.getMockProductById(
                                              item.product_id,
                                            )!.price *
                                            item.quantity,
                                  ),
                                  'pending',
                                );
                                CartItem.clearCartItems();
                                print(Order.orders);
                              }
                              _goToOrdersPage();
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
                            child: isCartEmpty
                                ? Text(
                                    'View Orders',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                : Text(
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
