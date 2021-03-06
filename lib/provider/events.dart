//import 'dart:collection';
import 'dart:convert';
//import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mobile_project/models/httpException.dart';
import 'package:mobile_project/provider/userAddNotifier.dart';
import '../models/event.dart';
import 'package:flutter/foundation.dart';
//import 'package:provider/provider.dart' as provider;

class Events extends ChangeNotifier {
  static const url = 'https://event-1d68b-default-rtdb.firebaseio.com';
  List<Event> eventDB = [];
  String authToken;
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

  Future<void> fetchAndSetProducts({bool fliterByUser = false}) async {
    final filterString =
        fliterByUser ? 'orderBy="owerID"&equalTo="$userID"' : '';
    String fetchURL = '$url/events.json?userID=$userID&$filterString';
    try {
      final response = await http.get(fetchURL);
      final dbData = json.decode(response.body) as Map<String, dynamic>;
      if (dbData == null) {
        return;
      }
      fetchURL = '$url/userFav/events.json?';
      final faviroteResponse = await http.get(fetchURL);
      final favoriteData = json.decode(faviroteResponse.body);
      final List<Event> dbProducts = [];
      dbData.forEach((key, data) {
        dbProducts.add(Event(
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
      debugPrint(dbProducts.toString());
      eventDB = dbProducts;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> addEvent(Event product, String uID) async {
    final addURL =
        'https://event-1d68b-default-rtdb.firebaseio.com/events.json?userID=$uID';

    print('userID in add Event Function $uID');
    try {
      print(1);
      final resp = await http.post(
        addURL,
        body: json.encode({
          'userID': uID,
          'eventName': product.eventName,
          'limitAttending': product.limitAttending,
          'address': product.address,
          'date': product.date,
          'dresscode': product.dresscode,
          'minimumCharge': product.minimumCharge,
          'image': product.image,
        }),
      );

      final newProduct = Event(
        eventName: product.eventName,
        limitAttending: product.limitAttending,
        address: product.address,
        date: product.date,
        image: product.image,
        dresscode: product.dresscode,
        minimumCharge: product.minimumCharge,
        id: json.decode(resp.body)['eventName'],
      );

      eventDB.add(newProduct);

      notifyListeners();
    } catch (error) {
      print(3);
      print(error);
      throw (error);
    }
  }

  Future<void> updateEvent(String id, Event newProduct, String uID) async {
    String updateurl =
        'https://event-1d68b-default-rtdb.firebaseio.com/events/$id.json';

    final prodIndex = eventDB.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final updateURL = '$updateurl/events/$id.json?userID=$uID';
      await http.patch(updateURL,
          body: json.encode({
            'eventName': newProduct.eventName,
            'imageUrl': newProduct.image,
            'minimum Charge': newProduct.minimumCharge,
          }));
      eventDB[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteEvent(String id) async {
    final deleteURL = '$url/$id.json?auth=$authToken';

    final existingProductIndex = eventDB.indexWhere((prod) => prod.id == id);
    var existingProduct = eventDB[existingProductIndex];
    eventDB.removeAt(existingProductIndex);
    notifyListeners();
    final resp = await http.delete(deleteURL);
    if (resp.statusCode >= 400) {
      eventDB.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('could not delete product. ');
    }
    existingProduct = null;
  }

  void takeToken(UserAddNotifer authen, List<Event> events) {
    authToken = authen.token;
    userID = authen.userID;
    print('Events TakeToken, userID:$userID');
    eventDB = events;
  }
}
