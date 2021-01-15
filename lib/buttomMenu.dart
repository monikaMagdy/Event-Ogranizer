import 'package:flutter/material.dart';
import 'package:mobile_project/preview_events.dart';
import './screens/products_overview_screen.dart';
import 'package:mobile_project/create_event.dart';
import 'package:mobile_project/join_event.dart';
import 'package:mobile_project/screens/products_overview_screen.dart';
import 'package:mobile_project/userProfile.dart';
import 'package:flutter/services.dart';

class MenuBar extends StatefulWidget {
  @override
  _MenuBarState createState() => _MenuBarState();
}

class _MenuBarState extends State<MenuBar> {
  var _currentIndex = 0;
  final List<Widget> _children = [
    ProductsOverviewScreen(),
    Createevent(),
    JoinEvent(),
    UserProfile()
  ];

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Icon cusIcon = Icon(Icons.search);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTappedBar,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.indigo[100],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Create Event',
            backgroundColor: Colors.indigo[100],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search Event',
            backgroundColor: Colors.indigo[100],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'profile',
            backgroundColor: Colors.indigo[100],
          ),
        ],
      ),
    );
  }
}
