//////////////////// -------------SignUp-----------////////////////

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:mobile_project/models/httpException.dart';
import 'package:mobile_project/screens/products_overview_screen.dart';
import '../Animation.dart';
import '../models/userModel.dart';
import 'package:mobile_project/provider/userAddNotifier.dart';
//import 'package:mobile_project/screens/products_overview_screen.dart';
import 'package:provider/provider.dart';

// ignore: constant_identifier_names
enum AuthMode { Signup, Login }

class LoginForm extends StatefulWidget {
  @override
  _LoginForm createState() => _LoginForm();
}

class _LoginForm extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        child: ListView(
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
                  FadeAnimation(
                    1.6,
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
                  Positioned(
                    child: Container(
                      margin: EdgeInsets.only(top: 50),
                      child: Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: screenSize.width > 600 ? 2 : 1,
              child: SignUpForm(),
            ),
          ],
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  final String operation;
  UserModel user;
  // ignore: sort_constructors_first
  SignUpForm({this.operation, this.user});
  @override
  _SignUpForm createState() => _SignUpForm();
}

class _SignUpForm extends State<SignUpForm> {
  AuthMode _authMode = AuthMode.Login;
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

  //get operation => null;

  // ignore: unused_field
  var _isLoading = false;

  /*String firstName;
  String lastName;
  String username;
  String email;
  String password;  
  String socialID;  
  String phoneNumber;*/
  //@override
  /*void initState() {
    if () {
      _email.text = widget.user.email;
      _password.text = widget.user.password;
    }
    super.initState();
  }
*/
  @override
  void dispose() {
    super.dispose();
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  // ignore: unused_element
  Future<void> _submit() async {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        _isLoading = true;
      });
    }
    try {
      if (_authMode == AuthMode.Login) {
        // Log user in
        await Provider.of<UserAddNotifer>(context, listen: false)
            .login(_email.text, _password.text);
        print('login');

        // Navigator.pop(context);
      } else {
        var user = UserModel(
            firstName: _firstName.text,
            lastName: _lastName.text,
            username: _username.text,
            email: _email.text,
            password: _password.text,
            socialID: _socialID.text,
            phoneNumber: _phoneNumber.text);

        await Provider.of<UserAddNotifer>(context, listen: false)
            .register(context, user, _email.text, _password.text);
        print('signup');
      }
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => ButtonMenu()));
  }

  /* void performSignup() {
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProductsOverviewScreen()),
      );
    });
  }*/

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: deviceSize.width * 0.75,
        padding: const EdgeInsets.all(32),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ///######################################
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    autofocus: true,
                    controller: _firstName,
                    decoration: const InputDecoration(
                      labelText: 'First Name',
                      border: OutlineInputBorder(),
                      focusColor: Colors.black,
                      counterText: '0 characters',
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
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    autofocus: true,
                    controller: _lastName,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'LastName',
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
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    autofocus: true,
                    controller: _username,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'UserName',
                      counterText: '0 characters',
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
                if (_authMode == AuthMode.Login || _authMode == AuthMode.Signup)
                  TextFormField(
                    autofocus: true,
                    controller: _email,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
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

                    // onSaved: (email) => _email = _email,
                  ),
                if (_authMode == AuthMode.Login || _authMode == AuthMode.Signup)
                  TextFormField(
                    autofocus: true,
                    controller: _password,
                    obscureText: true,
                    obscuringCharacter: '*',
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      counterText: '0 characters',
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
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    autofocus: true,
                    controller: _confrimPassword,
                    obscureText: true,
                    obscuringCharacter: '*',
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Confrim Password',
                      counterText: '0 characters',
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
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    autofocus: true,
                    controller: _socialID,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Social ID',
                      counterText: '0 characters',
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
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    autofocus: true,
                    controller: _phoneNumber,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'PhoneNumber',
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
                //if (_authMode == AuthMode.Login)
                /*FlatButton(
                  onPressed: _submit,
                  child: Text('login/Signup'),
                  //Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  color: Colors.indigo[100],
                  padding: EdgeInsets.only(left: 130.0, right: 130.0),

                  //Navigator.pop(context);
                ),*/
                RaisedButton(
                  child:
                      Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                  onPressed: _submit,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).primaryTextTheme.button.color,
                ),
                FlatButton(
                  child: Text(
                      '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                  onPressed: _switchAuthMode,
                  padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
