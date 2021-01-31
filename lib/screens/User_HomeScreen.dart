///////////////////////// ---------User_Profile--------/////////////////

import 'package:flutter/material.dart';
//import 'package:mobile_project/provider/userAddNotifier.dart';
import 'package:mobile_project/models/userModel.dart';
import 'package:mobile_project/provider/AddUserScreen.dart';
import 'package:mobile_project/provider/userAddNotifier.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  //
  HomeScreen() : super();

  final String title = "Home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) {
                    return SignUpFromStatless();
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(20),
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(
                      'https://googleflutter.com/sample_image.jpg',
                    ),
                    fit: BoxFit.fill),
              ),
            ),
            Consumer<UserAddNotifer>(
              builder: (context, userAddNotifier, _) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: userAddNotifier.userList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        userAddNotifier.userList[index].username,
                      ),
                    );
                  },
                );
              },
            ),
            //Consumer<>(),
          ],
        ),
      ),
    );
  }
}

//userAddNotifier.userList[index].firstName,
//userAddNotifier.userList[index].lastName,

//userAddNotifier.userList[index].email,
//userAddNotifier.userList[index].password,
//userAddNotifier.userList[index].socialID,
//userAddNotifier.userList[index].phoneNumber ,
