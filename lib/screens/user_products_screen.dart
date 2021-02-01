import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;

import '../models/events.dart';
import '../widgets/user_product_item.dart';
import '../widgets/app_drawer.dart';
import './edit_product_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  @override
  Widget build(BuildContext context) {
    final productsData = provider.Provider.of<EventData>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Events'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productsData.items.length,
          itemBuilder: (_, i) => Column(
            children: [
              UserProductItem(
                productsData.items[i].id,
                productsData.items[i].eventName,
                productsData.items[i].image,
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
