import 'package:flutter/material.dart';
import 'package:mobile_project/models/event.dart';
import 'package:provider/provider.dart' as provider;
import '../provider/events.dart';

class EventDetailSearch extends StatelessWidget {
  static const routeName = '/Event-detail';
  Event event;
  EventDetailSearch();
  EventDetailSearch.data(event) {
    this.event = event;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.event.eventName),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                this.event.image,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '\$${this.event.minimumCharge}',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                this.event.address,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                this.event.limitAttending.toString(),
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                this.event.date,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
