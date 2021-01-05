import 'package:flutter/material.dart';

import './event.dart';

class EventData with ChangeNotifier {
  List<Event> eventDB = [
    Event(
      //0
      eventCode: 67869,
      eventName: 'Happiness',
      limitAttending: 100,
      address: 'El rehab 2 street 12',
      date: '22/10/2021',
      image:
          'https://images.pexels.com/photos/976866/pexels-photo-976866.jpeg?cs=srgb&dl=pexels-josh-sorenson-976866.jpg&fm=jpg',
      dresscode: 'casual',
      minimumCharge: 500,
    ),
    Event(
      //1
      eventCode: 09796,
      eventName: 'Buttercup',
      limitAttending: 50,
      address: '112 elObour buildings',
      date: '30/11/2020',
      image:
          'https://www.creativiva.com/wp-content/uploads/2016/05/decor-blog-1.jpg',
      dresscode: 'semi-formal',
      minimumCharge: 500,
    ),
    Event(
      //2
      eventCode: 76980,
      eventName: 'darkforest',
      limitAttending: 150,
      address: 'mall misr, october',
      date: '28/11/2020',
      image:
          'https://www.i-eventplanner.com/wp-content/uploads/2018/07/Party-Event-Planner.jpg',
      dresscode: 'trendy',
      minimumCharge: 500,
    ),
  ];

  List<Event> get items {
    return [...eventDB];
  }

  List<Event> get favoriteItems {
    return eventDB.where((prodItem) => prodItem.isFavorite).toList();
  }

  Event findById(String id) {
    return eventDB.firstWhere((prod) => prod.eventCode == id);
  }

  void addEvent(Event event) {
    final newEvent = Event(
      eventCode: event.eventCode,
      eventName: event.eventName,
      limitAttending: event.limitAttending,
      address: event.address,
      image: event.image,
      dresscode: event.dresscode,
      date: DateTime.now().toString(),
    );
    eventDB.add(newEvent);
    notifyListeners();
  }

  void updateEvent(String id, Event newEvent) {
    final prodIndex = eventDB.indexWhere((prod) => prod.eventCode == id);
    if (prodIndex >= 0) {
      eventDB[prodIndex] = newEvent;
      notifyListeners();
    }
  }

  void deleteEvent(String id) {
    eventDB.removeWhere((prod) => prod.eventCode == id);
    notifyListeners();
  }
}
