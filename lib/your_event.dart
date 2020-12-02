import 'package:flutter/material.dart';
import 'event.dart';

class ChoosenEvent extends StatelessWidget {
  Event event;

  ChoosenEvent.data(event) {
    this.event = event;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Tutorials',
        home: Scaffold(
          appBar: AppBar(title: Text('Event data')),
          body: Center(
            child: Container(
              child: Column(children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text('event code: ' + this.event.eventCode.toString(),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 19.0)),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text('event name: ' + this.event.eventName,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 19.0)),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text(
                      'limiting attending people to: ' +
                          this.event.limitAttending.toString(),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 19.0)),
                ),
                Container(
                    margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Text('event address: ' + this.event.address,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 19.0))),
                Container(
                    margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Text('event date: ' + this.event.date,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 19.0))),
                Container(
                  margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text('event dresscode: ' + this.event.dresscode,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 19.0)),
                ),
              ]),
            ),
          ),
        ));
  }
}
