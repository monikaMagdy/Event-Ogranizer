import 'package:flutter/material.dart';
import 'models/event.dart';
import 'models/events.dart';
import 'package:provider/provider.dart';

import './screens/cart_screen.dart';
import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './models/events.dart';
import './models/cart.dart';
import './models/orders.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';

class Events extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // todo: implement build
    return MaterialApp(
      title: 'preview events',
      home: new Scaffold(
        body: DisplayEvents(),
      ),
    );
  }
}

class DisplayEvents extends StatefulWidget {
  _DisplayEvents createState() => _DisplayEvents();
}

class _DisplayEvents extends State<DisplayEvents> {
  EventData eventData = new EventData();

  List<Event> list;

  @override
  void initState() {
    list = eventData.eventDB;
  }

  void refresh() {
    setState(() {
      list = eventData.eventDB;
    });
  }

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
          home: ProductsOverviewScreen(),
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

// class FavoriteWidget extends StatefulWidget {
//   final bool fav;

//   const FavoriteWidget({Key key, this.fav}) : super(key: key);

//   @override
//   _FavoriteWidget createState() => _FavoriteWidget();
// }

// class _FavoriteWidget extends State<FavoriteWidget> {
//   bool _isFavorited;
//   @override
//   void initState() {
//     _isFavorited = widget.fav;
//   }

//   int _favoriteCount = 41;
//   void _toggleFavorite() {
//     setState(() {
//       if (_isFavorited) {
//         _favoriteCount -= 1;
//         _isFavorited = false;
//       } else {
//         _favoriteCount += 1;
//         _isFavorited = true;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           padding: EdgeInsets.all(0),
//           child: IconButton(
//             padding: EdgeInsets.all(0),
//             alignment: Alignment.centerRight,
//             icon: (_isFavorited ? Icon(Icons.star) : Icon(Icons.star_border)),
//             color: _isFavorited ? Colors.red : null,
//             onPressed: _toggleFavorite,
//           ),
//         ),
//         SizedBox(
//           width: 18,
//           child: Container(
//             child: Text('$_favoriteCount'),
//           ),
//         ),
//       ],
//     );
//   }
// }
