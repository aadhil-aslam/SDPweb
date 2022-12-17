import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class RequestAction extends StatefulWidget {
  const RequestAction({Key? key}) : super(key: key);

  @override
  State<RequestAction> createState() => _RequestActionState();
}

class _RequestActionState extends State<RequestAction> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        // inside the <> you enter the type of your stream
        stream: FirebaseFirestore.instance.collection('Requests').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Text(
                          snapshot.data!.docs[index].get('customerName'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Text(
                            snapshot.data!.docs[index].get('Status'),
                          ),
                        ),

                  //snapshot.data!.docs[index].get('Status').toString().startsWith("A") ?
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Row(
                            children: [
                              TextButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(Colors.green)),
                                  onPressed: () {
                                    print(snapshot.data!.docs[index].get('id'));
                                    FirebaseFirestore.instance
                                        .collection('Requests')
                                        .doc((snapshot.data!.docs[index].get('id')))
                                        .update({'Status': 'Accepted'});
                                  },
                                  child: Text(
                                    "Accept",
                                    style: TextStyle(color: Colors.white),
                                  )),
                              SizedBox(
                                width: 15,
                              ),
                              TextButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(Colors.red)),
                                  onPressed: () {
                                    print(snapshot.data!.docs[index].get('id'));
                                    FirebaseFirestore.instance
                                        .collection('Requests')
                                        .doc((snapshot.data!.docs[index].get('id')))
                                        .update({'Status': 'Canceled'});

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
                                    style: TextStyle(color: Colors.white),
                                  ))
                            ],
                          ),
                        )
                            //: SizedBox.shrink(),
                      ],
                    ),
                  );
                },
              ),
            );
          }
          if (snapshot.hasError) {
            return const Text('Error');
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
