import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class FuelStations extends StatefulWidget {
  const FuelStations({Key? key}) : super(key: key);

  @override
  State<FuelStations> createState() => _FuelStationsState();
}

class _FuelStationsState extends State<FuelStations> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 60.0, 60.0, 0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //let's add the navigation menu for this project
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     IconButton(
              //       onPressed: () {
              //         //let's trigger the navigation expansion
              //         setState(() {
              //           //isExpanded = !isExpanded;
              //         });
              //       },
              //       icon: Icon(Icons.menu),
              //     ),
              //     CircleAvatar(
              //       backgroundImage: NetworkImage(
              //           "https://faces-img.xcdn.link/image-lorem-face-3430.jpg"),
              //       radius: 26.0,
              //     ),
              //   ],
              // ),
              //let's set the filter section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Fuel Stations",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28.0,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 300.0,
                        child: TextField(
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: "Select Fuel Station",
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black26,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 40.0,
                      ),
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
                      columns: const [
                        DataColumn(label: Text("ID")),
                        DataColumn(label: Text("City")),
                        DataColumn(label: Text("Name")),
                        DataColumn(label: Text("Address")),
                        DataColumn(label: Text("Create date")),
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
    );
  }
}
