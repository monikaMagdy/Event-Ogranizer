import 'package:flutter/foundation.dart';

class Event with ChangeNotifier {
  int eventCode;
  String eventName;
  int limitAttending;
  String address;
  String date;
  String image;
  String dresscode;
  int minimumCharge;
  bool isFavorite;

  Event({
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
  Event.name(eventName) {
    this.eventName = eventName;
  }
  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
