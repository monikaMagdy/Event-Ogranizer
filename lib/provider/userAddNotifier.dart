import 'package:flutter/material.dart';
//import 'dart:async';
import '../models/userModel.dart';

class UserAddNotifer extends ChangeNotifier {
  //
  List<User> userList = [];

  addUser(String firstName, String lastName, String username, String email,
      String password, String socialID, String phoneNumber) async {
    User user = User();
    userList.add(user);

    notifyListeners();
  }
}
