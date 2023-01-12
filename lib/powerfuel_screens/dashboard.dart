import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
//import 'package:web/powerfuelLogin.dart';

import '../powerfuelLogin.dart';
import '../station_screens/OrderStatus.dart';
import '../station_screens/auth.dart';
import 'FuelStations.dart';
import 'OrderDelivery.dart';
import 'StationRequest.dart';
import 'add station.dart';



class PFDashboardScreen extends StatefulWidget {
  const PFDashboardScreen({Key? key}) : super(key: key);

  @override
  State<PFDashboardScreen> createState() => _PFDashboardScreenState();
}

class _PFDashboardScreenState extends State<PFDashboardScreen> {

  double accepted = 0;
  double pending = 0;
  double cancelled = 0;
  double stations = 0;

  _fetchAccepted() async {
    await FirebaseFirestore.instance
        .collection('Station Orders')
        .where("Status", isEqualTo: "Accepted")
        .get()
        .then((ds) {
      setState(() {
        accepted = ds.docs.length as double;
        print(accepted);
      });
    }).catchError((e) {});
  }

  _fetchCancelled() async {
    await FirebaseFirestore.instance
        .collection('Station Orders')
        .where("Status", isEqualTo: "Cancelled")
        .get()
        .then((ds) {
      setState(() {
        cancelled = ds.docs.length as double;
        print(cancelled);
      });
    }).catchError((e) {});
  }

  _fetchPending() async {
    await FirebaseFirestore.instance
        .collection('Station Orders')
        .where("Status", isEqualTo: "Pending")
        .get()
        .then((ds) {
      setState(() {
        pending = ds.docs.length as double;
        print(pending);
      });
    }).catchError((e) {});
  }

  _fetchStations() async {
    await FirebaseFirestore.instance
        .collection('StationUser')
        .get()
        .then((ds) {
      setState(() {
        stations = ds.docs.length as double;
      });
    }).catchError((e) {});
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  String? errorMessage = "";

  bool isLogin = true;

  final db = FirebaseFirestore.instance;

  _showSuccessSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red[700],
      ),
    );
  }

  @override
  void initState() {
    _fetchAccepted();
    _fetchCancelled();
    _fetchPending();
    _fetchStations();
    super.initState();
  }

  int _selectedIndex = 0;
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Let's start by adding the Navigation Rail
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: NavigationRail(
                  onDestinationSelected: (int index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  selectedIndex: _selectedIndex,
                  extended: true,
                  backgroundColor: Color(0xff333951),
                  unselectedIconTheme:
                  IconThemeData(color: Colors.white, opacity: 1),
                  unselectedLabelTextStyle: TextStyle(
                    color: Colors.white54,
                  ),
                  selectedLabelTextStyle: TextStyle(
                    color: Colors.white,
                  ),
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(
                        Icons.home_outlined,
                        color: Colors.white54,
                      ),
                      selectedIcon: Icon(
                        Icons.home,
                        color: Colors.white,
                      ),
                      label: Text("Home"),
                    ),
                    NavigationRailDestination(
                      icon: Icon(
                        Icons.bar_chart,
                        color: Colors.white54,
                      ),
                      selectedIcon: Icon(
                        Icons.bar_chart,
                        color: Colors.white,
                      ),
                      label: Text("Order Delivery"),
                    ),
                    NavigationRailDestination(
                      icon: Icon(
                        Icons.local_gas_station,
                        color: Colors.white54,
                      ),
                      selectedIcon: Icon(
                        Icons.local_gas_station,
                        color: Colors.white,
                      ),
                      label: Text("Fuel Stations"),
                    ),
                    NavigationRailDestination(
                      icon: Icon(
                        Icons.shopping_bag,
                        color: Colors.white54,
                      ),
                      selectedIcon: Icon(
                        Icons.shopping_bag,
                        color: Colors.white,
                      ),
                      label: Text("Requests"),
                    ),
                  ],
                ),
              ),
              // Container(
              //   height: 70,
              //   width: 72,
              //   //color: const Color(0xff333951),
              //   child: IconButton(
              //     color: Colors.black,
              //     onPressed: () {
              //       //let's trigger the navigation expansion
              //       setState(() {
              //         isExpanded = !isExpanded;
              //       });
              //     },
              //     icon: Icon(Icons.menu),
              //   ),
              // ),
            ],
          ),
          _selectedIndex == 0
              ?
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(30.0, 60.0, 60.0, 0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //let's add the navigation menu for this project
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            //let's trigger the navigation expansion
                            setState(() {
                              isExpanded = !isExpanded;
                            });
                          },
                          icon: Icon(Icons.menu),
                        ),
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://faces-img.xcdn.link/image-lorem-face-3430.jpg"),
                          radius: 26.0,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                            child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [Row(children: [Icon(Icons.article, size: 26.0,
                                    ),
                                      SizedBox(
                                        width: 15.0,
                                      ),
                                      Text(
                                        "Total Fuel stations",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],),
                                      SizedBox(height: 20.0,),
                                      Text("$stations", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                                    ],
                                  ),
                                ))
                        ),

                        Flexible(
                            child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [Row(children: [Icon(Icons.article, size: 26.0,
                                    ),
                                      SizedBox(
                                        width: 15.0,
                                      ),
                                      Text(
                                        "New Fuel Order",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],),
                                      SizedBox(height: 20.0,),
                                      Text("$pending", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                                    ],
                                  ),
                                ))
                        ),

                        Flexible(
                            child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [Row(children: [Icon(Icons.article, size: 26.0,
                                    ),
                                      SizedBox(
                                        width: 15.0,
                                      ),
                                      Text(
                                        "Confirmed Order",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],),
                                      SizedBox(height: 20.0,),
                                      Text("$accepted", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                                    ],
                                  ),
                                ))
                        ),

                        Flexible(
                            child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [Row(children: [Icon(Icons.article, size: 26.0,
                                    ),
                                      SizedBox(
                                        width: 15.0,
                                      ),
                                      Text(
                                        "Cancelled Order",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],),
                                      SizedBox(height: 20.0,),
                                      Text("$cancelled", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                                    ],
                                  ),
                                ))
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                  ],
                ),
              ),
            ),
          )
              : _selectedIndex == 1 ? OrderDelivery()
              : _selectedIndex == 2 ? FuelStations()
              : _selectedIndex == 3 ? FuelStationRequest()
              : SizedBox.shrink(),
        ],
      ),
      //let's add the floating action button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              PageTransition(type: PageTransitionType.fade, child: AddUser()));
          //addStation();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple.shade400,
      ),
    );
  }
}
