import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Event with ChangeNotifier {
  static const url = 'https://event-1d68b-default-rtdb.firebaseio.com';
  String id;
  String uID;
  String eventName;
  int limitAttending;
  String address;
  String date;
  String image;
  String dresscode;
  int minimumCharge;
  bool isFavorite;
  Event({
    this.id,
    this.uID,
    this.eventName,
    this.limitAttending,
    this.address,
    this.date,
    this.image,
    this.dresscode,
    this.minimumCharge,
    this.isFavorite,
  });

  // ignore: sort_constructors_first

  Event copyWith({
    String id,
    String uID,
    String eventName,
    int limitAttending,
    String address,
    String date,
    String image,
    String dresscode,
    int minimumCharge,
    bool isFavorite,
  }) {
    return Event(
      id: id ?? this.id,
      uID: uID ?? this.uID,
      eventName: eventName ?? this.eventName,
      limitAttending: limitAttending ?? this.limitAttending,
      address: address ?? this.address,
      date: date ?? this.date,
      image: image ?? this.image,
      dresscode: dresscode ?? this.dresscode,
      minimumCharge: minimumCharge ?? this.minimumCharge,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uID': uID,
      'eventName': eventName,
      'limitAttending': limitAttending,
      'address': address,
      'date': date,
      'image': image,
      'dresscode': dresscode,
      'minimumCharge': minimumCharge,
      'isFavorite': isFavorite,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Event(
      id: map['id'],
      uID: map['uID'],
      eventName: map['eventName'],
      limitAttending: map['limitAttending'],
      address: map['address'],
      date: map['date'],
      image: map['image'],
      dresscode: map['dresscode'],
      minimumCharge: map['minimumCharge'],
      isFavorite: map['isFavorite'],
    );
  }

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

  String toJson() => json.encode(toMap());

  factory Event.fromJson(String source) => Event.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Event(id: $id, uID: $uID, eventName: $eventName, limitAttending: $limitAttending, address: $address, date: $date, image: $image, dresscode: $dresscode, minimumCharge: $minimumCharge, isFavorite: $isFavorite)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Event &&
        o.id == id &&
        o.uID == uID &&
        o.eventName == eventName &&
        o.limitAttending == limitAttending &&
        o.address == address &&
        o.date == date &&
        o.image == image &&
        o.dresscode == dresscode &&
        o.minimumCharge == minimumCharge &&
        o.isFavorite == isFavorite;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        uID.hashCode ^
        eventName.hashCode ^
        limitAttending.hashCode ^
        address.hashCode ^
        date.hashCode ^
        image.hashCode ^
        dresscode.hashCode ^
        minimumCharge.hashCode ^
        isFavorite.hashCode;
  }
}
