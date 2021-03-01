import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'
    show
        BuildContext,
        Colors,
        FutureBuilder,
        MaterialApp,
        StatelessWidget,
        ThemeData,
        Widget,
        WidgetsFlutterBinding,
        runApp;
import 'package:mobile_project/models/event.dart';
import 'package:mobile_project/provider/AddUserScreen.dart';
import 'package:mobile_project/provider/OrderProvider.dart';
import 'package:mobile_project/provider/events.dart';
import 'package:mobile_project/models/cart.dart';
import 'package:mobile_project/models/orders.dart';
import 'package:mobile_project/provider/userAddNotifier.dart';
import 'package:mobile_project/screens/products_overview_screen.dart';
import 'package:mobile_project/screens/splashScreen.dart';
import 'package:provider/provider.dart';
import 'package:mobile_project/screens/product_detail_screen.dart';
import 'package:mobile_project/screens/cart_screen.dart';
import 'package:mobile_project/screens/orders_screen.dart';
import 'package:mobile_project/screens/edit_product_screen.dart';
import 'package:mobile_project/screens/user_products_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mobile_project/provider/events.dart';

void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserAddNotifer(),
      child: MyApp(),
    ),
  );
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
        ChangeNotifierProxyProvider<UserAddNotifer, Events>(
          create: (_) => Events(
              Provider.of<UserAddNotifer>(context, listen: true).token,
              Provider.of<UserAddNotifer>(context, listen: true).userID, []),
          update: (ctx, authen, events) =>
              events..takeToken(authen, events.eventDB),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProxyProvider<UserAddNotifer, OrderProvider>(
          create: (_) => OrderProvider(
              Provider.of<UserAddNotifer>(context, listen: false).token,
              Provider.of<UserAddNotifer>(context, listen: false).userID, []),
          update: (ctx, authen, previousOrder) =>
              previousOrder..takeToken(authen, previousOrder.orders),
        ),
        //ChangeNotifierProvider<UserAddNotifer>(
        //  create: (BuildContext context) {
        //    return UserAddNotifer();
        //  },
        //),
        //ChangeNotifierProvider.value(
        //  value: Events(),
        //),
        //ChangeNotifierProvider.value(
        //  value: Cart(),
        //),
        //ChangeNotifierProvider.value(
        //  value: OrderProvider(),
        //),
      ],
      child: Consumer<UserAddNotifer>(
        builder: (ctx, authen, _) => MaterialApp(
          title: 'eventOrganizer',
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
          ),
          home: authen.isAuthen
              ? ProductsOverviewScreen()
              : FutureBuilder(
                  future: authen.autoLogin(),
                  builder: (ctx, autResSnapshot) =>
                      autResSnapshot.connectionState == ConnectionState.waiting
                          ? SplashScreen()
                          : SignUpForm(),
                ),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
          },
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
