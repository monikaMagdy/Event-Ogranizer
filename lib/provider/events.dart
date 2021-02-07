import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/event.dart';
import 'package:flutter/foundation.dart';

class Events extends ChangeNotifier {
  String url = 'https://event-1d68b-default-rtdb.firebaseio.com/events.json';
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
    try {
      final response = await http.get(url);
      final dbData = json.decode(response.body) as Map<String, dynamic>;
      final dbProducts = <Event>[];
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
      print(eventDB);
      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());
      throw (e);
    }
  }

  Future<void> addEvent(Event product) async {
    return http
        .post(url,
            body: json.encode({
              'eventName': product.eventName,
              'limitAttending': product.limitAttending,
              'address': product.address,
              'date': product.date,
              'dresscode': product.dresscode,
              'minimumCharge': product.minimumCharge,
              'image': product.image,
            }))
        .then((res) {
      if (res.statusCode <= 400) {
        final newProduct = Event(
          eventName: product.eventName,
          limitAttending: product.limitAttending,
          address: product.address,
          date: product.date,
          image: product.image,
          dresscode: product.dresscode,
          minimumCharge: product.minimumCharge,
          eventCode: json.decode(res.body)['eventName'],
        );
        eventDB.add(product);
        notifyListeners();
      }
    });
  }

  Future<void> updateEvent(String id, Event newProduct) async {
    String url =
        'https://event-1d68b-default-rtdb.firebaseio.com/events/$id.json';

    final prodIndex = eventDB.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      await http.patch(url,
          body: json.encode({
            'eventName': newProduct.eventName,
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
    final String url =
        'https://event-1d68b-default-rtdb.firebaseio.com/events/$id.json';

    final existingProductIndex = eventDB.indexWhere((prod) => prod.id == id);
    var existingProduct = eventDB[existingProductIndex];
    eventDB.remove(existingProductIndex);
    await http.delete(url).then((res) {
      if (res.statusCode >= 400) {
        eventDB.insert(existingProductIndex, existingProduct);
        notifyListeners();
        print(res.statusCode);
      }
    });
    notifyListeners();
    // notifyListeners();
    //final response = await http.delete(url);
    //if (response.statusCode >= 400) {
    //  eventDB.insert(existingProductIndex, existingProduct);
    //  notifyListeners();
    //  throw HttpException('Could not delete product.');
    //}
    //existingProduct = null;
  }
}
