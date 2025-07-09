import 'package:begining/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:begining/provider/password_provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final passwordProvider = Provider.of<PasswordProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset('assets/login/bubble_02.png', height: 170),
                  SizedBox(width: 119),
                  Image.asset('assets/login/bubble_01.png', height: 170),
                ],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 50),
              Center(
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      TextField(
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.all(
                              Radius.circular(40.0),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF007FFF)),
                            borderRadius: BorderRadius.all(
                              Radius.circular(40.0),
                            ),
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
                      SizedBox(height: 20),
                      TextField(
                        obscureText: !passwordProvider.currentIndex,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.all(
                              Radius.circular(40.0),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF007FFF)),
                            borderRadius: BorderRadius.all(
                              Radius.circular(40.0),
                            ),
                          ),
                          focusColor: Color(0xFF007FFF),
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            color: Color.fromARGB(255, 210, 210, 210),
                          ),
                          filled: true,
                          fillColor: Color.fromARGB(255, 248, 248, 248),
                          suffixIcon: IconButton(
                            icon: Icon(
                              passwordProvider.currentIndex
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              weight: 5,
                              size: 20,
                            ),
                            onPressed: () {
                              passwordProvider.setIndex(
                                !passwordProvider.currentIndex,
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        obscureText: false,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.all(
                              Radius.circular(40.0),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF007FFF)),
                            borderRadius: BorderRadius.all(
                              Radius.circular(40.0),
                            ),
                          ),
                          focusColor: Color(0xFF007FFF),
                          labelText: 'Phone Number',
                          labelStyle: TextStyle(
                            color: Color.fromARGB(255, 210, 210, 210),
                          ),
                          filled: true,
                          fillColor: Color.fromARGB(255, 248, 248, 248),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextButton(
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          ),
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Color.fromARGB(255, 0, 76, 255)),
                          foregroundColor: WidgetStatePropertyAll(
                            Colors.white,
                          ),
                          shadowColor: WidgetStateProperty.all(
                            Colors.black.withOpacity(0.5),
                          ),
                          elevation: WidgetStateProperty.resolveWith<double>((
                            states,
                          ) {
                            return states.contains(WidgetState.pressed)
                                ? 0.0
                                : 2.0; // Nhấn thì bóng biến mất
                          }),
                          minimumSize: MaterialStatePropertyAll<Size>(
                            const Size(double.infinity, 50),
                          ),
                        ),
                        child: Text('Done', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),
                      ),
                      TextButton(
                        onPressed: () => {
                          Navigator.pop(context),
                        },
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
                        child: Text('Cancel', style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                      ),
                    ],
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
