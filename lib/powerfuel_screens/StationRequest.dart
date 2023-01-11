import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class FuelStationRequest extends StatefulWidget {
  const FuelStationRequest({Key? key}) : super(key: key);

  @override
  State<FuelStationRequest> createState() => _FuelStationRequestState();
}

class _FuelStationRequestState extends State<FuelStationRequest> {
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
                    "Fuel station Request",
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
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('Station Orders')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return const Text('Something went wrong');
                          }
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: const Text("Loading"));
                          }
                          if (snapshot.hasData) {
                            //print(snapshot.data!.docs);
                            List<DataCell> displayedDataCell = [];

                            //for (var item in snapshot.data!.docs)
                            for (int i = 0; i < snapshot.data!.docs.length; i++) {
                              bool pending =
                                  snapshot.data!.docs[i].get('Status').toString() ==
                                      "Pending";

                              bool accepted =
                                  snapshot.data!.docs[i].get('Status').toString() ==
                                      "Accepted";

                              bool canceled =
                                  snapshot.data!.docs[i].get('Status').toString() ==
                                      "Cancelled";

                              bool completed =
                                  snapshot.data!.docs[i].get('Status').toString() ==
                                      "Completed";

                              displayedDataCell.add(
                                DataCell(
                                  Text(snapshot.data!.docs[i].get('id')
                                    //item['Token'].toString(),
                                  ),
                                ),
                              );
                              displayedDataCell.add(
                                DataCell(
                                  Text(snapshot.data!.docs[i].get('Station Name')
                                    //item['Token'].toString(),
                                  ),
                                ),
                              );
                              displayedDataCell.add(
                                DataCell(
                                  Text(snapshot.data!.docs[i].get('Order date')

                                    //item['Vehicle number'].toString(),
                                  ),
                                ),
                              );
                              displayedDataCell.add(
                                DataCell(
                                  Text(snapshot.data!.docs[i].get('Fuel type')

                                    //item['customerName'].toString(),
                                  ),
                                ),
                              );
                              displayedDataCell.add(
                                DataCell(
                                  Text(snapshot.data!.docs[i].get('Fuel amount')
                                    //item['customerName'].toString(),
                                  ),
                                ),
                              );
                              displayedDataCell.add(
                                DataCell(
                                  Text(snapshot.data!.docs[i].get('Cost')
                                    //item['customerName'].toString(),
                                  ),
                                ),
                              );
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
                                              /// update request
                                              FirebaseFirestore.instance
                                                  .collection('Station Orders')
                                                  .doc((snapshot.data!.docs[i]
                                                  .get('id')))
                                                  .update({
                                                'Status': 'Accepted',
                                              });
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

                                            /// update request
                                            FirebaseFirestore.instance
                                                .collection('Station Orders')
                                                .doc((snapshot.data!.docs[i]
                                                .get('id')))
                                                .update({
                                              'Status': 'Cancelled',
                                            });
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
                                      : accepted
                                      ? TextButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.green)),
                                      onPressed: () {},
                                      child: Text(
                                        "Accepted",
                                        style: TextStyle(
                                            color: Colors.white),
                                      ))
                                      : TextButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.black)),
                                      onPressed: () {},
                                      child: Text(
                                        "Completed",
                                        style: TextStyle(
                                            color: Colors.white),
                                      )),
                                ),
                              );
                              // displayedDataCell.add(DataCell(
                              //   Text(
                              //     snapshot.data!.docs[i].get('Status'),
                              //     style: TextStyle(
                              //         fontWeight: FontWeight.bold,
                              //         color: canceled
                              //             ? Colors.red
                              //             : pending
                              //             ? Colors.grey
                              //             : accepted
                              //             ? Colors.green
                              //             : Colors.black
                              //       //  item['Status'].toString(), style: TextStyle(fontWeight: FontWeight.bold, color: accepted ? Colors.green : Colors.red),
                              //     ),
                              //   ),
                              // ));
                            }

                            return DataTable(
                              headingRowColor:
                              MaterialStateProperty.resolveWith(
                                      (states) => Colors.grey.shade200),
                              columns: const <DataColumn>[
                                DataColumn(label: Text("Request Id")),
                                DataColumn(label: Text("Station Name")),
                                DataColumn(label: Text("Request date")),
                                DataColumn(label: Text("Type of Fuel")),
                                DataColumn(label: Text("Quantity")),
                                DataColumn(label: Text("Total cost")),
                                DataColumn(label: Text("Action")),
                              ],
                              rows: <DataRow>[
                                for (int i = 0;
                                i < displayedDataCell.length;
                                i += 7)
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
                                        displayedDataCell[i + 6],
                                      ])
                              ],
                            );
                          }
                          return Center(child: const CircularProgressIndicator());
                        },
                      ),
                    ),
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
