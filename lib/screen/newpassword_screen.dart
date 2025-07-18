import 'package:begining/model/user.dart';
import 'package:begining/provider/password_provider.dart';
import 'package:begining/provider/repeat_password_provider.dart';
import 'package:begining/screen/home_screen.dart';
import 'package:begining/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewpasswordScreen extends StatefulWidget {
  const NewpasswordScreen({super.key});

  @override
  State<NewpasswordScreen> createState() => _NewpasswordScreenState();
}

class _NewpasswordScreenState extends State<NewpasswordScreen> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController repeatPasswordController =
      TextEditingController();

  @override
  void dispose() {
    newPasswordController.dispose();
    repeatPasswordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final newPasswordProvider = Provider.of<PasswordProvider>(context);
    final repeatPasswordProvider = Provider.of<RepeatPasswordProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your new password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                  controller: newPasswordController,
                  obscureText: !newPasswordProvider.currentIndex,
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
                    suffixIcon: IconButton(
                      icon: Icon(
                        newPasswordProvider.currentIndex
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        weight: 5,
                        size: 20,
                      ),
                      onPressed: () {
                        newPasswordProvider.setIndex(
                          !newPasswordProvider.currentIndex,
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please repeat your new password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    if (value != newPasswordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  controller: repeatPasswordController,
                  obscureText: !repeatPasswordProvider.currentIndex,
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
                    suffixIcon: IconButton(
                      icon: Icon(
                        repeatPasswordProvider.currentIndex
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        weight: 5,
                        size: 20,
                      ),
                      onPressed: () {
                        repeatPasswordProvider.setIndex(
                          !repeatPasswordProvider.currentIndex,
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 120),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextButton(
                  onPressed: () {
                    if (newPasswordController.text.isEmpty ||
                        repeatPasswordController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please fill in all fields')),
                      );
                      return;
                    } else if (newPasswordController.text !=
                        repeatPasswordController.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Passwords do not match')),
                      );
                      return;
                    } else {
                      User? user = User.getUserByEmail(
                        User.getMockUser().email,
                      );
                      if (user == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('User not found')),
                        );
                        return;
                      }
                      user.password = newPasswordController.text;
                      print(User.getMockUser()); // For debugging purposes
                      // Handle password change logic here
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Password changed successfully'),
                        ),
                      );
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      Color.fromARGB(255, 0, 76, 255),
                    ),
                    foregroundColor: WidgetStatePropertyAll(Colors.white),
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
