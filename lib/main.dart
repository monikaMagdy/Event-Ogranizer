import 'package:flutter/material.dart';

import 'package:mobile_project/loginpage.dart';
//import 'package:mobile_project/provider/userAddNotifier.dart';
import 'package:provider/provider.dart';
//import 'package:mobile_project/provider/userAddNotifier.dart';
import './screens/cart_screen.dart';
//import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './models/events.dart';
import './models/cart.dart';
import './models/orders.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';

void main() => runApp(MyApp());

/*class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return UserAddNotifer();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginForm(),
      ),
    );
  }
}*/
//import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: EventData(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        ),
      ],
      child: MaterialApp(
          title: 'Event organizer',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            accentColor: Colors.cyan,
            fontFamily: 'Lato',
          ),
          home: LoginForm(),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
          }),
    );
  }
}
