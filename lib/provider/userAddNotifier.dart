import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import '../models/userModel.dart';
import 'package:http/http.dart' as http;

class UserAddNotifer extends ChangeNotifier {
  //
  List<User> userList = [];
  final String url =
      'https://event-ogranizer-default-rtdb.firebaseio.com/users.json';

  /*addUser(String firstName, String lastName, String username, String email,
      String password, String socialID, String phoneNumber) async {
    User user = User(
        firstName, lastName, username, email, password, socialID, phoneNumber);
    userList.add(user);

    notifyListeners();
  }*/

  UnmodifiableListView<User> get users {
    return UnmodifiableListView(userList);
  }

  Future<void> addUser(User user) async {
    return http
        .post(url,
            body: json.encode({
              'firstName': user.firstName,
              'LastName': user.lastName,
              'username': user.username,
              'email': user.email,
              'password': user.password,
              'socialID': user.socialID,
              'phoneNumber': user.phoneNumber
            }))
        .then((res) {
      if (res.statusCode <= 400) {
        final newUser = User(
            firstName: user.firstName,
            lastName: user.lastName,
            username: user.username,
            email: user.email,
            password: user.password,
            socialID: user.socialID,
            phoneNumber: user.phoneNumber,
            id: jsonDecode(res.body)['username']);
        userList.add(newUser);
        notifyListeners();
      }
    }).catchError((error) {
      print(error);
    });
  }

  Future<void> fetchAndSetUser() async {
    try {
      final response = await http.get(url);
      final dbData = json.decode(response.body) as Map<String, dynamic>;
      final List<User> dbUser = [];
      dbData.forEach((key, data) {
        dbUser.add(User(
            id: key,
            firstName: data['firstName'],
            lastName: data['lastName'],
            username: data['username'],
            email: data['email'],
            password: data['password'],
            socialID: data['socailID'],
            phoneNumber: data['phoneNumber']));
      });
      userList = dbUser;
      print(userList);
      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());
      throw (e);
    }
  }

  Future<void> updateUser(String id, User newUser) async {
    final String url =
        'https://event-ogranizer-default-rtdb.firebaseio.com/users/$id.json';
    final userIndex = userList.indexWhere((user) => user.id == id);
    if (userIndex >= 0) {
      await http.patch(url,
          body: json.encode({
            'firstName': newUser.firstName,
            'lastName': newUser.lastName,
            'username': newUser.username,
            'email': newUser.email,
            'password': newUser.password,
            'socailID': newUser.socialID,
            'phoneNumber': newUser.phoneNumber
          }));
      userList[userIndex] = newUser;
      notifyListeners();
    }
  }

  /*void deleteUser(String id) {
    final String url =
        'https://event-ogranizer-default-rtdb.firebaseio.com/users/$id.json';
    final existingIndex = userList.indexWhere((element) => element.id == id);
    var existing = userList[existingIndex];
    userList.remove(existingIndex);
    http.delete(url).then((res) {
      if (res.statusCode >= 400) {
        userList.insert(existingIndex, existing);
        notifyListeners();
        print(res.statusCode);
      }
    });
    notifyListeners();
  }*/
}
