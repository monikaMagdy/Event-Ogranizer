import 'package:flutter/material.dart';

class Createevent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Form Validation Demo';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Limit attending people"),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "LimiAttending",
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
            Text("Event Name"),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "EventName",
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
            Text("Event address"),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Address",
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
            Text("Event Dresscode"),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Dresscode",
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
            Text("Event Date"),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Date",
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
            Text("Event POLICY"),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "POLICY",
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false
                  // otherwise.
                  if (_formKey.currentState.validate()) {
                    // If the form is valid, display a Snackbar.
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text('Processing Data')));
                  }
                },
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
