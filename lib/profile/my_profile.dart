import 'package:begining/api/auth/in_out_with_gg.dart';
import 'package:begining/cart/view_cart.dart';
import 'package:begining/model/order.dart';
import 'package:begining/model/user.dart';
import 'package:begining/order/orders.dart';
import 'package:begining/profile/edit_my_profile.dart';
import 'package:begining/profile/shipping_address.dart';
import 'package:begining/provider/navigation_provider.dart';
import 'package:begining/provider/user_provider.dart';
import 'package:begining/screen/login_screen.dart';
import 'package:begining/screen/navigation.dart';
import 'package:begining/screen/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Set the current index to the profile section
      Provider.of<NavigationProvider>(
        context,
        listen: false,
      ).setCurrentIndex(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        // Prevent the back button from navigating away
        return false; // Allow the pop action
      },
      child: Scaffold(
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
                        MaterialPageRoute(
                          builder: (context) => const EditMyProfile(),
                        ),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Orders()),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ViewCart(),
                        ),
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
                        MaterialPageRoute(
                          builder: (context) => const ShippingAddress(),
                        ),
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
                    onPressed: () async {
                      // Hiển thị popup xác nhận logout
                      bool? shouldLogout = await showDialog<bool>(
                        context: context,
                        barrierDismissible:
                            false, // Không cho phép đóng bằng cách tap ngoài
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            title: Row(
                              children: [
                                Icon(Icons.logout, color: Colors.red, size: 24),
                                SizedBox(width: 10),
                                Text(
                                  'Logout',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            content: Text(
                              'Are you sure you want to log out of this account?',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[700],
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(
                                    context,
                                  ).pop(false); // Trả về false (Cancel)
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.grey[600],
                                ),
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(
                                    context,
                                  ).pop(true); // Trả về true (Logout)
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  'Logout',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );

                      // Nếu user chọn logout (shouldLogout == true)
                      if (shouldLogout == true) {
                        // Hiển thị loading dialog trong quá trình logout
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return Dialog(
                              backgroundColor: Colors.transparent,
                              child: Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.red,
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      'Logging out...',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );

                        try {
                          if (userProvider.isLoggedIn) {
                            // If user is logged in, sign out
                            await AuthService.signOut(context);
                          }

                          // Đóng loading dialog
                          Navigator.of(context).pop();

                          // User.clearAllUsers();

                          // Hiển thị thông báo thành công
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                children: [
                                  Icon(Icons.check_circle, color: Colors.white),
                                  SizedBox(width: 10),
                                  Text('Successfully logged out'),
                                ],
                              ),
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 2),
                            ),
                          );

                          // Chuyển về màn hình start
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const StartScreen(),
                            ),
                            (Route<dynamic> route) =>
                                false, // Xóa tất cả các route trước đó
                          );
                        } catch (e) {
                          // Đóng loading dialog nếu có lỗi
                          Navigator.of(context).pop();

                          // Hiển thị thông báo lỗi
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                children: [
                                  Icon(Icons.error, color: Colors.white),
                                  SizedBox(width: 10),
                                  Text('Logout failed. Please try again.'),
                                ],
                              ),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 3),
                            ),
                          );

                          print('Logout error: $e');
                        }
                      }
                      // Nếu user chọn Cancel (shouldLogout == false hoặc null), không làm gì cả
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
                Text(
                  'Richard Shop',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text('Version 1.0.0', style: TextStyle(fontSize: 13)),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Navigation(),
      ),
    );
  }
}
