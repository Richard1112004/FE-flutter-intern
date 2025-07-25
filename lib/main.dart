import 'package:begining/provider/carousel_provider.dart';
import 'package:begining/provider/cart_provider.dart';
import 'package:begining/provider/pincode_provider.dart';
import 'package:begining/provider/repeat_password_provider.dart';
import 'package:begining/provider/user_provider.dart';
import 'package:begining/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:begining/provider/navigation_provider.dart';
import 'package:provider/provider.dart';
import 'package:begining/screen/start_screen.dart';
import 'package:begining/provider/password_provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); 
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => NavigationProvider())
      , ChangeNotifierProvider(create: (_) => PasswordProvider()),
      ChangeNotifierProvider(create: (_) => PinCodeProvider()),
      ChangeNotifierProvider(create: (_) => CarouselProvider()),
      ChangeNotifierProvider(create: (_) => CartProvider()),
      ChangeNotifierProvider(create: (_) => UserProvider()
      ),
      ChangeNotifierProvider(create: (_) => RepeatPasswordProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeScreen(),
      theme: ThemeData(scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Poppins',),
      debugShowCheckedModeBanner: false,
    );
  }
}

