import 'package:flutter/material.dart';
import 'package:mobile_project/provider/OrderProvider.dart';
import 'package:provider/provider.dart' as provider;

import '../models/orders.dart' as order;
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final orderData = provider.Provider.of<OrderProvider>(context, listen:false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
      ),
    );
  }
}
