import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpForm createState() => _SignUpForm();
}

class _SignUpForm extends State<SignUpForm> {
  @override
  Widget build(BuildContext context) {
    Widget form = Container(
        padding: const EdgeInsets.all(32),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("First Name"),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "FirstName",
                  counterText: '0 characters',
                  //errorText: 'Error Text',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              Text("Last Name"),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "LastName",
                  counterText: '0 characters',
                  //errorText: 'Error Text',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              Text("Email"),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Email",
                  counterText: '0 characters',
                  //errorText: 'Error Text',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              Text("Password"),
              TextFormField(
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
                  }
                  return null;
                },
              ),
              Text("Confirm Password"),
              TextFormField(
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
                  }
                  return null;
                },
              ),
              Text("Socail ID"),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Social ID",
                  counterText: '0 characters',
                  //errorText: 'Error Text',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              Text("Phone Number"),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "PhoneNumber",
                  counterText: '0 characters',
                  //errorText: 'Error Text',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ],
          ),
        ));

    return MaterialApp(
      title: 'SignUp',
      //theme: ThemeData.dark(),
      home: Scaffold(
        body: form,
      ),
    );
  }
}
