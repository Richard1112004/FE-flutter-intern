import 'package:begining/screen/navigation.dart';
import 'package:flutter/material.dart';
import 'package:select_dialog/select_dialog.dart';

class ViewCart extends StatelessWidget {
  const ViewCart({super.key});
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
    return Scaffold(
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
                    '2',
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
                          '123 Main St, Springfield, USA',
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
                              // Handle edit address action
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
                      Row(
                        children: [
                          Image(
                            image: AssetImage('assets/products/iphone_16.png'),
                            // width: 200,
                            // height: 200,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.025,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'iPhone 16 Pro Max',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Nunito Sans',
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width *
                                        0.05,
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Color(0xFFD97474),
                                    ),
                                    onPressed: () {
                                      // Handle delete item action
                                    },
                                  ),
                                ],
                              ),

                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.0025,
                              ),
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
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                                Row(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                      children: [
                                                        Text(item["price"],
                                                            style: TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 14,
                                                              fontWeight: FontWeight
                                                                  .w700,
                                                                  fontFamily: 'Raleway',
                                                            )),
                                                        Text(
                                                          item["type"],
                                                          style: TextStyle(
                                                            color: Colors.black
                                                                .withOpacity(0.6),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Spacer(),
                                                    TextButton(
                                                      style: ButtonStyle(
                                                        backgroundColor:
                                                            WidgetStatePropertyAll(
                                                          Color(0xFF004BFE),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text(
                                                        "Select",
                                                        style: TextStyle(
                                                          color: Colors.white,
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
                                      print(
                                        "Selected plan: ${selectedPlan["duration"]}",
                                      );
                                    },
                                  ),
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
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                  ),
                                  // minimumSize: WidgetStatePropertyAll(
                                  //   const Size(double.infinity, 50),
                                  // ),
                                ),
                                child: Text(
                                  '6 months',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.005,
                              ),
                              Row(
                                children: [
                                  Text(
                                    '\$1,199.00',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontFamily: 'Raleway',
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width *
                                        0.075,
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.remove_circle_outline,
                                          color: Color(0xFF004BFE),
                                        ),
                                        onPressed: () {
                                          // Handle decrease quantity
                                        },
                                      ),
                                      Text('1', style: TextStyle(fontSize: 16)),
                                      IconButton(
                                        icon: Icon(
                                          Icons.add_circle_outline,
                                          color: Color(0xFF004BFE),
                                        ),
                                        onPressed: () {
                                          // Handle increase quantity
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Image(
                            image: AssetImage('assets/products/iphone_15.png'),
                            // width: 200,
                            // height: 200,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.025,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'iPhone 15 Pro Max',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Nunito Sans',
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width *
                                        0.05,
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Color(0xFFD97474),
                                    ),
                                    onPressed: () {
                                      // Handle delete item action
                                    },
                                  ),
                                ],
                              ),

                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.0025,
                              ),
                              TextButton(
                                onPressed: () => {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         const ForgotpasswordselectScreen(),
                                  //   ),
                                  // ),
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
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                  ),
                                  // minimumSize: WidgetStatePropertyAll(
                                  //   const Size(double.infinity, 50),
                                  // ),
                                ),
                                child: Text(
                                  '6 months',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.0025,
                              ),
                              Row(
                                children: [
                                  Text(
                                    '\$1,000.00',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontFamily: 'Raleway',
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width *
                                        0.075,
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.remove_circle_outline,
                                          color: Color(0xFF004BFE),
                                        ),
                                        onPressed: () {
                                          // Handle decrease quantity
                                        },
                                      ),
                                      Text('1', style: TextStyle(fontSize: 16)),
                                      IconButton(
                                        icon: Icon(
                                          Icons.add_circle_outline,
                                          color: Color(0xFF004BFE),
                                        ),
                                        onPressed: () {
                                          // Handle increase quantity
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                            ],
                          ),
                        ],
                      ),
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
                            // Handle checkout action
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
    );
  }
}
