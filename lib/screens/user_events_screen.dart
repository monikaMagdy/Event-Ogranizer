import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;
import 'package:provider/provider.dart';

import '../provider/events.dart';
import '../widgets/user_event_item.dart';
import '../widgets/app_drawer.dart';
import 'edit_event_screen.dart';

class UserEventsScreen extends StatelessWidget {
  static const routeName = '/user-Events';
  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Events>(context, listen: false)
        .fetchAndSetEvents(fliterByUser: true);
  }

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
      body: FutureBuilder<Object>(
          future: _refreshProducts(context),
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refreshProducts(context),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Consumer<Events>(
                        builder: (context, eventsData, child) =>
                            ListView.builder(
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
                    ),
                  );
          }),
    );
  }
}
