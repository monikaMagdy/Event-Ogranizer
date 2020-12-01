import 'package:flutter/material.dart';
import 'event.dart';

class Events extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'preview events',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Welcome to Flutter'),
        ),
        body: DisplayEvents(),
      ),
    );
  }
}

class DisplayEvents extends StatefulWidget {
  _DisplayEvents createState() => _DisplayEvents();
}

class _DisplayEvents extends State<DisplayEvents> {
  Event event;

  @override
  Widget build(BuildContext context) {
    EventData eventData = new EventData();
    return Scaffold(
      appBar: AppBar(
        title: Text("Display events"),
      ),
      body: Column(
        children: eventData.eventDB.map((data) {
          return ListTile(
            title: Text(data.eventName),
            subtitle: Column(
              children: <Widget>[
                Text(data.address),
                Text(data.date),
                Text(data.dresscode),
                Text(data.eventCode.toString()),
                Text(data.limitAttending.toString()),
              ],
            ),
            trailing: FavoriteWidget(),
          );
        }).toList(),
      ),
    );
  }
}

class FavoriteWidget extends StatefulWidget {
  _FavoriteWidget createState() => _FavoriteWidget();
}

class _FavoriteWidget extends State<FavoriteWidget> {
  bool _isFavorited = true;
  int _favoriteCount = 41;
  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _favoriteCount -= 1;
        _isFavorited = false;
      } else {
        _favoriteCount += 1;
        _isFavorited = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
            padding: EdgeInsets.all(0),
            alignment: Alignment.centerRight,
            icon: (_isFavorited ? Icon(Icons.star) : Icon(Icons.star_border)),
            color: _isFavorited ? Colors.red : null,
            onPressed: _toggleFavorite,
          ),
        ),
        SizedBox(
          width: 18,
          child: Container(
            child: Text('$_favoriteCount'),
          ),
        ),
      ],
    );
  }
}
