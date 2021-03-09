import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;
import '../screens/edit_event_screen.dart';
import '../provider/events.dart';

class UserEventItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  // ignore: sort_constructors_first
  UserEventItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
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
              onPressed: () async {
                try {
                  await provider.Provider.of<Events>(context, listen: false)
                      .deleteEvent(id);
                } catch (error) {
                  SnackBar(
                    content: Text(
                      'Deleting failed!',
                      textAlign: TextAlign.center,
                    ),
                  );
                }
              },
              color: Theme.of(context).errorColor,
            )
          ],
        ),
      ),
    );
  }
}
