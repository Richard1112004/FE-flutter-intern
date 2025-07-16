import 'package:begining/api/auth/sign_up.dart';
import 'package:begining/model/CartItem.dart';
import 'package:begining/model/order.dart';
import 'package:begining/model/user.dart';
import 'package:begining/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:begining/provider/password_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        await SignUp().signUp(context, emailController.text, passwordController.text);
        User.createUser(
          emailController.text,
          passwordController.text,
          phoneController.text,
        );
        print(User.getMockUsers());
        print(CartItem.iPhone_15);
        print(CartItem.iPhone_16);
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(content: Text('Account created successfully!')),
        // );
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => const HomeScreen()),
        // );
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final passwordProvider = Provider.of<PasswordProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                        TextFormField(
                          controller: emailController,
                          obscureText: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(
                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                            ).hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
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
                        TextFormField(
                          controller: passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
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
                        TextFormField(
                          controller: phoneController,
                          obscureText: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            // Thêm validation cho số điện thoại nếu cần
                            return null;
                          },
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
                          onPressed: () async => {await _submitForm()},
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              Color.fromARGB(255, 0, 76, 255),
                            ),
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
                          child: Text(
                            'Done',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () => {Navigator.pop(context)},
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              Colors.white,
                            ),
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
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
