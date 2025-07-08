import 'package:begining/screen/forgotpasswordselect_screen.dart';
import 'package:flutter/material.dart';

class ForgotpasswordScreen extends StatelessWidget {
  const ForgotpasswordScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset('assets/bubble_03.png', height: 170),
                  SizedBox(width: 148),
                  Image.asset('assets/bubble_01.png', height: 170),
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
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
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
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const ForgotpasswordselectScreen(),
                          ),
                        ),
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Color.fromARGB(255, 18, 17, 0),
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
