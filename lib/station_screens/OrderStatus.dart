import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:meta/meta.dart';

class OrderStatus extends StatefulWidget {
  const OrderStatus({Key? key}) : super(key: key);

  @override
  State<OrderStatus> createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus> {
  @override
  void initState() {
    //getTotal();
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
        // print(Name);
        // print(StId);
        // print(StName);
      }).catchError((e) {});
    } else {
      Name = '';
    }
  }

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
                  const Text(
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
                        child: const TextField(
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
                      const SizedBox(
                        width: 40.0,
                      ),
                      DropdownButton(
                          hint: const Text("Filter by"),
                          items: const [
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
                      const SizedBox(
                        width: 20.0,
                      ),
                      DropdownButton(
                          hint: const Text("Order by"),
                          items: const [
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
              const SizedBox(
                height: 40.0,
              ),
              //Now let's add the Table
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Station Orders')
                        .where('Station ID', isEqualTo: StId)
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
                          displayedDataCell.add(DataCell(
                            Text(
                              snapshot.data!.docs[i].get('Status'),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: canceled
                                      ? Colors.red
                                      : pending
                                      ? Colors.grey
                                      : accepted
                                      ? Colors.green
                                      : Colors.black
                                //  item['Status'].toString(), style: TextStyle(fontWeight: FontWeight.bold, color: accepted ? Colors.green : Colors.red),
                              ),
                            ),
                          ));
                        }

                        return DataTable(
                          headingRowColor:
                          MaterialStateProperty.resolveWith(
                                  (states) => Colors.grey.shade200),
                          columns: const <DataColumn>[
                            DataColumn(label: Text("Order Number")),
                            DataColumn(label: Text("Order date")),
                            DataColumn(label: Text("Type of Fuel")),
                            DataColumn(label: Text("Quantity")),
                            DataColumn(label: Text("Total cost")),
                            DataColumn(label: Text("Status")),
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
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

