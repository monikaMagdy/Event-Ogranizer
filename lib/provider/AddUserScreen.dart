//////////////////// -------------SignUp-----------////////////////

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../models/userModel.dart';
import 'package:mobile_project/provider/userAddNotifier.dart';
import 'package:mobile_project/screens/products_overview_screen.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SignUpForm extends StatefulWidget {
  final String operation;
  User user;
  // ignore: sort_constructors_first
  SignUpForm({this.operation, this.user});
  @override
  _SignUpForm createState() => _SignUpForm();
}

class _SignUpForm extends State<SignUpForm> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confrimPassword = TextEditingController();
  final _socialID = TextEditingController();
  final _phoneNumber = TextEditingController();

  /*String firstName;
  String lastName;
  String username;
  String email;
  String password;  
  String socialID;  
  String phoneNumber;*/
  @override
  void initState() {
    if (widget.operation == 'Edit') {
      _firstName.text = widget.user.firstName;
      _lastName.text = widget.user.lastName;
      _username.text = widget.user.username;
      _email.text = widget.user.email;
      _password.text = widget.user.password;
      _socialID.text = widget.user.socialID;
      _phoneNumber.text = widget.user.phoneNumber;
    }
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
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ///######################################
                Text('First Name'),
                TextFormField(
                  autofocus: true,
                  controller: _firstName,
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                    border: OutlineInputBorder(),
                    focusColor: Colors.black,
                    hintText: 'FirstName',
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
                  //onSaved: (_firstname) => firstName = _firstName,
                ),
                //##########################################
                Text('Last Name'),
                TextFormField(
                  autofocus: true,
                  controller: _lastName,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'LastName',
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
                Text('Username'),
                TextFormField(
                  autofocus: true,
                  controller: _username,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'username',
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
                  // onSaved: (username) => _username = _username,
                ),
                //####################################
                Text('Email'),
                TextFormField(
                  autofocus: true,
                  controller: _email,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Email',
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
                  // onSaved: (email) => _email = _email,
                ),
                Text('Password'),
                TextFormField(
                  autofocus: true,
                  controller: _password,
                  obscureText: true,
                  obscuringCharacter: '*',
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Password',
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
                Text('Confirm Password'),
                TextFormField(
                  autofocus: true,
                  controller: _confrimPassword,
                  obscureText: true,
                  obscuringCharacter: '*',
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Confrim Password',
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
                Text('Socail ID'),
                TextFormField(
                  autofocus: true,
                  controller: _socialID,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Social ID',
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
                Text('Phone Number'),
                TextFormField(
                  autofocus: true,
                  controller: _phoneNumber,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'PhoneNumber',
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
                FlatButton(
                  onPressed: () async {
                    if (widget.operation == 'Add') {
                      await Provider.of<UserAddNotifer>(context, listen: false)
                          .addUser(User(
                              firstName: _firstName.text,
                              lastName: _lastName.text,
                              username: _username.text,
                              email: _email.text,
                              password: _password.text,
                              socialID: _socialID.text,
                              phoneNumber: _phoneNumber.text));
                    } else {
                      await Provider.of<UserAddNotifer>(context, listen: false)
                          .updateUser(
                        widget.user.id,
                        User(
                            firstName: _firstName.text,
                            lastName: _lastName.text,
                            username: _username.text,
                            email: _email.text,
                            password: _password.text,
                            socialID: _socialID.text,
                            phoneNumber: _phoneNumber.text),
                      );
                    }

                    Navigator.pop(context);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  color: Colors.indigo[100],
                  padding: EdgeInsets.only(left: 130.0, right: 130.0),
                  child: Column(
                    children: <Widget>[
                      Text('submit'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
