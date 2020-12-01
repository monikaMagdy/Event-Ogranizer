<<<<<<< HEAD
import 'package:mobile_project/signup.dart';
import 'join_event.dart';
import 'package:flutter/material.dart';
import 'package:mobile_project/Animation.dart';
=======
import 'package:flutter/material.dart';
import 'package:mobile_project/create_event.dart';
>>>>>>> 451abde389b58a8ad3046e9a10e82f09729157cc

class LoginForm extends StatefulWidget {
  @override
  _LoginForm createState() => _LoginForm();
}

class _LoginForm extends State<LoginForm> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  String email;
  String password;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      performLogin();
    }
  }

  void performLogin() {
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => JoinEvent()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Stack(
                children: <Widget>[
                  FadeAnimation(
                    1,
                    Positioned(
                      left: 30,
                      width: 80,
                      height: 200,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/light-1.png'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  FadeAnimation(
                    1.3,
                    Positioned(
                      left: 140,
                      width: 80,
                      height: 150,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/light-2.png'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  FadeAnimation(
                    1.5,
                    Positioned(
                      right: 40,
                      top: 40,
                      width: 80,
                      height: 150,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/clock.png'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  FadeAnimation(
                      1.6,
                      Positioned(
                        child: Container(
                          margin: EdgeInsets.only(top: 50),
                          child: Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: new Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Email"),
                      TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Email",
                          counterText: '0 characters',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          } else if (!RegExp(
                                  '^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]')
                              .hasMatch(value)) {
                            return 'Enter Valid Email';
                          }
                          return null;
                        },
                        onSaved: (_email) {
                          email = _email;
                        },
                      ),
                      Text("Password"),
                      TextFormField(
                        obscureText: true,
                        obscuringCharacter: "*",
                        decoration: InputDecoration(
                            focusColor: Colors.white,
                            border: OutlineInputBorder(),
                            hintText: 'Enter Password',
                            counterText: '0 characters'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          } else if (value.length < 6) {
                            return 'Social ID must be 6 character';
                          }
                          return null;
                        },
                        onSaved: (_password) {
                          password = _password;
                        },
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                            ),
                            RaisedButton(
                              onPressed: () {
                                _submit();
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                              color: Colors.blueGrey,
                              padding: EdgeInsets.only(
                                left: 140.0,
                                right: 140.0,
                              ),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "login",
                                  ),
                                ],
                              ),
                            ),
                            RaisedButton(
                              onPressed: () {
                                setState(() {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUpForm()),
                                  );
                                });
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              highlightElevation: 0,
                              color: Colors.blueGrey,
                              padding:
                                  EdgeInsets.only(left: 130.0, right: 130.0),
                              child: Column(
                                children: <Widget>[
                                  Text("Signup"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
