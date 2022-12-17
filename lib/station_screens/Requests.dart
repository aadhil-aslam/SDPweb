import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
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
                  // DataTable(
                  //     headingRowColor:
                  //     MaterialStateProperty.resolveWith(
                  //             (states) => Colors.grey.shade200),
                  //     columns: const [
                  //       DataColumn(label: Text("Token Number")),
                  //       DataColumn(label: Text("Vehicle Number")),
                  //       DataColumn(label: Text("Customer Name")),
                  //       DataColumn(label: Text("Fuel Type")),
                  //       DataColumn(label: Text("Quantity")),
                  //       DataColumn(label: Text("Total cost")),
                  //       DataColumn(label: Text("Status")),
                  //     ],
                  //     rows: [
                  //       DataRow(cells: [
                  //         DataCell(Text("1564")),
                  //         DataCell(Text("ABC1234")),
                  //         DataCell(Text("Nawab")),
                  //         DataCell(Text("Petrol")),
                  //         DataCell(Text("2 liters")),
                  //         DataCell(Text("LKR 500")),
                  //         DataCell
                  //           // (DropdownButton(
                  //           //   hint: Text("Filter by"),
                  //           //   items: [
                  //           //     DropdownMenuItem(
                  //           //       value: "Date",
                  //           //       child: Text("Date"),
                  //           //     ),
                  //           //     DropdownMenuItem(
                  //           //       value: "Reviews",
                  //           //       child: Text("Reviews"),
                  //           //     ),
                  //           //     DropdownMenuItem(
                  //           //       value: "Branches",
                  //           //       child: Text("Branches"),
                  //           //     ),
                  //           //   ],
                  //           //   onChanged: (value) {}))
                  //           (TextButton(
                  //             style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
                  //             onPressed: () {
                  //             },
                  //             child: Text("Accepted", style: TextStyle(color: Colors.white),))),
                  //       ]),
                  //       DataRow(cells: [
                  //         DataCell(TextButton(
                  //             style: ButtonStyle(
                  //                 backgroundColor:
                  //                 MaterialStateProperty.all(Colors.red)),
                  //             onPressed: () {},
                  //             child: Text(
                  //               "Pending",
                  //               style: TextStyle(color: Colors.white),
                  //             ))),
                  //         DataCell(Text("ABC1234")),
                  //         DataCell(Text("Priya")),
                  //         DataCell(Text("Petrol")),
                  //         DataCell(Text("5 liters")),
                  //         DataCell(Text("LKR 2000")),
                  //         DataCell(TextButton(
                  //             style: ButtonStyle(
                  //                 backgroundColor:
                  //                 MaterialStateProperty.all(Colors.red)),
                  //             onPressed: () {},
                  //             child: Text(
                  //               "Pending",
                  //               style: TextStyle(color: Colors.white),
                  //             ))),
                  //       ]),
                  //       DataRow(cells: [
                  //         DataCell(TextButton(
                  //             style: ButtonStyle(
                  //                 backgroundColor:
                  //                 MaterialStateProperty.all(Colors.red)),
                  //             onPressed: () {},
                  //             child: Text(
                  //               "Pending",
                  //               style: TextStyle(color: Colors.white),
                  //             ))),
                  //         DataCell(Text("ABC1234")),
                  //         DataCell(Text("Aadhil")),
                  //         DataCell(Text("Petrol")),
                  //         DataCell(Text("10 liters")),
                  //         DataCell(Text("LKR 4000")),
                  //         DataCell(TextButton(
                  //             style: ButtonStyle(
                  //                 backgroundColor:
                  //                 MaterialStateProperty.all(Colors.red)),
                  //             onPressed: () {},
                  //             child: Text(
                  //               "Pending",
                  //               style: TextStyle(color: Colors.white),
                  //             ))),
                  //       ]),
                  //       DataRow(cells: [
                  //         DataCell(Text("4246")),
                  //         DataCell(Text("ABC1234")),
                  //         DataCell(Text("User")),
                  //         DataCell(Text("Petrol")),
                  //         DataCell(Text("5 liters")),
                  //         DataCell(Text("LKR 2500")),
                  //         DataCell(TextButton(
                  //             style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
                  //             onPressed: () {
                  //             },
                  //             child: Text("Accepted", style: TextStyle(color: Colors.white),))),
                  //       ]),
                  //     ]),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Requests')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Something went wrong');
                      }

                      // if (snapshot.connectionState == ConnectionState.waiting) {
                      //   return const Text("Loading");
                      // }

                      if (snapshot.hasData) {
                        print(snapshot.data!.docs);
                        List<DataCell> displayedDataCell = [];

                        //for (var item in snapshot.data!.docs)
                        for (int i = 0; i < snapshot.data!.docs.length; i++) {
                          bool pending = snapshot.data!.docs[i]
                              .get('Status')
                              .toString()
                              .startsWith("P");

                          bool canceled = snapshot.data!.docs[i]
                              .get('Status')
                              .toString()
                              .startsWith("C");

                          displayedDataCell.add(
                            DataCell(
                              Text(snapshot.data!.docs[i].get('Token')
                                  //item['Token'].toString(),
                                  ),
                            ),
                          );
                          displayedDataCell.add(
                            DataCell(
                              Text(snapshot.data!.docs[i].get('Vehicle number')

                                  //item['Vehicle number'].toString(),
                                  ),
                            ),
                          );
                          displayedDataCell.add(
                            DataCell(
                              Text(snapshot.data!.docs[i].get('customerName')

                                  //item['customerName'].toString(),
                                  ),
                            ),
                          );
                          displayedDataCell.add(
                            DataCell(
                              Text(
                                  snapshot.data!.docs[i].get('requested amount')

                                  //  item['requested amount'].toString(),
                                  ),
                            ),
                          );
                          displayedDataCell.add(DataCell(
                            Text(
                              snapshot.data!.docs[i].get('Status'),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: canceled
                                      ? Colors.red
                                      : pending
                                          ? Colors.black
                                          : Colors.green

                                  //  item['Status'].toString(), style: TextStyle(fontWeight: FontWeight.bold, color: accepted ? Colors.green : Colors.red),
                                  ),
                            ),
                          ));
                          displayedDataCell.add(
                            DataCell(
                              pending
                                  ? Row(
                                      children: [
                                        TextButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.green)),
                                            onPressed: () {
                                              print(snapshot.data!.docs[i]
                                                  .get('id'));
                                              FirebaseFirestore.instance
                                                  .collection('Requests')
                                                  .doc((snapshot.data!.docs[i]
                                                      .get('id')))
                                                  .update(
                                                      {'Status': 'Accepted'});
                                            },
                                            child: Text(
                                              "Accept",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        TextButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.red)),
                                            onPressed: () {
                                              print(snapshot.data!.docs[i]
                                                  .get('id'));
                                              FirebaseFirestore.instance
                                                  .collection('Requests')
                                                  .doc((snapshot.data!.docs[i]
                                                      .get('id')))
                                                  .update(
                                                      {'Status': 'Cancelled'});

                                              // StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                                              //   //key: Key(_uid),
                                              //   stream: FirebaseFirestore.instance
                                              //       .collection('Requests')
                                              //       .doc(snapshot.data!.docs[index].get('customerId'))
                                              //       .snapshots(),
                                              //   builder: (context, snapshot) {
                                              //     if (snapshot.hasData) {
                                              //       //String username = snapshot.data?.data()?['username'];
                                              //       print(snapshot.data?.data()?['requested amount']);
                                              //       return Text(snapshot.data!['requested amount'],
                                              //           style: TextStyle(fontSize: 17));
                                              //     }
                                              //     print('requested amount');
                                              //     return Text("requested amount",
                                              //         style: TextStyle(fontSize: 20));
                                              //   },
                                              // );
                                            },
                                            child: Text(
                                              "Cancel",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ))
                                      ],
                                    )
                                  : canceled
                                      ? TextButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.red)),
                                          onPressed: () {},
                                          child: Text(
                                            "Cancelled",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ))
                                      : TextButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.green)),
                                          onPressed: () {},
                                          child: Text(
                                            "Accepted",
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                            ),
                          );
                        }

                        return DataTable(
                          headingRowColor: MaterialStateProperty.resolveWith(
                              (states) => Colors.grey.shade200),
                          columns: const <DataColumn>[
                            DataColumn(
                              label: Text(
                                'Token',
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Vehicle number',
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Customer Name',
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Quantity',
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Status',
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Action',
                              ),
                            ),
                          ],
                          rows: <DataRow>[
                            for (int i = 0;
                                i < displayedDataCell.length;
                                i += 6)
                              DataRow(
                                  // onSelectChanged: (value) {
                                  //   //print();
                                  // },
                                  cells: [
                                    displayedDataCell[i],
                                    displayedDataCell[i + 1],
                                    displayedDataCell[i + 2],
                                    displayedDataCell[i + 3],
                                    displayedDataCell[i + 4],
                                    displayedDataCell[i + 5],
                                  ])
                          ],
                        );
                      }
                      return Center(child: const CircularProgressIndicator());
                    },
                  ),
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