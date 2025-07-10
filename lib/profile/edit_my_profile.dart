import 'package:begining/provider/password_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditMyProfile extends StatelessWidget {
  const EditMyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final passwordProvider = Provider.of<PasswordProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Your Profile'),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Settings',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('Your profile', style: TextStyle(fontSize: 16)),
              SizedBox(height: 20),
              // Add your form fields here
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/profile/user.png'),
                      backgroundColor: Colors.white,
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        icon: Icon(Icons.edit, color: Colors.white, size: 20),
                        onPressed: () {
                          // Add your image picker logic here
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.blueAccent,
                          ),
                          shape: MaterialStateProperty.all<CircleBorder>(
                            CircleBorder(),
                          ),
                          padding: MaterialStateProperty.all(EdgeInsets.all(4)),
                          minimumSize: MaterialStateProperty.all(
                            Size(24, 24),
                          ), // Kích thước tối thiểu
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              TextField(
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
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
                  labelText: 'Name',
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 210, 210, 210),
                  ),
                  filled: true,
                  fillColor: Color.fromARGB(255, 248, 248, 248),
                ),
              ),
              SizedBox(height: 20),
              TextField(
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
              SizedBox(height: 20),
              TextField(
                obscureText: false,
                keyboardType: TextInputType.phone,
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
                onPressed: () {
                  // Add your save logic here
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Profile updated successfully!')),
                  );
                },
                child: Text('Save Changes'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color(0xFF004CFF),
                  ),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                  ),
                  minimumSize: MaterialStateProperty.all<Size>(
                    Size(double.infinity, 50), // Full width button
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
