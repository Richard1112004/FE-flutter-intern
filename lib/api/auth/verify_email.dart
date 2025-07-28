// File: lib/screens/verify_email_screen.dart
import 'dart:async';

import 'package:begining/api/auth/login_API.dart';
import 'package:begining/api/auth/register_API.dart';
import 'package:begining/model/user.dart';
import 'package:begining/provider/user_provider.dart';
import 'package:begining/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:provider/provider.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  bool isEmailVerified = false;
  Timer? timer;
  bool isloading = false;
  final register = RegisterAPI();
  final login = LoginAPI();

  @override
  void initState() {
    super.initState();
    checkEmailVerified();
    timer = Timer.periodic(
      const Duration(seconds: 3),
      (_) => checkEmailVerified(),
    );
  }

  

  Future<void> checkEmailVerified() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await firebase.FirebaseAuth.instance.currentUser?.reload();
    final user = firebase.FirebaseAuth.instance.currentUser;
    final verified = user?.emailVerified ?? false;
    if (verified) {
      timer?.cancel();
      final user = User.createUser(
        userProvider.email,
        userProvider.password,
        userProvider.phone,
      );
      setState(() {
        isloading = true;
      });
      final success1 = await register.saveUserToBackend(user);
      final success2 = await login.loginUser(user.email, user.password);
      setState(() {
        isloading = false;
      });
      if (success1 && success2) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomeScreen()),
        );
      } else {
        // Hiển thị cảnh báo nếu đăng ký backend thất bại
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Can not register user on system'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isloading
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color.fromARGB(255, 0, 76, 255),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Saving user data, please wait...',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/login/bubble_03.png', height: 170),
                      SizedBox(width: 148),
                      Image.asset('assets/login/bubble_01.png', height: 170),
                    ],
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Please verify your email address',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Color.fromARGB(255, 0, 76, 255),
                        ),
                        foregroundColor: WidgetStatePropertyAll(Colors.white),
                        shadowColor: WidgetStatePropertyAll(
                          Colors.black.withOpacity(0.5),
                        ),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        minimumSize: WidgetStatePropertyAll(
                          const Size(double.infinity, 50),
                        ),
                      ),
                      child: Text(
                        'Resend Verification Email',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      onPressed: () {
                        // Gửi lại email xác thực
                        firebase.FirebaseAuth.instance.currentUser
                            ?.sendEmailVerification();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Re-verification email sent'),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
