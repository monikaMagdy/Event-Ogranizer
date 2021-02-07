import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_project/models/httpException.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/userModel.dart';
import 'package:http/http.dart' as http;

class UserAddNotifer extends ChangeNotifier {
  //
  List<UserModel> userList = [];
  final String url =
      'https://event-ogranizer-default-rtdb.firebaseio.com/users.json';

  String _token;
  DateTime _expiryDate;
  String _email;
  // ignore: unused_field
  String _username;
  String _userID;
  Timer _authTimer;

  bool get isAuthen {
    return _token != null;
  }

  String get userID {
    return _userID;
  }

  String get email {
    return _email;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  /* UnmodifiableListView<User> get users {
    return UnmodifiableListView(userList);
  }*/

  Future<bool> register(String email, String password) async {
    try {
      var user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      print(user);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email. ');
      }
      return false;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  /*Future<void> _authenticate(
    String email,
    String password,
  ) async {
    String action = "login";
    final apiKey = "API-KEY";
    final url =
        'https://event-ogranizer-default-rtdb.firebaseio.com/users/accounts:$action?key=$apiKey';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }

      _token = responseData['idToken'];
      _userID = responseData['localId'];

      _email = responseData['email'];
      _username = _email.substring(0, _email.indexOf('@'));
      print('/////Test $_username');
      if (_userID == null) {
        throw HttpException('User ID is null');
      }
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      print('Auth, User id is : $_userID');
      //print('Auth, Token is : $_token');
      print('Auth, _expiryDate is : $_expiryDate');
      //_autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userID': _userID,
        'expiryDate': _expiryDate.toIso8601String(),
      });
      prefs.setString('MIUShop_User', userData);
    } catch (error) {
      throw error;
    }
  }

  Future<void> login(String email, String password) {
    return _authenticate(email, password);
  }*/

  Future<bool> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('MIUShop_User')) {
      return false;
    }
    final savedUserData =
        json.decode(prefs.getString('MIUShop_User')) as Map<String, dynamic>;

    _expiryDate = DateTime.parse(savedUserData['expiryDate']);
    if (_expiryDate.isBefore(DateTime.now())) {
      // ignore: prefer_single_quotes
      print("Auto Login Date Check failed");
      return false;
    }

    print('//Auto Login $savedUserData');
    try {
      _token = savedUserData['token'];
      _userID = savedUserData['userId'];
      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());
    }
    print('Test: $_token');
    print('_expiryDate: $_expiryDate');
    return true;
  }

  /*Future<void> signup(User user) async {
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
      final dbUser = <User>[];
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
      rethrow;
    }
  }

  Future<void> updateUser(String id, User newUser) async {
    final url =
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
  }*/

  Future<void> logout() async {
    _token = null;
    _expiryDate = null;
    _userID = null;
    _email = null;
    _username = null;
    _authTimer?.cancel();

    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    //final timeInSeconds = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(_expiryDate.difference(DateTime.now()), logout);
  }

  /* void deleteUser(String id) {
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
