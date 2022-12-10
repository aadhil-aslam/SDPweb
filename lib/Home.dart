import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:web/powerfuel_screens/dashboard.dart';
import 'package:web/station_screens/dashboard.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[700],
        title: const Text('PowerFuel', style: TextStyle(color: Colors.white)),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: PFDashboardScreen()));

                // Navigator.push(
                //   context,
                //   PageRouteBuilder(
                //     pageBuilder: (context, animation, secondaryAnimation) => DashboardScreen(),
                //     transitionDuration: Duration(seconds: 0),
                //     transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
                //   ),
                // );
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => DashboardScreen()));
              },
              child: Text(
                "Power Fuel",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              )),
          SizedBox(
            width: 20,
          ),
          TextButton(
              // style: TextButton.styleFrom(
              //     foregroundColor: Colors.white,
              //     backgroundColor: Colors.blueGrey,
              //     textStyle: const TextStyle(fontSize: 15)),
              onPressed: () {
                Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: DashboardScreen()));

                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => DashboardScreen()));
              },
              child: Text(
                "Fuel Station",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              )),
          SizedBox(
            width: 40,
          ),
        ],
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
      ),
      body: Image.asset(
       'images/car.jpg',
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height),
    );
  }
}
