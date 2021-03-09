import 'package:firebase_core/firebase_core.dart';
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

import 'package:mobile_project/provider/OrderProvider.dart';
import 'package:mobile_project/provider/events.dart';
import 'package:mobile_project/models/cart.dart';

import 'package:mobile_project/provider/userAddNotifier.dart';
import 'package:mobile_project/screens/AddUserScreen.dart';
import 'package:mobile_project/screens/push_notification_screen.dart';

import 'package:mobile_project/screens/splashScreen.dart';
import 'package:provider/provider.dart';
import 'package:mobile_project/screens/Event_detail_screen.dart';
import 'package:mobile_project/screens/cart_screen.dart';
import 'package:mobile_project/screens/orders_screen.dart';
import 'package:mobile_project/screens/edit_event_screen.dart';
import 'package:mobile_project/screens/user_events_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    // ChangeNotifierProvider(
    // create: (context) => UserAddNotifer(),
    // child:
    MyApp(),
    // ),
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
          value: OrderProvider(),
        ),
      ],
      child: Consumer<UserAddNotifer>(
        builder: (ctx, authen, _) => MaterialApp(
          title: 'eventOrganizer',
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
            accentColor: Colors.purpleAccent,
            fontFamily: 'Lato',
          ),
          home: SplashScreen(),
          routes: {
            EventDetailScreen.routeName: (ctx) => EventDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserEventsScreen.routeName: (ctx) => UserEventsScreen(),
            EditEventScreen.routeName: (ctx) => EditEventScreen(),
          },
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
    //return MaterialApp(
    //  home: TestScreen(),
    //);
    // monica
    //i'm here
  }
}
