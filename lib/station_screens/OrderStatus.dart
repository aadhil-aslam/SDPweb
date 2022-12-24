import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class OrderStatus extends StatefulWidget {
  const OrderStatus({Key? key}) : super(key: key);

  @override
  State<OrderStatus> createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus> {
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
                    "Order Status",
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
                      headingRowColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.grey.shade200),
                      columns: const [
                        DataColumn(label: Text("Order Number")),
                        DataColumn(label: Text("Order date")),
                        DataColumn(label: Text("Type of Fuel")),
                        DataColumn(label: Text("Quantity")),
                        DataColumn(label: Text("Total cost")),
                        DataColumn(label: Text("Status")),
                      ],
                      rows: [
                        DataRow(cells: [
                          DataCell(Text("1")),
                          DataCell(Text("01.10.2022")),
                          DataCell(Text("Petrol")),
                          DataCell(Text("100 liters")),
                          DataCell(Text("LKR 50,000")),
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
                          DataCell(Text("2")),
                          DataCell(Text("01.10.2022")),
                          DataCell(Text("Diesel")),
                          DataCell(Text("150 liters")),
                          DataCell(Text("LKR 150,000")),
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
                          DataCell(Text("3")),
                          DataCell(Text("01.10.2022")),
                          DataCell(Text("Petrol")),
                          DataCell(Text("200 liters")),
                          DataCell(Text("LKR 250,000")),
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
                          DataCell(Text("4")),
                          DataCell(Text("01.10.2022")),
                          DataCell(Text("Petrol")),
                          DataCell(Text("50 liters")),
                          DataCell(Text("LKR 25,000")),
                          DataCell(TextButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.green)),
                              onPressed: () {},
                              child: Text(
                                "Accepted",
                                style: TextStyle(color: Colors.white),
                              ))),
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
                          style: TextStyle(color: Colors.deepPurple),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "2",
                          style: TextStyle(color: Colors.deepPurple),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "3",
                          style: TextStyle(color: Colors.deepPurple),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "See All",
                          style: TextStyle(color: Colors.deepPurple),
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
