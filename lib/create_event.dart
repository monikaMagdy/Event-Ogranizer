import 'package:flutter/material.dart';
import 'package:mobile_project/preview_events.dart';

class Createevent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Form Validation Demo';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
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

class MyCustomFormState extends State<MyCustomForm> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  String capacity;
  String eventName;
  String eventAddress;
  String eventDresscode;
  String eventDate;
  String eventPolicy;
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
      performCreation();
    }
  }

  void performCreation() {
    setState(() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Events()));
    });
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(" People capity"),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "LimiAttending",
                  counterText: '0 characters',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  if (value.length < 25 || value.length > 50) {
                    return 'check capcity';
                  }
                  return null;
                },
                onSaved: (capacity) {
                  capacity = capacity;
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
                  } else if (value.length < 3) {
                    return 'event name too short';
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
                onSaved: (eventname) {
                  eventName = eventname;
                },
              ),
              Text("Event Dresscode"),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "dress code ",
                  counterText: '0 characters',
                  //errorText: 'Error Text',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  } else if (value.length < 5) {
                    return 'Event Dress Code';
                  }
                  return null;
                },
                onSaved: (eventdate) {
                  eventDate = eventdate;
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
                  } else if (value.length < 5) {
                    return 'Event Date';
                  }
                  return null;
                },
                onSaved: (eventdate) {
                  eventDate = eventdate;
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
                  } else if (value.length < 10) {
                    return 'Event Policy too short!';
                  }
                  return null;
                },
                onSaved: (eventpolicy) {
                  eventPolicy = eventpolicy;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    _submit();
                    // Validate returns true if the form is valid, or false
                    // otherwise.
                    if (formKey.currentState.validate()) {
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
      ),
    );
  }
}
