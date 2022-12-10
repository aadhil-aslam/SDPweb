import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Requests extends StatefulWidget {
  const Requests({Key? key}) : super(key: key);

  @override
  State<Requests> createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
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
                    "Customer Requests",
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
                            hintText: "Type Order Number",
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
                        DataColumn(label: Text("Token Number")),
                        DataColumn(label: Text("Vehicle Number")),
                        DataColumn(label: Text("Customer Name")),
                        DataColumn(label: Text("Fuel Type")),
                        DataColumn(label: Text("Quantity")),
                        DataColumn(label: Text("Total cost")),
                        DataColumn(label: Text("Status")),
                      ],
                      rows: [
                        DataRow(cells: [
                          DataCell(Text("1564")),
                          DataCell(Text("ABC1234")),
                          DataCell(Text("Nawab")),
                          DataCell(Text("Petrol")),
                          DataCell(Text("2 liters")),
                          DataCell(Text("LKR 500")),
                          DataCell
                            // (DropdownButton(
                            //   hint: Text("Filter by"),
                            //   items: [
                            //     DropdownMenuItem(
                            //       value: "Date",
                            //       child: Text("Date"),
                            //     ),
                            //     DropdownMenuItem(
                            //       value: "Reviews",
                            //       child: Text("Reviews"),
                            //     ),
                            //     DropdownMenuItem(
                            //       value: "Branches",
                            //       child: Text("Branches"),
                            //     ),
                            //   ],
                            //   onChanged: (value) {}))
                            (TextButton(
                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
                              onPressed: () {
                              },
                              child: Text("Accepted", style: TextStyle(color: Colors.white),))),
                        ]),
                        DataRow(cells: [
                          DataCell(TextButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all(Colors.red)),
                              onPressed: () {},
                              child: Text(
                                "Pending",
                                style: TextStyle(color: Colors.white),
                              ))),
                          DataCell(Text("ABC1234")),
                          DataCell(Text("Priya")),
                          DataCell(Text("Petrol")),
                          DataCell(Text("5 liters")),
                          DataCell(Text("LKR 2000")),
                          DataCell(TextButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all(Colors.red)),
                              onPressed: () {},
                              child: Text(
                                "Pending",
                                style: TextStyle(color: Colors.white),
                              ))),
                        ]),
                        DataRow(cells: [
                          DataCell(TextButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all(Colors.red)),
                              onPressed: () {},
                              child: Text(
                                "Pending",
                                style: TextStyle(color: Colors.white),
                              ))),
                          DataCell(Text("ABC1234")),
                          DataCell(Text("Aadhil")),
                          DataCell(Text("Petrol")),
                          DataCell(Text("10 liters")),
                          DataCell(Text("LKR 4000")),
                          DataCell(TextButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all(Colors.red)),
                              onPressed: () {},
                              child: Text(
                                "Pending",
                                style: TextStyle(color: Colors.white),
                              ))),
                        ]),
                        DataRow(cells: [
                          DataCell(Text("4246")),
                          DataCell(Text("ABC1234")),
                          DataCell(Text("User")),
                          DataCell(Text("Petrol")),
                          DataCell(Text("5 liters")),
                          DataCell(Text("LKR 2500")),
                          DataCell(TextButton(
                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
                              onPressed: () {
                              },
                              child: Text("Accepted", style: TextStyle(color: Colors.white),))),
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
