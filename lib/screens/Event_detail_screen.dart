import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;
import '../provider/events.dart';

class EventDetailScreen extends StatelessWidget {
  static const routeName = '/Event-detail';

  @override
  Widget build(BuildContext context) {
    final eventId =
        ModalRoute.of(context).settings.arguments as String; // is the id!
    final loadedEvent = provider.Provider.of<Events>(
      context,
      listen: false,
    ).findById(eventId);
    print(eventId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedEvent.eventName),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                loadedEvent.image,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '\$${loadedEvent.minimumCharge}',
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
                loadedEvent.address,
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
                loadedEvent.limitAttending.toString(),
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
                loadedEvent.date,
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
