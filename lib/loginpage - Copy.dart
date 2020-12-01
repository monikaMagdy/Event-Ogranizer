import 'package:flutter/material.dart';
import 'package:mobile_project/create_event.dart';
import 'package:mobile_project/signup.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginForm createState() => _LoginForm();
}

class _LoginForm extends State<LoginForm> {
  var data;
  @override
  Widget build(BuildContext context) {
    Widget fromText = Container(
        padding: const EdgeInsets.all(50),
        child: SingleChildScrollView(
          child: Row(
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Username"),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Email - Username',
                      //errorText: 'Error Text',
                    ),
                  ),
                  Text("Password"),
                  TextField(
                    obscureText: true,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Password',
                      //errorText: 'Error Text',
                    ),
                  ),
                ],
              )),
            ],
          ),
        ));

    Color color = Theme.of(context).primaryColor;

    var buttonSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(color, 'Login'),
          _buildButtonColumn(color, 'Signup'),
        ],
      ),
    );

    return MaterialApp(
      title: "Event Ogranizer",
      // theme: ThemeData.dark(),
      home: Scaffold(
        body: ListView(
          children: [fromText, buttonSection],
        ),
      ),
    );
  }

  Column _buildButtonColumn(Color color, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: RaisedButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            onPressed: () {
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Createevent(),
                  ),
                );
              });
            },
            color: Colors.indigo,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w900,
                color: Colors.cyan,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
