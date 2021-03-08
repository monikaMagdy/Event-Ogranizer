import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;

import '../provider/events.dart';
import '../widgets/user_event_item.dart';
import '../widgets/app_drawer.dart';
import 'edit_event_screen.dart';

class UserEventsScreen extends StatelessWidget {
  static const routeName = '/user-Events';

  @override
  Widget build(BuildContext context) {
    final eventsData = provider.Provider.of<Events>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Events'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditEventScreen.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: eventsData.items.length,
          itemBuilder: (_, i) => Column(
            children: [
              UserEventItem(
                eventsData.items[i].id,
                eventsData.items[i].eventName,
                eventsData.items[i].image,
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
