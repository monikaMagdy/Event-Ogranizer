import 'package:flutter/material.dart';
import 'event.dart';

class Events extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // todo: implement build
    return MaterialApp(
      title: 'preview events',
      home: new Scaffold(
        body: DisplayEvents(),
      ),
    );
  }
}

class DisplayEvents extends StatefulWidget {
  _DisplayEvents createState() => _DisplayEvents();
}

class _DisplayEvents extends State<DisplayEvents> {
  EventData eventData = new EventData();

  List<Event> list;

  @override
  void initState() {
    list = eventData.eventDB;
  }

  void refresh() {
    setState(() {
      list = eventData.eventDB;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: list.map((data) {
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
          trailing: Icon(
            data.isFavorite ? Icons.favorite : Icons.favorite_border,
            color: data.isFavorite ? Colors.red : null,
          ),
          onTap: () {
            data.setFavorite(!data.isFavorite);
            refresh();
          },
        );
      }).toList(),
    );
  }
}

// class FavoriteWidget extends StatefulWidget {
//   final bool fav;

//   const FavoriteWidget({Key key, this.fav}) : super(key: key);

//   @override
//   _FavoriteWidget createState() => _FavoriteWidget();
// }

// class _FavoriteWidget extends State<FavoriteWidget> {
//   bool _isFavorited;
//   @override
//   void initState() {
//     _isFavorited = widget.fav;
//   }

//   int _favoriteCount = 41;
//   void _toggleFavorite() {
//     setState(() {
//       if (_isFavorited) {
//         _favoriteCount -= 1;
//         _isFavorited = false;
//       } else {
//         _favoriteCount += 1;
//         _isFavorited = true;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           padding: EdgeInsets.all(0),
//           child: IconButton(
//             padding: EdgeInsets.all(0),
//             alignment: Alignment.centerRight,
//             icon: (_isFavorited ? Icon(Icons.star) : Icon(Icons.star_border)),
//             color: _isFavorited ? Colors.red : null,
//             onPressed: _toggleFavorite,
//           ),
//         ),
//         SizedBox(
//           width: 18,
//           child: Container(
//             child: Text('$_favoriteCount'),
//           ),
//         ),
//       ],
//     );
//   }
// }
