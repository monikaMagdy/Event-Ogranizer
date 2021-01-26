import 'package:flutter/material.dart';
//import 'package:mobile_project/provider/userAddNotifier.dart';
import 'package:mobile_project/models/userModel.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  //
  HomeScreen() : super();

  final String title = "Home";
  @override
  Widget build(BuildContext context) {
    Widget profile = Container(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Consumer<User>(
                builder: (context, userAddNotifier, _) {
                  return ListView.builder(
                      itemCount: userAddNotifier.userList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            userAddNotifier.userList[index].username,
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                            ),
                          ),
                        );
                      });
                },
              ),
            ],
          ),
        ),
      ),
    );
    return MaterialApp(
      title: 'SignUp',
      //theme: ThemeData.dark(),
      home: Scaffold(
        body: profile,
      ),
    );
  }
}
