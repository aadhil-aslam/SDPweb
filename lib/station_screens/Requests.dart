import 'dart:convert';
import 'dart:math';
import 'package:f_datetimerangepicker/f_datetimerangepicker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Requests extends StatefulWidget {
  const Requests({Key? key}) : super(key: key);

  @override
  State<Requests> createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {

  // sendRequest() {
  //   return showDialog(
  //       context: context,
  //       builder: (parm) {
  //         return Container(
  //           color: Colors.transparent,
  //           child: Container(
  //             decoration: BoxDecoration(
  //                 color: Colors.white,
  //                 borderRadius: BorderRadius.circular(8),
  //                 boxShadow: [
  //                   BoxShadow(
  //                       color: Colors.grey,
  //                       offset: Offset(0, 3),
  //                       blurRadius: 24)
  //                 ]),
  //             height: 430,
  //             width: 350,
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 SizedBox(
  //                   height: 30,
  //                 ),
  //                 Text(
  //                   "LOGIN",
  //                   style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
  //                 ),
  //                 SizedBox(
  //                   height: 30,
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.symmetric(horizontal: 20),
  //                   child: Text('Email Can\'t Be Empty'
  //                       )),
  //
  //                 SizedBox(
  //                   height: 20,
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.symmetric(horizontal: 20),
  //                   child: TextField(
  //                     obscureText: true,
  //                     decoration: InputDecoration(
  //                       prefixIcon: Icon(Icons.lock_open),
  //                       filled: true,
  //                       fillColor:  Colors.grey[200],
  //                       //isDense: true,
  //                       labelText: 'password',
  //                     ),
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   height: 15,
  //                 ),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Text("Forgot password?",
  //                         style: TextStyle(
  //                           fontSize: 13,
  //                           color: Colors.grey,
  //                         )),
  //                   ],
  //                 ),
  //                 SizedBox(
  //                   height: 30,
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.symmetric(horizontal: 20),
  //                   child: Container(
  //                     height: 40,
  //                     decoration: BoxDecoration(color: Colors.red.shade700),
  //                     child: TextButton(
  //                       onPressed: () {
  //                         setState(() {
  //                         });
  //                         print("click");
  //                       },
  //                       child: Padding(
  //                         padding: const EdgeInsets.symmetric(vertical: 4),
  //                         child: Row(
  //                           mainAxisAlignment: MainAxisAlignment.center,
  //                           children: [
  //                             Text("Login",
  //                                 style: TextStyle(
  //                                   fontSize: 14,
  //                                   color: Colors.white,
  //                                   fontWeight: FontWeight.bold,
  //                                 )),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   height: 30,
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.only(right: 20),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Text(
  //                         "Do not have an account? ",
  //                         style: TextStyle(fontSize: 14, color: Colors.grey),
  //                       ),
  //                       GestureDetector(
  //                           onTap: () {
  //                             // Navigator.push(
  //                             //     context,
  //                             //     PageTransition(
  //                             //         type: PageTransitionType.fade,
  //                             //         child: RegistrationPage()));
  //                           },
  //                           child: Text("Sign up here. ",
  //                               style: TextStyle(
  //                                 fontSize: 14,
  //                                 color: Colors.indigo,
  //                               ))),
  //                     ],
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   height: 10,
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }
  //
  // num totalRequested = 0;
  //
  // Future getTotal() async {
  //   _fetchID();
  //   print(StId);
  //   num sum = 0;
  //   FirebaseFirestore.instance
  //       .collection('Requests')
  //       .where('stationID', isEqualTo: "PF001")
  //       .where('Ordered', isEqualTo: false)
  //       .where('Status', isEqualTo: "Pending")
  //       .get()
  //       .then(
  //     (querySnapshot) {
  //       for (var result in querySnapshot.docs) {
  //         sum = sum + int.parse(result.data()['requested amount']);
  //         setState(() {
  //           totalRequested = sum;
  //         });
  //       }
  //       print('total : $totalRequested');
  //     },
  //   );
  // }

  @override
  void initState() {
    //getTotal();
    _fetchID();
    super.initState();
  }

  String ResceduleDate = "";
  String DateAndTime = "";
  String DeviceToken = "A";
  String id = "";
  String Token = "";

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

  _fetchToken(id, Token, dateAndTime) async {
    await FirebaseFirestore.instance
        .collection("User")
        .doc(id)
        .get()
        .then((ds) {
      DeviceToken = ds.data()!['DeviceToken'];
      setState(() {
        DeviceToken = ds.data()!['DeviceToken'];
      });
      sendPushMessage(DeviceToken, Token, dateAndTime);
      //print("DeviceToken: " + DeviceToken);
    }).catchError((e) {});
  }

  sendPushMessage(DeviceToken, Token, dateAndTime) async {
    //print("DeviceToken: " + DeviceToken);
    //print("Message");
    try {
      print("DeviceToken: " + DeviceToken);
      print("Token: " + Token);
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAMjTO-YI:APA91bGSDjI9Dm4F6s_oCDbgerFLoYiVIajHnJxy_JU9N27KdaeGrlepOWOjeRNuzDdTpb8VulMZYODYfukOloSEQJsbhpSn9cEg_65DbAYTYEEJlzELwIW6sOKalgxc6bUKAtSavUL7',
        },
        body: jsonEncode(
          <String, dynamic>{
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'body': Token,
              'title': "Your Token Number",
            },
            'notification': <String, dynamic>{
              'title': "Your fuel request accepted",
              'body':
                  "Token Number: " + Token + "\nScheduled time: " + dateAndTime,
              'android_channel_id': "channel"
            },
            'to': DeviceToken,
          },
        ),
      );
    } catch (e) {
      print("error message");
    }
  }

  _fetchTokenCancelled(id, dateAndTime) async {
    await FirebaseFirestore.instance
        .collection("User")
        .doc(id)
        .get()
        .then((ds) {
      DeviceToken = ds.data()!['DeviceToken'];
      setState(() {
        DeviceToken = ds.data()!['DeviceToken'];
      });
      sendCancelledMessage(DeviceToken, dateAndTime);
      //print("DeviceToken: " + DeviceToken);
    }).catchError((e) {});
  }

  sendCancelledMessage(DeviceToken, dateAndTime) async {
    //print("DeviceToken: " + DeviceToken);
    //print("Message");
    try {
      print("DeviceToken: " + DeviceToken);
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAMjTO-YI:APA91bGSDjI9Dm4F6s_oCDbgerFLoYiVIajHnJxy_JU9N27KdaeGrlepOWOjeRNuzDdTpb8VulMZYODYfukOloSEQJsbhpSn9cEg_65DbAYTYEEJlzELwIW6sOKalgxc6bUKAtSavUL7',
        },
        body: jsonEncode(
          <String, dynamic>{
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'body': dateAndTime,
              'title': "Request cancelled",
            },
            'notification': <String, dynamic>{
              'title': "Your fuel request has been cancelled",
              'body': "Resceduled time: " + dateAndTime,
              'android_channel_id': "channel"
            },
            'to': DeviceToken,
          },
        ),
      );
    } catch (e) {
      print("error message");
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
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Customer Requests",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28.0,
                        ),
                      ),
                      SizedBox(width: 500,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
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
                          // SizedBox(
                          //   width: 40.0,
                          // ),
                          // DropdownButton(
                          //     hint: Text("Filter by"),
                          //     items: [
                          //       DropdownMenuItem(
                          //         value: "Date",
                          //         child: Text("Date"),
                          //       ),
                          //       DropdownMenuItem(
                          //         value: "Reviews",
                          //         child: Text("Reviews"),
                          //       ),
                          //       DropdownMenuItem(
                          //         value: "Branches",
                          //         child: Text("Branches"),
                          //       ),
                          //     ],
                          //     onChanged: (value) {}),
                          // SizedBox(
                          //   width: 20.0,
                          // ),
                          // DropdownButton(
                          //     hint: Text("Order by"),
                          //     items: [
                          //       DropdownMenuItem(
                          //         value: "Date",
                          //         child: Text("Date"),
                          //       ),
                          //       DropdownMenuItem(
                          //         value: "Reviews",
                          //         child: Text("Reviews"),
                          //       ),
                          //       DropdownMenuItem(
                          //         value: "Branches",
                          //         child: Text("Branches"),
                          //       ),
                          //     ],
                          //     onChanged: (value) {}),
                        ],
                      ),
                    ],
                  ),
                ),
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
                        .collection('Requests')
                        .where('stationID', isEqualTo: StId)
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
                              Text(snapshot.data!.docs[i].get('Requested time')
                                  //item['customerName'].toString(),
                                  ),
                            ),
                          );
                          displayedDataCell.add(
                            DataCell(
                              Text(snapshot.data!.docs[i].get('fuelType')
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
                                          ? Colors.grey
                                          : accepted
                                              ? Colors.green
                                              : Colors.black

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
                                              /// Generate token
                                              Random random = new Random();
                                              int randomNumber =
                                                  random.nextInt(999999) +
                                                      100000;

                                              id = snapshot.data!.docs[i]
                                                  .get('customerId');

                                              print("customerId: " + id);

                                              /// DatePicker
                                              DatePicker.showDateTimePicker(
                                                  context,
                                                  showTitleActions: true,
                                                  minTime: DateTime.now(),
                                                  maxTime: DateTime.now().add(
                                                      const Duration(days: 7)),
                                                  onChanged: (date) {
                                                print(
                                                    'change $date in time zone ' +
                                                        date.timeZoneOffset
                                                            .inHours
                                                            .toString());
                                              }, onConfirm: (date) {
                                                print('confirm $date');

                                                var startFormat = DateFormat(
                                                    'MM/dd/yyyy');
                                                var Date =
                                                startFormat.format(date);
                                                print(Date);

                                                var dateFormat = DateFormat(
                                                    'HH:mm');
                                                var startDate =
                                                    dateFormat.format(date);
                                                print(startDate);

                                                var eDate = date.add(
                                                    const Duration(hours: 3));

                                                var endFormat =
                                                    DateFormat('HH:mm');
                                                var endDate =
                                                    endFormat.format(eDate);
                                                print(endDate);

                                                /// update request
                                                FirebaseFirestore.instance
                                                    .collection('Requests')
                                                    .doc((snapshot.data!.docs[i]
                                                        .get('id')))
                                                    .update({
                                                  'Status': 'Accepted',
                                                  "Token":
                                                      randomNumber.toString(),
                                                  "DateAndTime":
                                                      "$startDate - $endDate",
                                                  "TokenDate":
                                                  "$Date",

                                                });

                                                /// update user
                                                FirebaseFirestore.instance
                                                    .collection('User')
                                                    .doc((snapshot.data!.docs[i]
                                                        .get('customerId')))
                                                    .update({
                                                  "Token":
                                                      randomNumber.toString(),
                                                  "DateAndTime":
                                                      "$startDate - $endDate",
                                                  "TokenDate":
                                                  "$Date",
                                                });

                                                setState(() {
                                                  DateAndTime =
                                                      "$startDate - $endDate";
                                                });

                                                _fetchToken(
                                                    id, Token, DateAndTime);
                                              }, currentTime: DateTime.now());

                                              setState(() {
                                                Token = randomNumber.toString();
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
                                              id = snapshot.data!.docs[i]
                                                  .get('customerId');

                                              DatePicker.showDateTimePicker(
                                                  context,
                                                  showTitleActions: true,
                                                  minTime: DateTime.now(),
                                                  maxTime: DateTime.now().add(
                                                      const Duration(days: 7)),
                                                  onChanged: (date) {
                                                print(
                                                    'change $date in time zone ' +
                                                        date.timeZoneOffset
                                                            .inHours
                                                            .toString());
                                              }, onConfirm: (date) {
                                                var dateFormat =
                                                    DateFormat('MM/dd/yyyy');
                                                var ResceduledDate =
                                                    dateFormat.format(date);
                                                print(ResceduledDate);

                                                /// update request
                                                FirebaseFirestore.instance
                                                    .collection('Requests')
                                                    .doc((snapshot.data!.docs[i]
                                                        .get('id')))
                                                    .update({
                                                  'Status': 'Cancelled',
                                                  "Rescheduled Date":
                                                      "$ResceduledDate",
                                                });

                                                /// update user
                                                FirebaseFirestore.instance
                                                    .collection('User')
                                                    .doc((snapshot.data!.docs[i]
                                                        .get('customerId')))
                                                    .update({
                                                  "Requested": "No",
                                                  "requested amount": "null",
                                                  "Rescheduled Date":
                                                      "$ResceduledDate",
                                                });
                                                setState(() {
                                                  ResceduleDate =
                                                      "$ResceduledDate";
                                                });

                                                _fetchTokenCancelled(
                                                    id, ResceduleDate);
                                              }, currentTime: DateTime.now());
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
                        }

                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: DataTable(
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
                                    'Request Date',
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Fuel type',
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
                                    i += 8)
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
                                        displayedDataCell[i + 7],
                                      ])
                              ],
                            ),
                          ),
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
