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
  });
  // ignore: sort_constructors_first
  Event.name(eventName) {
    this.eventName = eventName;
  }
  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
