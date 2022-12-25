import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:web/station_screens/auth.dart';
import 'package:web/station_screens/dashboard.dart';

import 'Registration.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  _showSuccessSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red[700],
      ),
    );
  }

  bool _validateEmail = false;
  bool _validatePW = false;

  bool loggedIn = false;

  String? errorMessage = "";

  bool isLogin = true;

  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Humm ? $errorMessage');
  }

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      setState(() {
        loggedIn = true;
        print('loggedIn');
      });
      print('pass');
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.fade,
              child: DashboardScreen()));
    } on FirebaseAuthException catch (e) {
      print('fail');
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
            color: Colors.transparent,
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
              height: 430,
              width: 350,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Login",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      //enabled: quota ? true : false,
                        controller: _emailController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.mail_outline),
                          filled: true,
                          fillColor:  Colors.grey[200],
                          //isDense: true,
                          labelText: 'email',
                          errorText:
                          _validateEmail ? 'Email Can\'t Be Empty' : null,
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      obscureText: true,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_open),
                        filled: true,
                        fillColor:  Colors.grey[200],
                        //isDense: true,
                        labelText: 'password',
                        errorText:
                        _validatePW ? 'Password Can\'t Be Empty' : null,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Forgot password?",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(color: Colors.red.shade700),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            _emailController.text.isEmpty
                                ? _validateEmail = true
                                : _validateEmail = false;
                            _passwordController.text.isEmpty
                                ? _validatePW = true
                                : _validatePW = false;
                          });
                          print("click");
                          if (_validatePW == false &&
                              _validateEmail == false) {
                            // FirebaseAuth.instance.signInWithEmailAndPassword(
                            //     email: _emailController.text, password: _passwordController.text);
                            signInWithEmailAndPassword();
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Login",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Do not have an account? ",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: RegistrationPage()));
                            },
                            child: Text("Sign up here. ",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.indigo,
                                ))),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
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
