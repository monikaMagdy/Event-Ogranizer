import 'package:flutter/material.dart'
    show
        BuildContext,
        Colors,
        MaterialApp,
        StatelessWidget,
        ThemeData,
        Widget,
        WidgetsFlutterBinding,
        runApp;
import 'package:mobile_project/provider/events.dart';
import 'package:mobile_project/models/cart.dart';
import 'package:mobile_project/models/orders.dart';
//import 'package:mobile_project/screens/User_HomeScreen.dart';
import 'package:mobile_project/provider/userAddNotifier.dart';
import 'package:mobile_project/screens/User_HomeScreen.dart';
import 'package:provider/provider.dart';
import 'package:mobile_project/screens/product_detail_screen.dart';
import 'package:mobile_project/screens/cart_screen.dart';
import 'package:mobile_project/screens/orders_screen.dart';
import 'package:mobile_project/screens/edit_product_screen.dart';
import 'package:mobile_project/screens/user_products_screen.dart';
import 'package:mobile_project/loginpage.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:mobile_project/provider/userAddNotifier.dart';
//import './screens/products_overview_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

/*class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return UserAddNotifer();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
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
        ChangeNotifierProvider<UserAddNotifer>(
          create: (BuildContext context) {
            return UserAddNotifer();
          },
        ),
        ChangeNotifierProvider.value(
          value: Events(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Event organizer',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            accentColor: Colors.cyan,
            fontFamily: 'Lato',
          ),
          home: EditProductScreen(),
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
