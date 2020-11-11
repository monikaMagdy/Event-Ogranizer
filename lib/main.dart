import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_project/loginpage.dart';
import 'package:mobile_project/signup.dart';
import 'package:mobile_project/create_event.dart';
import 'package:mobile_project/join_event.dart';
import 'package:mobile_project/userProfile.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        backgroundColor: Colors.blueGrey,
      ),
      title: "Home Page",
      home: MenuBar(),
    );
  }
}

class MenuBar extends StatefulWidget {
  @override
  _MenuBarState createState() => _MenuBarState();
}

class _MenuBarState extends State<MenuBar> {
  var _currentIndex = 0;
  final List<Widget> _children = [
    LoginForm(),
    SignUpForm(),
    MyCustomForm(),
    ListViewSearch(),
    UserProfile()
  ];

  void OnTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text("Monika");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                  this.cusSearchBar = Text("Monika");
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
        onTap: OnTappedBar,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              title: Text('login'),
              backgroundColor: Colors.blueGrey),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            title: Text('signup'),
            backgroundColor: Colors.blueGrey,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            title: Text('Create Event'),
            backgroundColor: Colors.blueGrey,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_business_rounded),
            title: Text('join Event'),
            backgroundColor: Colors.blueGrey,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('profile'),
            backgroundColor: Colors.blueGrey,
          ),
        ],
      ),
    );
  }
}
