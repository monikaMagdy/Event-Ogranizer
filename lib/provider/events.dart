import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/event.dart';
import 'package:flutter/foundation.dart';

class Events extends ChangeNotifier {
  final String urll = "https://event-ogranizer-default-rtdb.firebaseio.com";
  List<Event> eventDB = [];
  String authToken;
  String userId;
  Events();
  List<Event> get items {
    return [...eventDB];
  }

  List<Event> get favoriteItems {
    return eventDB.where((prodItem) => prodItem.isFavorite).toList();
  }

  Event findById(String id) {
    return eventDB.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchAndSetProducts() async {
    const url =
        'https://event-ogranizer-default-rtdb.firebaseio.com/events.json';
    try {
      final response = await http.get(url);
      //print(json.decode(response.body));
      final dbData = json.decode(response.body) as Map<String, dynamic>;
      final List<Event> dbProducts = [];
      dbData.forEach((key, data) {
        dbProducts.add(Event(
          id: key,
          eventName: data['Event name'],
          eventCode: data['Event code'],
          minimumCharge: data['min charge'],
          image: data['imageUrl'],
          isFavorite: data['isFavorite'],
        ));
      });
      eventDB = dbProducts;
      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());
      throw (e);
    }
  }

  Future<void> addEvent(Event product) async {
    final url = '$urll/events.json?auth=$authToken';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'event Name': product.eventName,
          'eventCode': product.eventCode,
          'imageUrl': product.image,
          'minimum Charge': product.minimumCharge,
          'ownerId': userId,
        }),
      );
      final newProduct = Event(
        eventName: product.eventName,
        eventCode: product.eventCode,
        minimumCharge: product.minimumCharge,
        image: product.image,
        id: json.decode(response.body)['name'],
      );
      eventDB.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateEvent(String id, Event newProduct) async {
    final prodIndex = eventDB.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url = '$urll/events.json?auth=$authToken';
      await http.patch(url,
          body: json.encode({
            'event Name': newProduct.eventName,
            'eventCode': newProduct.eventCode,
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
    final url = '$urll/$id.json?auth=$authToken';
    final existingProductIndex = eventDB.indexWhere((prod) => prod.id == id);
    var existingProduct = eventDB[existingProductIndex];
    eventDB.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      eventDB.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingProduct = null;
  }
}
