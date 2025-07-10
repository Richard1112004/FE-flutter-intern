import 'package:flutter/material.dart';

class ShippingAddress extends StatelessWidget {
  const ShippingAddress({super.key});

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shipping Address'),
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
              Text('Shipping Address', style: TextStyle(fontSize: 16)),
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
                  focusColor: Color.fromARGB(255, 93, 100, 107),
                  labelText: 'Province/City, District, Ward',
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
                  labelText: 'Street',
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 210, 210, 210),
                  ),
                  filled: true,
                  fillColor: Color.fromARGB(255, 248, 248, 248),
                  
                ),
              ),
              SizedBox(height: 240),
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