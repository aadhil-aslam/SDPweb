import 'package:flutter/material.dart';

import '../station_screens/OrderStatus.dart';
import 'FuelStations.dart';
import 'OrderDelivery.dart';
import 'StationRequest.dart';


class PFDashboardScreen extends StatefulWidget {
  const PFDashboardScreen({Key? key}) : super(key: key);

  @override
  State<PFDashboardScreen> createState() => _PFDashboardScreenState();
}

class _PFDashboardScreenState extends State<PFDashboardScreen> {
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
                      label: Text("Fuel Station"),
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
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple.shade400,
      ),
    );
  }
}
