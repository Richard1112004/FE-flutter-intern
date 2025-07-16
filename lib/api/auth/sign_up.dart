import 'package:begining/api/auth/verify_email.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp {
  Future<void> signUp(
    BuildContext context,
    String email,
    String password,
  ) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      
      try{
        await userCredential.user?.sendEmailVerification();
      }
      catch (e) {
        print(e);
      }
      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'A email verification link has been sent to your email. Please check your inbox.',
          ),
        ),
      );

      // Thêm dòng này để chuyển đến màn hình verify email
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => VerifyEmailScreen()),
      );
    } catch (e) {
      // Đóng dialog loading nếu có lỗi
      Navigator.of(context).pop();
      print(e);
    }
  }
}
