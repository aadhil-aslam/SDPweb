import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../Login.dart';
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

  bool _validateEmail = false;
  bool _validatePW = false;
  bool _validateUN = false;
  bool _validateSId = false;
  bool _validateStName = false;

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

  final _usernameController = TextEditingController();
  final _stationIDController = TextEditingController();
  final _stationNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      FirebaseFirestore.instance
          .collection("StationUser")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "username": _usernameController.text,
        "email": _emailController.text,
        "StationID": _stationIDController.text,
        "StationName": _stationNameController.text,
      });
      Navigator.push(context,
          PageTransition(type: PageTransitionType.fade, child: LoginPage()));
    } on FirebaseAuthException catch (e) {
      setState(() {
        _showSuccessSnackbar(e.toString());
        errorMessage = e.message;
      });
    }
  }

  // addStation() {
  //   return showDialog(
  //     //barrierDismissible: false,
  //       context: context,
  //       builder: (parm) {
  //         return Material(
  //             child: Center(
  //               child: Container(
  //             color: Colors.transparent,
  //             child: Container(
  //               decoration: BoxDecoration(
  //                   color: Colors.white,
  //                   borderRadius: BorderRadius.circular(8),
  //                   boxShadow: const [
  //                     BoxShadow(
  //                         color: Colors.grey,
  //                         offset: Offset(0, 3),
  //                         blurRadius: 24)
  //                   ]),
  //               height: 650,
  //               width: 400,
  //               child:
  //               //dieselLoaded & petrolLoaded & idLoaded ?
  //               Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 10),
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Text(
  //                       "Add Station",
  //                       style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
  //                     ),
  //                     SizedBox(
  //                       height: 20,
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.symmetric(horizontal: 30),
  //                       child: TextField(
  //                         //enabled: quota ? true : false,
  //                         controller: _stationNameController,
  //                           decoration: InputDecoration(
  //                             prefixIcon: Icon(Icons.local_gas_station),
  //                             filled: true,
  //                             fillColor: Colors.grey[200],
  //                             //isDense: true,
  //                             labelText: 'station name',
  //                             border: InputBorder.none,
  //                             errorText: _validateStName ? 'Station Name Can\'t Be Empty' : null,
  //                           )),
  //                     ),
  //                     SizedBox(
  //                       height: 20,
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.symmetric(horizontal: 30),
  //                       child: TextField(
  //                         //enabled: quota ? true : false,
  //                         controller: _stationIDController,
  //                           decoration: InputDecoration(
  //                             prefixIcon: Icon(Icons.local_gas_station),
  //                             filled: true,
  //                             fillColor: Colors.grey[200],
  //                             //isDense: true,
  //                             labelText: 'station ID',
  //                             border: InputBorder.none,
  //                             errorText: _validateSId ? 'Station ID Can\'t Be Empty' : null,
  //                           )),
  //                     ),
  //                     SizedBox(
  //                       height: 20,
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.symmetric(horizontal: 30),
  //                       child: TextField(
  //                         //enabled: quota ? true : false,
  //                         controller: _usernameController,
  //                           decoration: InputDecoration(
  //                             prefixIcon: Icon(Icons.person_outline),
  //                             filled: true,
  //                             fillColor: Colors.grey[200],
  //                             //isDense: true,
  //                             labelText: 'username',
  //                             border: InputBorder.none,
  //                             errorText: _validateUN ? 'Username Can\'t Be Empty' : null,
  //                           )),
  //                     ),
  //                     SizedBox(
  //                       height: 20,
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.symmetric(horizontal: 30),
  //                       child: TextField(
  //                         //enabled: quota ? true : false,
  //                         controller: _emailController,
  //                           decoration: InputDecoration(
  //                             prefixIcon: Icon(Icons.mail_outline),
  //                             filled: true,
  //                             fillColor: Colors.grey[200],
  //                             //isDense: true,
  //                             labelText: 'email',
  //                             border: InputBorder.none,
  //                             errorText: _validateEmail ? 'Email Can\'t Be Empty' : null,
  //                           )),
  //                     ),
  //                     SizedBox(
  //                       height: 20,
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.symmetric(horizontal: 30),
  //                       child: TextField(
  //                         obscureText: true,
  //                         controller: _passwordController,
  //                         decoration: InputDecoration(
  //                           prefixIcon: Icon(Icons.lock_open),
  //                           filled: true,
  //                           fillColor: Colors.grey[200],
  //                           //isDense: true,
  //                           labelText: 'password',
  //                           border: InputBorder.none,
  //                           errorText: _validatePW ? 'Password Can\'t Be Empty' : null,
  //                         ),
  //                       ),
  //                     ),
  //                     SizedBox(
  //                       height: 20,
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.symmetric(horizontal: 20),
  //                       child: SizedBox(
  //                         height: 40,
  //                         width: MediaQuery.of(context).size.width,
  //                         child: TextButton(
  //                             style: TextButton.styleFrom(
  //                                 foregroundColor: Colors.white,
  //                                 backgroundColor: Colors.red[700],
  //                                 textStyle: const TextStyle(fontSize: 15)),
  //                             onPressed: () {
  //                               setState(() {
  //                                 _emailController.text.isEmpty
  //                                     ? _validateEmail = true
  //                                     : _validateEmail = false;
  //                                 _passwordController.text.isEmpty
  //                                     ? _validatePW = true
  //                                     : _validatePW = false;
  //                                 _usernameController.text.isEmpty
  //                                     ? _validateUN = true
  //                                     : _validateUN = false;
  //                                 _stationIDController.text.isEmpty
  //                                     ? _validateSId = true
  //                                     : _validateSId = false;
  //                                 _stationIDController.text.isEmpty
  //                                     ? _validateStName = true
  //                                     : _validateStName = false;
  //                               });
  //                               if (_validatePW == false &&
  //                                   _validateEmail == false &&
  //                                   _validateSId == false &&
  //                                   _validateUN == false &&
  //                                   _validateStName == false) {
  //                                 createUserWithEmailAndPassword();
  //                               }
  //                             },
  //                             child: const Text('Save')),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               )
  //               //: const Center(child: CircularProgressIndicator())
  //               ,
  //             ),
  //           ),
  //         ));
  //       });
  // }

  //setting the expansion function for the navigation rail
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
                                        "Total Fuel station",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],),
                                      SizedBox(height: 20.0,),
                                      Text("View Details", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
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
                                      Text("View Details", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
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
                                      Text("View Details", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
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
                                      Text("View Details", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
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
