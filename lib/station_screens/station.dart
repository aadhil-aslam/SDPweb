import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Login.dart';
import 'dashboard.dart';

class station extends StatelessWidget {
  station({super.key});

  late bool isLoggedIn = true;

  CheckLogin() {
    if (FirebaseAuth.instance.currentUser?.uid != null) {
      print(FirebaseAuth.instance.currentUser?.uid);
      isLoggedIn = true;
    } else {
      isLoggedIn = false;
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    CheckLogin();
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? DashboardScreen() : LoginPage(),
    );
  }
}
