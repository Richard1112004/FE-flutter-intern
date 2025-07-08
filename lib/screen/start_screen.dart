import 'package:begining/screen/login_screen.dart';
import 'package:begining/screen/register_screen.dart';
import 'package:flutter/material.dart';
class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 100),
            Image.asset('assets/icon.jpg', height: 170),
            Text(
              'Richard Shop',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Buy Now, Pay Easy!!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextButton(
                onPressed: () => {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => const RegisterScreen(),
                  )),
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    const Color.fromARGB(255, 0, 76, 255),
                  ),
                  foregroundColor: WidgetStatePropertyAll(
                    Colors.white,
                  ),
                  minimumSize: WidgetStatePropertyAll(
                    const Size(double.infinity, 50),
                  ),
                ),
                child: Text(
                  'Get Started',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: TextButton(
                onPressed: () => {
                  
                },
                style: ButtonStyle(
                  backgroundColor:  WidgetStatePropertyAll(
                    Colors.white,
                  ),
                  foregroundColor: WidgetStatePropertyAll(
                    const Color.fromARGB(255, 75, 75, 75),
                  ),
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
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/google_logo.png', // Đường dẫn đến file logo Google
                      width: 20,
                      height: 20,
                    ),
                    SizedBox(width: 20),
                    Text(
                      'Sign in with Google',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'I already have an account',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                IconButton(
                  onPressed: () => {
                    Navigator.push(context, MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  )),
                  },
                  icon: const Icon(
                    Icons.arrow_circle_right_rounded,
                    size: 30,
                    color: Color.fromARGB(255, 0, 76, 255),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.shopping_cart),
      //       label: 'Cart',
      //     ),
      //     BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      //   ],
      //   currentIndex: navigationProvider.currentIndex,
      //   onTap: (index) {
      //     navigationProvider.setIndex(index);
      //     // Handle navigation
      //   },
      //   selectedItemColor: const Color.fromARGB(255, 0, 76, 255),
      // ),
    );
  }
}
