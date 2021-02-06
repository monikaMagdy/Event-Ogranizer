/*import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:mobile_project/provider/userAddNotifier.dart';
import 'package:mobile_project/provider/AddUserScreen.dart';
import 'package:mobile_project/provider/userAddNotifier.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  ///////////////////////// ---------User_Profile--------/////////////////

  HomeScreen() : super();
  @override
  final String title = 'Home';
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
                  builder: (context) => SignUpForm(operation: 'Add'),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Container(
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
            ),
            Text(
              'First Name',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            Consumer<UserAddNotifer>(
              builder: (BuildContext context, userData, Widget child) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: userData.users.length,
                  itemBuilder: (context, index) {
                    final user = userData.users[index];
                    return ListTile(
                      title: GestureDetector(
                        child: Text(user.firstName),
                        onDoubleTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpForm(
                                operation: 'Edit',
                                user: user,
                              ),
                            ),
                          );
                        },
                      ),
                      focusColor: Colors.black,
                      //subtitle: Text((user.firstName).toString()),
                    );
                  },
                );
              },
            ),
            Text(
              'Last Name',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            Consumer<UserAddNotifer>(
              builder: (BuildContext context, userData, Widget child) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: userData.users.length,
                  itemBuilder: (context, index) {
                    final user = userData.users[index];
                    return ListTile(
                      title: GestureDetector(
                        child: Text(user.lastName),
                        onDoubleTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpForm(
                                operation: 'Edit',
                                user: user,
                              ),
                            ),
                          );
                        },
                      ),
                      //subtitle: Text((user.lastName).toString()),
                    );
                  },
                );
              },
            ),
            Text(
              'Username',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            Consumer<UserAddNotifer>(
              builder: (BuildContext context, userData, Widget child) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: userData.users.length,
                  itemBuilder: (context, index) {
                    final user = userData.users[index];
                    return ListTile(
                      title: GestureDetector(
                        child: Text(user.username),
                        onDoubleTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpForm(
                                operation: 'Edit',
                                user: user,
                              ),
                            ),
                          );
                        },
                      ),
                      //subtitle: Text((user.username).toString()),
                    );
                  },
                );
              },
            ),
            Text(
              'Email',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            Consumer<UserAddNotifer>(
              builder: (BuildContext context, userData, Widget child) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: userData.users.length,
                  itemBuilder: (context, index) {
                    final user = userData.users[index];
                    return ListTile(
                      title: GestureDetector(
                        child: Text(user.email),
                        onDoubleTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpForm(
                                operation: 'Edit',
                                user: user,
                              ),
                            ),
                          );
                        },
                      ),
                      //subtitle: Text((user.email).toString()),
                    );
                  },
                );
              },
            ),
            Text(
              'Phone Number',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            Consumer<UserAddNotifer>(
              builder: (BuildContext context, userData, Widget child) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: userData.users.length,
                  itemBuilder: (context, index) {
                    final user = userData.users[index];
                    return ListTile(
                      title: GestureDetector(
                        child: Text(user.phoneNumber),
                        onDoubleTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpForm(
                                operation: 'Edit',
                                user: user,
                              ),
                            ),
                          );
                        },
                      ),
                      //subtitle: Text((user.password).toString()),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
*/
