import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Event with ChangeNotifier {
  static const url = 'https://event-1d68b-default-rtdb.firebaseio.com';
  String id;
  String eventName;
  int limitAttending;
  String address;
  String date;
  String image;
  String dresscode;
  int minimumCharge;
  bool isFavorite;
  final DocumentReference reference;

  // ignore: sort_constructors_first
  Event({
    this.id,
    this.eventName,
    this.limitAttending,
    this.address,
    this.date,
    this.image,
    this.dresscode,
    this.minimumCharge,
    this.isFavorite = false,
    this.reference,
  });
  // ignore: sort_constructors_first

  // void toggleFavoriteStatus() {
  //   isFavorite = !isFavorite;
  //   notifyListeners();
  // }

  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String token, String userID) async {
    final state = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final toggleURL = '$url/userFav/$userID/$id.json?auth=$token';
    try {
      final response = await http.put(
        url,
        body: json.encode(isFavorite),
      );
      print('1 response.statusCode ${response.statusCode}');
      if (response.statusCode >= 400) {
        _setFavValue(state);
        print('2 response.statusCode ${response.statusCode}');
      }
    } catch (error) {
      _setFavValue(state);
      print('error: ${error.toString()}');
    }
  }
}
