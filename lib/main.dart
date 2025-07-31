import 'dart:convert';

import 'package:begining/model/user.dart';
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
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart'; // <-- thêm dòng này
import 'dart:io';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // ======= 🔹 Thêm đoạn ghi log =======
  final dir = await getApplicationDocumentsDirectory();
  print('📂 Log directory: ${dir.path}');
  final logFile = File('${dir.path}/app_log.txt');


  debugPrint = (String? message, {int? wrapWidth}) {
    if (message != null) {
      logFile.writeAsStringSync(
        '${DateTime.now()} - $message\n',
        mode: FileMode.append,
        flush: true,
      );
    }
    print(message); // vẫn in ra console
  };
  // ===================================
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => PasswordProvider()),
        ChangeNotifierProvider(create: (_) => PinCodeProvider()),
        ChangeNotifierProvider(create: (_) => CarouselProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => RepeatPasswordProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString('user');
    print(prefs.getBool('is_logged_in'));
    print(prefs.getBool('isLoggedGoogle'));
    if (userString != null) {
      print('📦 User found in SharedPreferences: $userString');
      final Map<String, dynamic> userMap = jsonDecode(userString);
      return User.fromMap(userMap);
    }
    print('📦 No user found in SharedPreferences.');
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder<User?>(
        future: getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading user data'));
          } else {
            return HomeScreen(); // User is logged in
          }
        },
      ),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Poppins',
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
