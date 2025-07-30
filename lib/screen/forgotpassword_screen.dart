import 'package:begining/api/auth/forgot_API.dart';
import 'package:begining/model/user.dart';
import 'package:begining/provider/pincode_provider.dart';
import 'package:begining/screen/forgotpasswordselect_screen.dart';
import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ForgotpasswordScreen extends StatefulWidget {
  const ForgotpasswordScreen({super.key});
  @override
  State<ForgotpasswordScreen> createState() => _ForgotpasswordScreenState();
}

class _ForgotpasswordScreenState extends State<ForgotpasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final ForgotApi forgotApi = ForgotApi();
  Future<bool> sendOTP(String email, PinCodeProvider pinCodeProvider) async {
    final String SecondaryUrl = dotenv.env['SECONDARY_URL'] ?? '';
    EmailAuth emailAuth = EmailAuth(sessionName: "Password Recovery");
    pinCodeProvider.setEmailAuth(emailAuth);
    print('Sending OTP to: $email');
    pinCodeProvider.setEmail(email);
    final remote = {
      "server": SecondaryUrl,
      "serverKey": "RDhShW",
    };
    if (await emailAuth.config(remote)) {
      return await emailAuth.sendOtp(
        recipientMail: emailController.text,
        otpLength: 4,
      );
    } else {
      print('Failed to configure email auth');
      return false;
    }
  }


  @override
  Widget build(BuildContext context) {
    final PinCodeProvider pinCodeProvider = Provider.of<PinCodeProvider>(
      context,
      listen: true,
    );
    print('-----------------------------');
    print(pinCodeProvider.isValid);
    print('-----------------------------');
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset('assets/login/bubble_03.png', height: 170),
                  SizedBox(width: 148),
                  Image.asset('assets/login/bubble_01.png', height: 170),
                ],
              ),
              SizedBox(height: 70),
              Column(
                children: [
                  Text(
                    'Password Recovery',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Enter your email to recover your password',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  // Text(
                  //   'Invalid OTP. Please try again.',
                  //   style: TextStyle(fontSize: 16, color: Colors.red),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(40.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF007FFF)),
                          borderRadius: BorderRadius.all(Radius.circular(40.0)),
                        ),
                        focusColor: Color(0xFF007FFF),
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 210, 210, 210),
                        ),
                        filled: true,
                        fillColor: Color.fromARGB(255, 248, 248, 248),
                      ),
                    ),
                  ),
                  SizedBox(height: 110),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextButton(
                      onPressed: () async {
                        bool checkEmail = await forgotApi.checkUserExists(emailController.text);
                        if (!checkEmail) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Email not found')),
                          );
                          return;
                        }
                        final user = User.createUser(
                          emailController.text,
                          '', // Password is not needed for forgot password
                          '', // Phone is not needed for forgot password
                        );
                        showDialog(
                          context: context,
                          barrierDismissible:
                              false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Row(
                                children: [
                                  CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Color(0xFF007FFF),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Expanded(
                                    child: Text(
                                      'Sending OTP to your email...',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                        bool otpSent = await sendOTP(
                          emailController.text,
                          pinCodeProvider,
                        ); // <-- Gọi hàm có return bool

                        if (otpSent) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ForgotpasswordselectScreen(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '⚠️ Gửi OTP thất bại. Vui lòng thử lại.',
                              ),
                            ),
                          );
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Email sent to ${user.email}'),
                          ),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const ForgotpasswordselectScreen(),
                          ),
                        );
                      },
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
                        'Continue',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => {Navigator.pop(context)},
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.white),
                      foregroundColor: WidgetStatePropertyAll(
                        const Color.fromARGB(255, 255, 255, 255),
                      ),
                      shadowColor: WidgetStateProperty.all(
                        Colors.black.withOpacity(0.5),
                      ),
                      minimumSize: MaterialStatePropertyAll<Size>(
                        const Size(double.infinity, 50),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
