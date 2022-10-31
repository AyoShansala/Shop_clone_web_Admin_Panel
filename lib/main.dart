import 'package:admin_web_portal_seller_amazon_app/authentication/login_screen.dart';
import 'package:admin_web_portal_seller_amazon_app/homeScreen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyA2T_3g8QPVdioDYRlvPZCKdPLZB8Yg6Rw",
          appId: "1:488403028289:web:c8ad4b6a1a90618baff9c0",
          messagingSenderId: "488403028289",
          projectId: "clone-64152"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin web',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: FirebaseAuth.instance.currentUser != null
          ? HomeScreen()
          : LoginScreen(),
    );
  }
}
