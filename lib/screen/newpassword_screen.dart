import 'package:begining/screen/home_screen.dart';
import 'package:flutter/material.dart';

class NewpasswordScreen extends StatelessWidget {
  const NewpasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Image.asset('assets/bubble_03.png', height: 170),
                  SizedBox(width: 148),
                  Image.asset('assets/bubble_01.png', height: 170),
                ],
              ),
              SizedBox(height: 30),
              Text(
                'New Password',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF007FFF)),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    focusColor: Color(0xFF007FFF),
                    labelText: 'New Password',
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 210, 210, 210),
                    ),
                    filled: true,
                    fillColor: Color.fromARGB(255, 248, 248, 248),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF007FFF)),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    focusColor: Color(0xFF007FFF),
                    labelText: 'Repeat Password',
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 210, 210, 210),
                    ),
                    filled: true,
                    fillColor: Color.fromARGB(255, 248, 248, 248),
                  ),
                ),
              ),
              SizedBox(height: 120),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextButton(
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                    ),
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      Color.fromARGB(255, 0, 76, 255),
                    ),
                    foregroundColor: WidgetStatePropertyAll(Colors.white),
                    shadowColor: WidgetStateProperty.all(
                      Colors.black.withOpacity(0.5),
                    ),
                    elevation: WidgetStateProperty.resolveWith<double>((states) {
                      return states.contains(WidgetState.pressed)
                          ? 0.0
                          : 2.0; // Nhấn thì bóng biến mất
                    }),
                    minimumSize: MaterialStatePropertyAll<Size>(
                      const Size(double.infinity, 50),
                    ),
                  ),
                  child: Text(
                    'Done',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextButton(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
