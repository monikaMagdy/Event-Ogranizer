import 'package:flutter/foundation.dart';
import "dart:async";

class User with ChangeNotifier {
  int id;
  String firstName;
  String lastName;
  String username;
  String email;
  String password;
  String socialID;
  String phoneNumber;
//constructor
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

  get userList => null;
}

//abstract class works as interface

abstract class UserRepository {
  Future<List<User>> fetchUsers();
}

class FetchDataExcpetions implements Exception {
  final message;

  FetchDataExcpetions([this.message]);

  String toString() {
    if (message == null) return "Expection";
    return "Exception: $message";
  }
}
