import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;
import '../screens/edit_event_screen.dart';
import '../provider/events.dart';

class UserEventItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserEventItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditEventScreen.routeName, arguments: id);
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete_outline),
              onPressed: () {
                print('hello from user_event_item');
                provider.Provider.of<Events>(context, listen: false)
                    .deleteEvent(id);
              },
              color: Theme.of(context).errorColor,
            )
          ],
        ),
      ),
    );
  }
}

class AuthS {}
