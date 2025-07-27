// File: lib/screens/verify_email_screen.dart
import 'dart:async';

import 'package:begining/provider/user_provider.dart';
import 'package:begining/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:begining/model/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  bool isEmailVerified = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    checkEmailVerified();
    timer = Timer.periodic(
      const Duration(seconds: 3),
      (_) => checkEmailVerified(),
    );
  }

  Future<void> saveUserToBackend(User firebaseUser) async {
    final url = Uri.parse(
      'https://1bcb1b01beee.ngrok-free.app/api/v1/user/register',
    );

    final requestBody = {
      'email': firebaseUser.email,
      'password': firebaseUser.password,
      'phone': firebaseUser.phone,
    };

    print('📤 [Request] Sending to $url');
    print('📤 [Request Body] $requestBody');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      print('📥 [Response Code] ${response.statusCode}');
      print('📥 [Raw Body] ${response.body}');

      if (response.statusCode == 200) {
        print('✅ User saved to backend successfully.');
      } else {
        try {
          final error = jsonDecode(response.body);
          print(
            '❌ [Server Error] ${error['message'] ?? 'Unknown error message'}',
          );
        } catch (e) {
          print('❌ [Decode Error] Response không phải JSON:');
          print(response.body);
        }
      }
    } catch (e) {
      print('❌ [Network Error] Không kết nối được đến server: $e');
      print(
        '👉 Gợi ý: Kiểm tra lại ngrok URL có đang chạy không? Có dùng đúng http/https không?',
      );
    }
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
      await saveUserToBackend(user);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );
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
        child: Column(
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                ),
                onPressed: () {
                  // Gửi lại email xác thực
                  firebase.FirebaseAuth.instance.currentUser
                      ?.sendEmailVerification();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Re-verification email sent')),
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
