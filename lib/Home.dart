import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web/screens/dashboard.dart';

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
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DashboardScreen()));
                },
                child: Text("Power Fuel", style: TextStyle(color: Colors.white),)),
            SizedBox(width: 20,),
            TextButton(
                // style: TextButton.styleFrom(
                //     foregroundColor: Colors.white,
                //     backgroundColor: Colors.blueGrey,
                //     textStyle: const TextStyle(fontSize: 15)),
                onPressed: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => DashboardScreen()));
                },
                child: Text("Fuel Station", style: TextStyle(color: Colors.white),)),SizedBox(width: 40,),
          ],
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 60.0),
          child: SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

              ],
            ),
          ),
        ));
  }
}
