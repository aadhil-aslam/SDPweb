import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:web/station_screens/request_action.dart';

import '../Login.dart';
import 'OrderStatus.dart';
import 'Requests.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool zeroPetrol = true;
  bool zeroDiesel = true;

  sendRequest() {
    return showDialog(
      barrierDismissible: false,
        context: context,
        builder: (parm) {
          return Center(
            child: Container(
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, 3),
                          blurRadius: 24)
                    ]),
                height: 250,
                width: 300,
                child:
                    //dieselLoaded & petrolLoaded & idLoaded ?
                    Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Send order",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Petrol: $totalPetrol litres',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                    decoration: TextDecoration.none),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Cost: $petrolCost LKR',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                    decoration: TextDecoration.none),
                              ),
                            ],
                          )),
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Diesel: $totalDiesel litres',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                      decoration: TextDecoration.none)),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Cost: $dieselCost LKR',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                    decoration: TextDecoration.none),
                              ),
                            ],
                          )),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.red.shade700),
                          child: TextButton(
                            onPressed: () async {
                              var dateFormat = DateFormat('MM/dd/yyyy hh:mm a');
                              var now = dateFormat.format(DateTime.now());

                              if (totalPetrol != 0) {
                                DocumentReference docRef =
                                    await FirebaseFirestore.instance
                                        .collection("Station Orders")
                                        .add({
                                  "Order date": now,
                                  "Status": "Pending",
                                  "Fuel amount": totalPetrol.toString(),
                                  "Fuel type": "Petrol",
                                  "Cost": petrolCost.toString(),
                                  "Station Name": StName,
                                  "Station ID": StId,
                                });
                                String docId = docRef.id;
                                await FirebaseFirestore.instance
                                    .collection("Station Orders")
                                    .doc(docId)
                                    .update({'id': docId});
                              }

                              //   //zeroPetrol != 0 ?
                              //   //: const SizedBox.shrink();

                              if (totalDiesel != 0) {
                                DocumentReference docRef =
                                    await FirebaseFirestore.instance
                                        .collection("Station Orders")
                                        .add({
                                  "Order date": now,
                                  "Status": "Pending",
                                  "Fuel amount": totalDiesel.toString(),
                                  "Fuel type": "Diesel",
                                  "Cost": dieselCost.toString(),
                                  "Station Name": StName,
                                  "Station ID": StId,
                                });
                                String docId = docRef.id;
                                await FirebaseFirestore.instance
                                    .collection("Station Orders")
                                    .doc(docId)
                                    .update({'id': docId});
                              }

                              // totalDiesel != 0?
                              //: const SizedBox.shrink();

                              var collection = FirebaseFirestore.instance
                                  .collection('Requests')
                                  .where('Ordered', isEqualTo: false)
                                  .where('stationID', isEqualTo: StId);
                              var querySnapshots = await collection.get();
                              for (var doc in querySnapshots.docs) {
                                await doc.reference.update({
                                  'Ordered': true,
                                });
                              }

                              // setState(() {
                              //   _isLoading = false;
                              // });
                              // _isLoading
                              //     ? const SizedBox(
                              //         height: 30,
                              //         width: 30,
                              //         child: CircularProgressIndicator(
                              //             strokeWidth: 3, color: Colors.white),
                              //       )
                              //     :

                              Navigator.of(context, rootNavigator: true).pop();
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text("Request",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                //: const Center(child: CircularProgressIndicator())
                ,
              ),
            ),
          );
        });
  }

  num totalPetrol = 0;
  num totalDiesel = 0;

  num dieselCost = 0;
  num petrolCost = 0;

  //bool _isLoading = true;

  Future getTotalPetrol() async {
    //_fetchID();
    print("StId: $StId");
    num sum = 0;
    await FirebaseFirestore.instance
        .collection('Requests')
        .where('stationID', isEqualTo: StId)
        .where('Ordered', isEqualTo: false)
        .where('Status', isEqualTo: "Pending")
        .where('fuelType', isEqualTo: "Petrol")
        .get()
        .then(
      (querySnapshot) {
        for (var result in querySnapshot.docs) {
          sum = sum + int.parse(result.data()['requested amount']);
          setState(() {
            totalPetrol = sum;
            petrolCost = totalPetrol * 300;
          });
        }
        print('total petrol: $totalPetrol');
      },
    );
  }

  Future getTotalDiesel() async {
    //_fetchID();
    print("StId: $StId");
    num sum = 0;
    await FirebaseFirestore.instance
        .collection('Requests')
        .where('stationID', isEqualTo: StId)
        .where('Ordered', isEqualTo: false)
        .where('Status', isEqualTo: "Pending")
        .where('fuelType', isEqualTo: "Diesel")
        .get()
        .then(
      (querySnapshot) {
        for (var result in querySnapshot.docs) {
          sum = sum + int.parse(result.data()['requested amount']);
          setState(() {
            totalDiesel = sum;
            dieselCost = totalDiesel * 250;
          });
        }
        print('total diesel: $totalDiesel');
      },
    );
  }

  @override
  void initState() {
    _fetchID();
    super.initState();
  }

  String Name = "";
  String StId = "";
  String StName = "";

  _fetchID() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection("StationUser")
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        setState(() {
          Name = ds.data()!['username'];
          StId = ds.data()!['StationID'];
          StName = ds.data()!['StationName'];
        });
        getTotalPetrol();
        getTotalDiesel();
        // print(Name);
        // print(StId);
        // print(StName);
      }).catchError((e) {});
    } else {
      Name = '';
    }
  }

  _logoutAlert() {
    return showDialog(
        context: context,
        builder: (parm) {
          return AlertDialog(
            title: const Text(
              'Do you want to logout?',
              style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
            ),
            actions: [
              TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    //backgroundColor: Colors.blueGrey,
                  ),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  child: const Text('Cancel', style: TextStyle(fontSize: 17))),
              TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red,
                    //backgroundColor: Colors.red,
                  ),
                  onPressed: () async {
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context, rootNavigator: true).pop();
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            child: LoginPage()));
                  },
                  child: const Text(
                    'Logout',
                    style: TextStyle(fontSize: 17),
                  )),
            ],
          );
        });
  }

  //setting the expansion function for the navigation rail
  int _selectedIndex = 2;
  bool isExpanded = true;
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
                  trailing: Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: IconButton(
                            icon: const Icon(
                              Icons.logout,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              _logoutAlert();
                            }),
                      ),
                    ),
                  ),
                  // leading: IconButton(
                  //   color: Colors.white,
                  //   onPressed: () {
                  //     //let's trigger the navigation expansion
                  //     setState(() {
                  //       isExpanded = !isExpanded;
                  //     });
                  //   },
                  //   icon: Icon(Icons.menu),
                  // ),
                  onDestinationSelected: (int index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  selectedIndex: _selectedIndex,
                  extended: isExpanded,
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
                      label: Text("Order Status"),
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
                      label: Text("Customer requests"),
                    ),
                    NavigationRailDestination(
                      icon: Icon(
                        Icons.person,
                        color: Colors.white54,
                      ),
                      selectedIcon: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      label: Text("Profile"),
                    ),
                    // NavigationRailDestination(
                    //   icon: Icon(
                    //     Icons.settings,
                    //     color: Colors.white54,
                    //   ),
                    //   selectedIcon: Icon(
                    //     Icons.settings,
                    //     color: Colors.white,
                    //   ),
                    //   label: Text("Order of Fuel"),
                    // ),
                  ],
                ),
              ),
              //color: const Color(0xff333951),
            ],
          ),
          _selectedIndex == 0
              ? Expanded(
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
                              // IconButton(
                              //   onPressed: () {
                              //     //let's trigger the navigation expansion
                              //     setState(() {
                              //       isExpanded = !isExpanded;
                              //     });
                              //   },
                              //   icon: Icon(Icons.menu),
                              // ),
                              StreamBuilder<
                                  DocumentSnapshot<Map<String, dynamic>>>(
                                //key: Key(_uid),
                                stream: FirebaseFirestore.instance
                                    .collection('StationUser')
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    //String username = snapshot.data?.data()?['username'];
                                    //print(snapshot.data?.data()?['Token Number']);
                                    return Text(
                                        snapshot.data?.data()?['StationName'],
                                        style: TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.w600));
                                  }
                                  return Text("Welcome",
                                      style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w600));
                                },
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
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.article,
                                          size: 26.0,
                                        ),
                                        SizedBox(
                                          width: 15.0,
                                        ),
                                        Text(
                                          "Total requests",
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Text(
                                      "View Details",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ))),
                              Flexible(
                                  child: Card(
                                      child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.article,
                                          size: 26.0,
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
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Text(
                                      "View Details",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ))),
                              Flexible(
                                  child: Card(
                                      child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.article,
                                          size: 26.0,
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
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Text(
                                      "View Details",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ))),
                              Flexible(
                                  child: Card(
                                      child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.article,
                                          size: 26.0,
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
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Text(
                                      "View Details",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ))),
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
              : _selectedIndex == 1
                  ? OrderStatus()
                  : _selectedIndex == 2
                      ? Requests()
                      : _selectedIndex == 3
                          ? RequestAction()
                          : SizedBox.shrink(),
        ],
      ),
      //let's add the floating action button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _fetchID();
          // getTotalDiesel();
          // getTotalPetrol();
          sendRequest();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple.shade400,
      ),
    );
  }
}
