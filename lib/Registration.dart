import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:web/station_screens/auth.dart';

import 'Login.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool _validateEmail = false;
  bool _validatePW = false;
  bool _validateUN = false;
  bool _validateSId = false;
  bool _validateStName = false;

  FirebaseAuth auth = FirebaseAuth.instance;

  String? errorMessage = "";

  bool isLogin = true;

  final db = FirebaseFirestore.instance;

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Humm ? $errorMessage');
  }

  _showSuccessSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red[700],
      ),
    );
  }

  var _usernameController = TextEditingController();
  var _stationIDController = TextEditingController();
  var _stationNameController = TextEditingController();
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      FirebaseFirestore.instance
          .collection("StationUser")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "username": _usernameController.text,
        "email": _emailController.text,
        "StationID": _stationIDController.text,
        "StationName": _stationNameController.text,
      });
      Navigator.push(context,
          PageTransition(type: PageTransitionType.fade, child: LoginPage()));
    } on FirebaseAuthException catch (e) {
      setState(() {
        _showSuccessSnackbar(e.toString());
        errorMessage = e.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient:
              LinearGradient(colors: [Colors.orange, Colors.red.shade700])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            color: Colors.red,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0, 3),
                        blurRadius: 24)
                  ]),
              height: 650,
              width: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Register",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextField(
                      //enabled: quota ? true : false,
                        controller: _stationNameController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.local_gas_station),
                          filled: true,
                          fillColor: Colors.grey[200],
                          //isDense: true,
                          labelText: 'station name',
                          border: InputBorder.none,
                          errorText:
                          _validateStName ? 'Station Name Can\'t Be Empty' : null,
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextField(
                        //enabled: quota ? true : false,
                        controller: _stationIDController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.local_gas_station),
                          filled: true,
                          fillColor: Colors.grey[200],
                          //isDense: true,
                          labelText: 'station ID',
                          border: InputBorder.none,
                          errorText:
                              _validateSId ? 'Station ID Can\'t Be Empty' : null,
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextField(
                        //enabled: quota ? true : false,
                        controller: _usernameController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person_outline),
                          filled: true,
                          fillColor: Colors.grey[200],
                          //isDense: true,
                          labelText: 'username',
                          border: InputBorder.none,
                          errorText:
                              _validateUN ? 'Username Can\'t Be Empty' : null,
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextField(
                        //enabled: quota ? true : false,
                        controller: _emailController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.mail_outline),
                          filled: true,
                          fillColor: Colors.grey[200],
                          //isDense: true,
                          labelText: 'email',
                          border: InputBorder.none,
                          errorText:
                              _validateEmail ? 'Email Can\'t Be Empty' : null,
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextField(
                      obscureText: true,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_open),
                        filled: true,
                        fillColor: Colors.grey[200],
                        //isDense: true,
                        labelText: 'password',
                        border: InputBorder.none,
                        errorText:
                            _validatePW ? 'Password Can\'t Be Empty' : null,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 20),
                  //   child: Container(
                  //     decoration: BoxDecoration(color: Colors.red.shade700),
                  //     child: TextButton(
                  //       onPressed: () {
                  //         createUserWithEmailAndPassword();
                  //       },
                  //       child: Padding(
                  //         padding: const EdgeInsets.symmetric(vertical: 4),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: [
                  //             Text(
                  //               "Register",
                  //               style: TextStyle(
                  //                   fontSize: 22,
                  //                   color: Colors.white,
                  //                   fontWeight: FontWeight.bold),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.red[700],
                              textStyle: const TextStyle(fontSize: 15)),
                          onPressed: () {
                            setState(() {
                              _emailController.text.isEmpty
                                  ? _validateEmail = true
                                  : _validateEmail = false;
                              _passwordController.text.isEmpty
                                  ? _validatePW = true
                                  : _validatePW = false;
                              _usernameController.text.isEmpty
                                  ? _validateUN = true
                                  : _validateUN = false;
                              _stationIDController.text.isEmpty
                                  ? _validateSId = true
                                  : _validateSId = false;
                              _stationIDController.text.isEmpty
                                  ? _validateStName = true
                                  : _validateStName = false;

                            });
                            if (_validatePW == false &&
                                _validateEmail == false &&
                                _validateSId == false &&
                                _validateUN == false &&
                                _validateStName == false) {
                              createUserWithEmailAndPassword();
                            }
                          },
                          child: const Text('Sign up')),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account? ",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            )),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    child: LoginPage()));
                          },
                          child: Text("Sign in here.. ",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.indigo,
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
