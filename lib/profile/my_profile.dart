import 'package:begining/profile/edit_my_profile.dart';
import 'package:begining/profile/shipping_address.dart';
import 'package:begining/screen/navigation.dart';
import 'package:flutter/material.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Text(
                'Settings',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Personal',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 0.5, color: Colors.grey),
                  ),
                ),
                child: TextButton(
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const EditMyProfile()),
                    ),
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.white),
                    foregroundColor: WidgetStatePropertyAll(Colors.black),
                    shadowColor: WidgetStatePropertyAll(
                      Colors.black.withOpacity(0.5),
                    ),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                        side: BorderSide(color: Colors.transparent, width: 1),
                      ),
                    ),
                    minimumSize: WidgetStatePropertyAll(
                      const Size(double.infinity, 50),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Profile',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, color: Colors.black),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 0.5, color: Colors.grey),
                  ),
                ),
                child: TextButton(
                  onPressed: () => {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => const HomeScreen()),
                    // ),
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.white),
                    foregroundColor: WidgetStatePropertyAll(Colors.black),
                    shadowColor: WidgetStatePropertyAll(
                      Colors.black.withOpacity(0.5),
                    ),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                        side: BorderSide(color: Colors.transparent, width: 1),
                      ),
                    ),
                    minimumSize: WidgetStatePropertyAll(
                      const Size(double.infinity, 50),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Your Orders',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, color: Colors.black),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 0.5, color: Colors.grey),
                  ),
                ),
                child: TextButton(
                  onPressed: () => {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => const HomeScreen()),
                    // ),
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.white),
                    foregroundColor: WidgetStatePropertyAll(Colors.black),
                    shadowColor: WidgetStatePropertyAll(
                      Colors.black.withOpacity(0.5),
                    ),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                        side: BorderSide(color: Colors.transparent, width: 1),
                      ),
                    ),
                    minimumSize: WidgetStatePropertyAll(
                      const Size(double.infinity, 50),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Your Cart',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, color: Colors.black),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 0.5, color: Colors.grey),
                  ),
                ),
                child: TextButton(
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ShippingAddress()),
                    ),
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.white),
                    foregroundColor: WidgetStatePropertyAll(Colors.black),
                    shadowColor: WidgetStatePropertyAll(
                      Colors.black.withOpacity(0.5),
                    ),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                        side: BorderSide(color: Colors.transparent, width: 1),
                      ),
                    ),
                    minimumSize: WidgetStatePropertyAll(
                      const Size(double.infinity, 50),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Shipping Address',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, color: Colors.black),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'Personal',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 0.5, color: Colors.grey),
                  ),
                ),
                child: TextButton(
                  onPressed: () => {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => const HomeScreen()),
                    // ),
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.white),
                    foregroundColor: WidgetStatePropertyAll(Colors.black),
                    shadowColor: WidgetStatePropertyAll(
                      Colors.black.withOpacity(0.5),
                    ),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                        side: BorderSide(color: Colors.transparent, width: 1),
                      ),
                    ),
                    minimumSize: WidgetStatePropertyAll(
                      const Size(double.infinity, 50),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, color: Colors.black),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text('Richard Shop', 
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Version 1.0.0',
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Navigation(),
    );
  }
}
