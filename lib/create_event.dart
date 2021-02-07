import 'package:flutter/material.dart';
//import 'package:table_calendar/table_calendar.dart';
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

  DateTime _dateTime;
  String capacity;
  String eventName;
  String eventAddress;
  String eventDresscode = "Classic";
  String eventDate;
  String eventPolicy;

  int font = 20;
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
              Text(
                " People capity",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "LimiAttending",
                  counterText: '0 characters',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  if (value.length < 2 || value.length > 4) {
                    return 'check capcity';
                  }
                  return null;
                },
                onSaved: (capacity) {
                  capacity = capacity;
                },
              ),
              Text(
                "Event Name",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
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
                  } else if (!RegExp('^[a-zA-Z0-9]').hasMatch(value)) {
                    return 'Enter Valid Username';
                  }
                  return null;
                },
              ),
              Text(
                "Event address",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
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
                  } else if (!RegExp('^^[a-zA-Z0-9]').hasMatch(value)) {
                    return 'Enter Valid Username';
                  }
                  return null;
                },
                onSaved: (eventname) {
                  eventName = eventname;
                },
              ),
              DropdownButtonFormField(
                focusColor: Colors.indigo[200],
                value: eventDresscode,
                onChanged: (String newValue) {
                  setState(() {
                    eventDresscode = newValue;
                  });
                },
                items: <String>[
                  'Classic',
                  'Halloween',
                  'Fancy Dress',
                  'semi-Fromal'
                ].map<DropdownMenuItem<String>>((String dressCode) {
                  return DropdownMenuItem<String>(
                    child: Text(dressCode),
                    value: dressCode,
                  );
                }).toList(),
              ),
              Text(
                _dateTime == null
                    ? 'Select Your Event date'
                    : _dateTime.toString(),
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              RaisedButton(
                  child: Text('Pick a Date'),
                  color: Colors.indigo[200],
                  onPressed: () {
                    showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2022))
                        .then((date) {
                      setState(() {
                        _dateTime = date;
                      });
                    });
                  }),
              Text(
                "Event POLICY",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
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
                  } else if (!RegExp('^[a-zA-Z0-9]').hasMatch(value)) {
                    return 'Enter Valid Username';
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
