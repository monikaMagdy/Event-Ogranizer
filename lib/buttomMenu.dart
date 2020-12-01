import 'package:flutter/material.dart';
import 'package:mobile_project/preview_events.dart';
import 'package:mobile_project/create_event.dart';
import 'package:mobile_project/join_event.dart';
import 'package:mobile_project/userProfile.dart';
import 'package:flutter/services.dart';

class MenuBar extends StatefulWidget {
  @override
  _MenuBarState createState() => _MenuBarState();
}

class _MenuBarState extends State<MenuBar> {
  var _currentIndex = 0;
  final List<Widget> _children = [
    Events(),
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
  Widget cusSearchBar = Text("Search");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent[100],
        actions: <Widget>[
          IconButton(
            icon: cusIcon,
            onPressed: () {
              setState(() {
                if (this.cusIcon.icon == Icons.search) {
                  this.cusIcon = Icon(Icons.cancel);
                  this.cusSearchBar = TextField(
                    textInputAction: TextInputAction.go,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search here",
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  );
                } else {
                  this.cusIcon = Icon(Icons.search);
                  this.cusSearchBar = Text("search");
                }
              });
            },
          ),
        ],
        title: cusSearchBar,
      ),
      drawer: Column(
        children: [
          Container(
            child: RaisedButton(
              onPressed: () {
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Createevent(),
                    ),
                  );
                });
              },
              child: Text("Create Event"),
            ),
          ),
          Container(
            child: RaisedButton(
              onPressed: () {
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => JoinEvent(),
                    ),
                  );
                });
              },
              child: Text("Your Events"),
            ),
          ),
          Container(
            child: RaisedButton(
              onPressed: () {
                setState(() {});
              },
              child: Text("Join Event"),
            ),
          ),
        ],
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTappedBar,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.blueGrey,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Create Event',
            backgroundColor: Colors.blueGrey,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_business_rounded),
            label: 'join Event',
            backgroundColor: Colors.blueGrey,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'profile',
            backgroundColor: Colors.blueGrey,
          ),
        ],
      ),
    );
  }
}
