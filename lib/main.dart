import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:web/powerfuel_screens/CustomerRequest.dart';
import 'package:web/powerfuel_screens/add%20station.dart';
import 'package:web/station_screens/station.dart';
import 'Home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAE5WpltyBaX4IGqhs3aPwqoshXciEAvqg",
          projectId: "sdpproject-829b1",
          messagingSenderId: "215634344322",
          appId: "1:215634344322:web:9be489790c2fd3e773779b",));

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:
      MyHomePage(),
      //AddUser(),
      debugShowCheckedModeBanner: false,
    );
  }
}
