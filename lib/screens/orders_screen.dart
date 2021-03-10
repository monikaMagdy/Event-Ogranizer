import 'package:flutter/material.dart';
import 'package:mobile_project/provider/OrderProvider.dart';
import 'package:mobile_project/provider/userAddNotifier.dart';
import 'package:provider/provider.dart' as provider;
import 'package:provider/provider.dart';

import '../models/orders.dart' as order;
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    print('building orders');
    // final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: StreamBuilder(
          stream: UserAddNotifer().getUser(),
          // ignore: missing_return

          builder: (context, snapShot) {
            if (snapShot.connectionState == ConnectionState.waiting) {
              Provider.of<OrderProvider>(context, listen: false)
                  .fetchAndSetOrder(snapShot.data.uid);
              ;
            } else {
              if (snapShot.error != null) {
                // ...
                // Do error handling stuff
                return Center(
                  child: Text('An error occurred!'),
                );
              } else {
                return Consumer<OrderProvider>(
                  builder: (ctx, orderData, child) => ListView.builder(
                    itemCount: orderData.orders.length,
                    itemBuilder: (ctx, i) =>
                        OrderItemWidget(orderData.orders[i]),
                  ),
                );
              }
            }
          }),
    );
  }
}
