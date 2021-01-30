//////////////////// -------------SignUp-----------////////////////

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'package:mobile_project/provider/userAddNotifier.dart';
import 'package:mobile_project/screens/products_overview_screen.dart';
import 'package:provider/provider.dart';

class SignUpFromStatless extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SignUpForm(),
    );
  }
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpForm createState() => _SignUpForm();
}

class _SignUpForm extends State<SignUpForm> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  TextEditingController _firstName = TextEditingController();
  TextEditingController _lastName = TextEditingController();
  TextEditingController _username = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confrimPassword = TextEditingController();
  TextEditingController _socialID = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();

  /*String firstName;
  String lastName;
  String username;
  String email;
  String password;
  String socialID;
  String phoneNumber;*/
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
      performSignup();
    }
  }

  void performSignup() {
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProductsOverviewScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget form = Container(
      padding: const EdgeInsets.all(32),
      child: SingleChildScrollView(
        child: new Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ///######################################
              Text("First Name"),
              TextFormField(
                controller: _firstName,
                decoration: const InputDecoration(
                  labelText: "First Name",
                  border: OutlineInputBorder(),
                  focusColor: Colors.black,
                  hintText: "FirstName",
                  counterText: '0 characters',
                  //errorText: 'Error Text',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  } else if (value.length < 3) {
                    return 'first name too short';
                  } else if (!RegExp('^[a-zA-Z]').hasMatch(value)) {
                    return 'Enter Valid Username';
                  }
                  return null;
                },
                onSaved: (_firstname) => _firstName = _firstName,
              ),
              //##########################################
              Text("Last Name"),
              TextFormField(
                controller: _lastName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "LastName",
                  counterText: '0 characters',
                  //errorText: 'Error Text',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  } else if (value.length < 4) {
                    return 'last name too short';
                  } else if (!RegExp('^[a-zA-Z]').hasMatch(value)) {
                    return 'Enter Valid Username';
                  }
                  return null;
                },
                onSaved: (lastName) => lastName = lastName,
              ),
              Text("Username"),
              TextFormField(
                controller: _username,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "username",
                  counterText: '0 characters',
                  //errorText: 'Error Text',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  } else if (value.length < 4) {
                    return 'last name too short';
                  } else if (!RegExp('^[a-zA-Z-]').hasMatch(value)) {
                    return 'Enter Valid Username';
                  }
                  return null;
                },
                onSaved: (username) => _username = _username,
              ),
              //####################################
              Text("Email"),
              TextFormField(
                controller: _email,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Email",
                  counterText: '0 characters',
                  //errorText: 'Error Text',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  } else if (!RegExp('^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]')
                      .hasMatch(value)) {
                    return 'Enter Valid Email';
                  }
                  return null;
                },
                onSaved: (email) => _email = _email,
              ),
              Text("Password"),
              TextFormField(
                controller: _password,
                obscureText: true,
                obscuringCharacter: "*",
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Password",
                  counterText: '0 characters',

                  //errorText: 'Error Text',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  } else if (value.length < 6) {
                    return 'Password is not less than 6 characters';
                  } else if (!RegExp('^[a-zA-Z0-9]').hasMatch(value)) {
                    return 'Enter Valid Email';
                  }
                  return null;
                },
                onSaved: (_password) => _password = _password,
              ),
              Text("Confirm Password"),
              TextFormField(
                controller: _confrimPassword,
                obscureText: true,
                obscuringCharacter: "*",
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Confrim Password",
                  counterText: '0 characters',
                  //errorText: 'Error Text',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  } else if (value.length < 6) {
                    return 'Confirm Password too short';
                  } else if (_password.text != _confrimPassword.text) {
                    return 'Please password does not match';
                  }
                  return null;
                },
              ),
              Text("Socail ID"),
              TextFormField(
                controller: _socialID,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Social ID",
                  counterText: '0 characters',
                  //errorText: 'Error Text',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  } else if (value.length != 14) {
                    return 'Social ID must be 14 character';
                  }
                  return null;
                },
                onSaved: (_socialID) {
                  _socialID = _socialID;
                },
              ),
              Text("Phone Number"),
              TextFormField(
                controller: _phoneNumber,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "PhoneNumber",
                  counterText: '0 characters',
                  //errorText: 'Error Text',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  } else if (value.length != 11) {
                    return 'Phone number should be 11 number';
                  }

                  return null;
                },
                onSaved: (phoneNumber) {
                  phoneNumber = phoneNumber;
                },
              ),
              RaisedButton(
                onPressed: () async {
                  if (_firstName.text.isEmpty || _lastName.text.isEmpty) {
                    return;
                  }
                  /*UserAddNotifer addNotifer = UserAddNotifer();
                  addNotifer.addUser(firstName, lastName, username, email,
                      password, socialID, phoneNumber);*/
                  await Provider.of<UserAddNotifer>(context, listen: false)
                      .addUser(
                    _firstName.text,
                    _lastName.text,
                    _username.text,
                    _email.text,
                    _password.text,
                    _socialID.text,
                    _phoneNumber.text,
                  );
                  _submit();
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                highlightElevation: 0,
                color: Colors.indigo[100],
                padding: EdgeInsets.only(left: 130.0, right: 130.0),
                child: Column(
                  children: <Widget>[
                    Text("submit"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    return MaterialApp(
      title: 'SignUp',
      //theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo[200],
          centerTitle: true,
          title: Text("Signup"),
        ),
        body: form,
      ),
    );
  }
}
