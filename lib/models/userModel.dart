import 'package:flutter/foundation.dart';
import "dart:async";

class User with ChangeNotifier {
  int id;
  String firstName;
  String lastName;
  //DateTime _birthdate;
  String username;
  String email;
  String password;
  String socialID;
  String phoneNumber;
//constructor
  User(
    this.firstName,
    this.lastName,
    this.username,
    this.email,
    this.password,
    this.socialID,
    this.phoneNumber,
  );
}
