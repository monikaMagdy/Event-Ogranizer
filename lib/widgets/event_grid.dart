import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;
import 'package:provider/provider.dart';

import '../provider/events.dart';
import 'event_item.dart';

class EventsGrid extends StatelessWidget {
  final bool showFavs;

  // ignore: sort_constructors_first
  EventsGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {
    final eventsData = provider.Provider.of<Events>(context, listen: false);
    debugPrint('data: $eventsData');
    final events = showFavs ? eventsData.favoriteItems : eventsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: events.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: events[i],
        child: EventItem(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
