import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_project/provider/userAddNotifier.dart';
import '../models/orders.dart';
import '../models/cart.dart';

class OrderProvider with ChangeNotifier {
  String url = 'https://event-1d68b-default-rtdb.firebaseio.com/';
  List<OrderItem> _orders = [];
  String authenToken;
  String userID;
  OrderProvider();
  //OrderProvider(this.authenToken, this.userID, this._orders);

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrder() async {
    final fetchURL = '$url/order/$userID.json?auth=$authenToken';

    final response = await http.get(fetchURL);
    final List<OrderItem> loadedOrder = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderID, orderData) {
      loadedOrder.add(
        OrderItem(
          id: orderID,
          amount: orderData['amount'],
          dateTime: DateTime.parse(orderData['dateTime']),
          products: (orderData['product'] as List<dynamic>)
              .map(
                (event) => CartItem(
                  id: event['id'],
                  title: event['title'],
                  quantity: event['quantity'],
                  price: event['price'],
                ),
              )
              .toList(),
        ),
      );
    });
    _orders = loadedOrder.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(
      List<CartItem> cartEvent, double total, String uID) async {
    final addURL = '$url/Orders.json?userID=$uID';
    final timestamp = DateTime.now();
    final response = await http.post(
      addURL,
      body: json.encode({
        'userID': uID,
        'amount': total,
        'dateTime': timestamp.toIso8601String(),
        'product': cartEvent
            .map((cEvent) => {
                  'id': cEvent.id,
                  'title': cEvent.title,
                  'quantity': cEvent.quantity,
                  'price': cEvent.price,
                })
            .toList(),
      }),
    );
    _orders.insert(
        0,
        OrderItem(
          id: json.decode(response.body)['name'],
          amount: total,
          dateTime: timestamp,
          products: cartEvent,
        ));
    notifyListeners();
  }
}
