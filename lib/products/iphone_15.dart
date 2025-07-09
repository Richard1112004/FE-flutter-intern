import 'package:flutter/material.dart';

class Iphone15 extends StatelessWidget {
  const Iphone15({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 0.7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  image: DecorationImage(
                    image: const AssetImage('assets/iphone_16_bigger.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.025),
              Text(
                'iPhone 16',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Nunito Sans',
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '\$ 1,199',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Text(
                    'The iPhone 16 is the latest in Apple\'s line of smartphones, featuring cutting-edge technology and a sleek design.',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.025),
              TextButton(
                onPressed: () => {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const HomeScreen()),
                  // ),
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
                  'View installment options',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w300),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              TextButton(
                onPressed: () => {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const HomeScreen()),
                  // ),
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    Color.fromARGB(255, 0, 76, 255)
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
                  'Add to cart',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w300),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
