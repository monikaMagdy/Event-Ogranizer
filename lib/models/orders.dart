import 'package:flutter/foundation.dart';

import './cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> events;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.events,
    @required this.dateTime,
  });
}
