import 'package:cloud_firestore/cloud_firestore.dart';
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
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('StationUser')
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

                          displayedDataCell.add(
                            DataCell(
                              Text(snapshot.data!.docs[i].get('StationID')
                                //item['Token'].toStringΩ
                              ),
                            ),
                          );
                          displayedDataCell.add(
                            DataCell(
                              Text(snapshot.data!.docs[i].get('StationName')
                                //item['Vehicle number'].toString(),
                              ),
                            ),
                          );
                          displayedDataCell.add(
                            DataCell(
                              Text(snapshot.data!.docs[i].get('StationAddress')
                                //item['Token'].toString(),
                              ),
                            ),
                          );
                          displayedDataCell.add(
                            DataCell(
                              Text(snapshot.data!.docs[i].get('username')
                                //item['customerName'].toString(),
                              ),
                            ),
                          );
                          displayedDataCell.add(
                            DataCell(
                              Text(snapshot.data!.docs[i].get('email')
                                //item['customerName'].toString(),
                              ),
                            ),
                          );
                        }

                        return DataTable(
                          headingRowColor:
                          MaterialStateProperty.resolveWith(
                                  (states) => Colors.grey.shade200),
                          columns: const <DataColumn>[
                            DataColumn(label: Text("Station ID")),
                            DataColumn(label: Text("Station Name")),
                            DataColumn(label: Text("Station Address")),
                            DataColumn(label: Text("User Name")),
                            DataColumn(label: Text("Email")),
                          ],
                          rows: <DataRow>[
                            for (int i = 0;
                            i < displayedDataCell.length;
                            i += 5)
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
