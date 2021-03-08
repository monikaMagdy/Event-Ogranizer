//import 'dart:collection';
import 'dart:convert';
//import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_project/models/httpException.dart';
import 'package:mobile_project/provider/userAddNotifier.dart';
import '../models/event.dart';
import 'package:flutter/foundation.dart';
//import 'package:provider/provider.dart' as provider;

class Events extends ChangeNotifier {
  static const url = 'https://event-1d68b-default-rtdb.firebaseio.com';
  List<Event> eventDB = [];
  String userID;

  Events();
  // Events(this.authToken, this.userID, this.eventDB);

  List<Event> get items {
    return [...eventDB];
  }

  List<Event> get favoriteItems {
    return eventDB.where((prodItem) => prodItem.isFavorite).toList();
  }

  Event findById(String id) {
    return eventDB.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchAndSetEvents({bool fliterByUser = false}) async {
    final filterString =
        fliterByUser ? 'orderBy="owerID"&equalTo="$userID"' : '';
    String fetchURL = '$url/events.json?userID=$userID&$filterString';
    try {
      final response = await http.get(fetchURL);
      final dbData = json.decode(response.body) as Map<String, dynamic>;
      if (dbData == null) {
        return;
      }
      fetchURL = '$url/userFav/events.json';
      final faviroteResponse = await http.get(fetchURL);
      final favoriteData = json.decode(faviroteResponse.body);
      final List<Event> dbEvents = [];
      dbData.forEach((key, data) {
        dbEvents.add(Event(
          id: key,
          eventName: data['eventName'],
          limitAttending: data['limitAttending'],
          address: data['address'],
          date: data['date'],
          dresscode: data['dresscode'],
          minimumCharge: data['minimumCharge'],
          image: data['image'],
          isFavorite: favoriteData == null ? false : favoriteData[key] ?? true,
        ));
      });
      debugPrint(dbEvents.toString());
      eventDB = dbEvents;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> addEvent(Event event, String uID) async {
    final addURL =
        'https://event-1d68b-default-rtdb.firebaseio.com/events.json?userID=$uID';

    print('userID in add Event Function $uID');
    try {
      print(1);
      final resp = await http.post(
        addURL,
        body: json.encode({
          'id': event.id,
          'userID': uID,
          'eventName': event.eventName,
          'limitAttending': event.limitAttending,
          'address': event.address,
          'date': event.date,
          'dresscode': event.dresscode,
          'minimumCharge': event.minimumCharge,
          'image': event.image,
        }),
      );

      final newEvent = Event(
        eventName: event.eventName,
        limitAttending: event.limitAttending,
        address: event.address,
        date: event.date,
        image: event.image,
        dresscode: event.dresscode,
        minimumCharge: event.minimumCharge,
        id: json.decode(resp.body)['eventName'],
      );

      eventDB.add(newEvent);

      notifyListeners();
    } catch (error) {
      print(3);
      print(error);
      throw (error);
    }
  }

  Future<void> updateEvent(String id, Event newEvent, String uID) async {
    String updateurl =
        'https://event-1d68b-default-rtdb.firebaseio.com/events/$id.json';

    final eventIndex = eventDB.indexWhere((event) => event.id == id);
    if (eventIndex >= 0) {
      //final updateURL = '$updateurl/events/$id.json?userID=$uID';
      await http.patch(updateurl,
          body: json.encode({
            'eventName': newEvent.eventName,
            'limitAttending': newEvent.limitAttending,
            'address': newEvent.address,
            'date': newEvent.date,
            'dresscode': newEvent.dresscode,
            'minimumCharge': newEvent.minimumCharge,
            'image': newEvent.image,
          }));
      eventDB[eventIndex] = newEvent;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<String> deleteEvent(String id) async {
    final deleteURL =
        'https://event-1d68b-default-rtdb.firebaseio.com/events/$id.json';
    print('event_id: $id');
    final existingEventIndex = eventDB.indexWhere((event) => event.id == id);
    var existingEvent = eventDB[existingEventIndex];
    eventDB.removeAt(existingEventIndex);
    print('after removeAt');
    final resp = await http.delete(deleteURL);
    notifyListeners();

    print('this is the response of deleteing data from database');
    // if (resp.statusCode >= 400) {
    //   eventDB.insert(existingEventIndex, existingEvent);
    //   notifyListeners();
    //   AlertDialog alert = AlertDialog(
    //     title: Text("My title"),
    //     content: Text("This is my message."),
    //     actions: [throw HttpException('could not delete event. ')],
    //   );
    // }
    existingEvent = null;
    return 'deleted item $resp, sanks';
  }

  // void takeToken(UserAddNotifer authen, List<Event> events) {
  //   authToken = authen.token;
  //   userID = authen.userID;
  //   print('Events TakeToken, userID:$userID');
  //   eventDB = events;
  // }
}
