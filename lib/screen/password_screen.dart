import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:begining/provider/password_provider.dart';
import 'package:begining/screen/home_screen.dart';

class PasswordScreen extends StatelessWidget {
  const PasswordScreen({super.key});
  SizedBox cell(BuildContext context, PasswordProvider passwordProvider) {
    return SizedBox(
      height: 20,
      width: 20,
      child: TextField(
        obscureText: !passwordProvider.currentIndex,
        onChanged: (value) {
          FocusScope.of(context).nextFocus(); // Handle input change if needed
        },
        style: Theme.of(context).textTheme.titleLarge,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(1),
        ],
        decoration: InputDecoration(
          // Tùy chỉnh màu của gạch dưới khi không focus
          enabledBorder: UnderlineInputBorder(
             borderSide: BorderSide(color: Color.fromARGB(255, 0, 76, 255), width: 2.0),
          ),
          // Tùy chỉnh màu của gạch dưới khi focus
        ),
      ),
      
    );
  }

  @override
  Widget build(BuildContext context) {
    final passwordProvider = Provider.of<PasswordProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset('assets/bubble_03.png', height: 170),
                  SizedBox(width: 121),
                  Image.asset('assets/bubblle_04.png', height: 170),
                ],
              ),
              SizedBox(height: 50),
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.pink,
                child: Icon(Icons.person, size: 50, color: Colors.white),
              ),
              SizedBox(height: 20),
              Text(
                'Hello, Phuc Hung!!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Type you password',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w200,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Form(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      cell(context, passwordProvider),
                      SizedBox(width: 15),
                      cell(context, passwordProvider),
                      SizedBox(width: 15),
                      cell(context, passwordProvider),
                      SizedBox(width: 15),
                      cell(context, passwordProvider),
                      SizedBox(width: 15),
                      cell(context, passwordProvider),
                      SizedBox(width: 15),
                      cell(context, passwordProvider),
                      SizedBox(width: 15),
                      cell(context, passwordProvider),
                      SizedBox(width: 15),
                      cell(context, passwordProvider),
                      SizedBox(width: 15),
                      IconButton(
                        onPressed: () => {
                          passwordProvider.setIndex(
                            !passwordProvider.currentIndex,
                          ),
                        },
                        icon: Icon(
                          passwordProvider.currentIndex
                              ? Icons.visibility
                              : Icons.visibility_off,
                          size: 20,
                          weight: 10,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  ),
                },
                icon: const Icon(
                  Icons.arrow_circle_right_rounded,
                  size: 30,
                  color: Color.fromARGB(255, 0, 76, 255),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
