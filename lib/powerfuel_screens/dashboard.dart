import 'package:flutter/material.dart';

import '../station_screens/OrderStatus.dart';
import 'OrderDelivery.dart';


class PFDashboardScreen extends StatefulWidget {
  const PFDashboardScreen({Key? key}) : super(key: key);

  @override
  State<PFDashboardScreen> createState() => _PFDashboardScreenState();
}

class _PFDashboardScreenState extends State<PFDashboardScreen> {
  //setting the expansion function for the navigation rail
  int _selectedIndex = 1;
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
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
                      label: Text("Fuel Stations"),
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
                    NavigationRailDestination(
                      icon: Icon(
                        Icons.settings,
                        color: Colors.white54,
                      ),
                      selectedIcon: Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                      label: Text("Order of Fuel"),
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
              padding: EdgeInsets.symmetric(horizontal: 60.0),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "6 Articles",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 28.0,
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              "3 new Articles",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        Container(
                          width: 300.0,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Type Fuel Station",
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black26,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 40.0,
                    ),

                    //let's set the filter section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.deepPurple.shade400,
                          ),
                          label: Text(
                            "2022, July 14, July 15, July 16",
                            style: TextStyle(
                              color: Colors.deepPurple.shade400,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            DropdownButton(
                                hint: Text("Filter by"),
                                items: [
                                  DropdownMenuItem(
                                    value: "Date",
                                    child: Text("Date"),
                                  ),
                                  DropdownMenuItem(
                                    value: "Reviews",
                                    child: Text("Reviews"),
                                  ),
                                  DropdownMenuItem(
                                    value: "Branches",
                                    child: Text("Branches"),
                                  ),
                                ],
                                onChanged: (value) {}),
                            SizedBox(
                              width: 20.0,
                            ),
                            DropdownButton(
                                hint: Text("Order by"),
                                items: [
                                  DropdownMenuItem(
                                    value: "Date",
                                    child: Text("Date"),
                                  ),
                                  DropdownMenuItem(
                                    value: "Reviews",
                                    child: Text("Reviews"),
                                  ),
                                  DropdownMenuItem(
                                    value: "Branches",
                                    child: Text("Branches"),
                                  ),
                                ],
                                onChanged: (value) {}),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    //Now let's add the Table
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        DataTable(
                            headingRowColor:
                            MaterialStateProperty.resolveWith(
                                    (states) => Colors.grey.shade200),
                            columns: [
                              DataColumn(label: Text("ID")),
                              DataColumn(label: Text("City of Fual Station")),
                              DataColumn(label: Text("Type of Fuel")),
                              DataColumn(label: Text("Address of Fuel Station")),
                              DataColumn(label: Text("Fuel Price")),
                            ],
                            rows: [
                              DataRow(cells: [
                                DataCell(Text("1")),
                                DataCell(Text("Colombo")),
                                DataCell(Text("Petrol")),
                                DataCell(Text("Colombo , 10")),
                                DataCell(Text("LKR 100/=")),
                              ]),
                              DataRow(cells: [
                                DataCell(Text("2")),
                                DataCell(Text("Kandy")),
                                DataCell(Text("Petrol")),
                                DataCell(Text("Kandy , 10")),
                                DataCell(Text("LKR 100/=")),
                              ]),
                              DataRow(cells: [
                                DataCell(Text("3")),
                                DataCell(Text("Polanaruwa")),
                                DataCell(Text("Petrol")),
                                DataCell(Text("Polanaruwa , 10")),
                                DataCell(Text("LKR 100/=")),
                              ]),
                              DataRow(cells: [
                                DataCell(Text("4")),
                                DataCell(Text("Anuradhapuram")),
                                DataCell(Text("Petrol")),
                                DataCell(Text("Anuradhapura , 10")),
                                DataCell(Text("LKR 100/=")),
                              ]),
                            ]),
                        //Now let's set the pagination
                        SizedBox(
                          height: 40.0,
                        ),
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "1",
                                style:
                                TextStyle(color: Colors.deepPurple),
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "2",
                                style:
                                TextStyle(color: Colors.deepPurple),
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "3",
                                style:
                                TextStyle(color: Colors.deepPurple),
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "See All",
                                style:
                                TextStyle(color: Colors.deepPurple),
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
              : _selectedIndex == 1 ? OrderDelivery(): SizedBox.shrink(),
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
