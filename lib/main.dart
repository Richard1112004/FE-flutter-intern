import 'package:begining/provider/pincode_provider.dart';
import 'package:flutter/material.dart';
import 'package:begining/provider/navigation_provider.dart';
import 'package:provider/provider.dart';
import 'package:begining/screen/start_screen.dart';
import 'package:begining/provider/password_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => NavigationProvider())
      , ChangeNotifierProvider(create: (_) => PasswordProvider()),
      ChangeNotifierProvider(create: (_) => PinCodeProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const StartScreen(),
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,
    );
  }
}

