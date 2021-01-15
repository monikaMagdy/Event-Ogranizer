import 'package:flutter/foundation.dart';

class User with ChangeNotifier {
  int id;
  String firstName;
  String lastName;
  String username;
  String email;
  String password;
  String socialID;
  String phoneNumber;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.username,
    this.email,
    this.password,
    this.socialID,
    this.phoneNumber,
  });
}
