import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Event with ChangeNotifier {
  int eventCode;
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
    this.eventCode,
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

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
