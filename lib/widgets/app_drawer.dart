import 'package:flutter/material.dart';
import 'package:mobile_project/provider/userAddNotifier.dart';
import 'package:mobile_project/screens/user_events_screen.dart';
import '../screens/orders_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Social distance feature'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Events'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Choosen events'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Events'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserEventsScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Sign Out'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserAddNotifer().signOut().toString());
            },
          ),
        ],
      ),
    );
  }
}
