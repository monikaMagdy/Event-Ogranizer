import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget fromText = Container(
        padding: const EdgeInsets.all(50),
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
                    errorText: 'Error Text',
                  ),
                ),
              ],
            )),
          ],
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
      home: Scaffold(
        appBar: AppBar(
          title: Text("Events"),
        ),
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
            onPressed: () {},
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
//##################################################################################

class SingUpForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget form = Container(
        padding: const EdgeInsets.all(32),
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
        ));

    return MaterialApp(
      title: 'SignUp',
      home: Scaffold(
          appBar: AppBar(
            title: Text('SignUp'),
          ),
          body: form),
    );
  }
}
