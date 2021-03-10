//import 'package:flutter/material.dart';
//import 'package:provider/provider.dart' as provider;
//
//import '../widgets/app_drawer.dart';
//import '../widgets/products_grid.dart';
//import '../widgets/badge.dart';
//import '../models/cart.dart';
//import './cart_screen.dart';
//
//enum FilterOptions {
//  Favorites,
//  All,
//}
//
//class ProductsOverviewScreen extends StatefulWidget {
//  @override
//  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
//}
//
//class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
//  var _showOnlyFavorites = false;
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('MyShop'),
//        actions: <Widget>[
//          PopupMenuButton(
//            onSelected: (FilterOptions selectedValue) {
//              setState(() {
//                if (selectedValue == FilterOptions.Favorites) {
//                  _showOnlyFavorites = true;
//                } else {
//                  _showOnlyFavorites = false;
//                }
//              });
//            },
//            icon: Icon(
//              Icons.more_vert,
//            ),
//            itemBuilder: (_) => [
//              PopupMenuItem(
//                child: Text('Only Favorites'),
//                value: FilterOptions.Favorites,
//              ),
//              PopupMenuItem(
//                child: Text('Show All'),
//                value: FilterOptions.All,
//              ),
//            ],
//          ),
//          provider.Consumer<Cart>(
//            builder: (_, cart, ch) => Badge(
//              child: ch,
//              value: cart.itemCount.toString(),
//            ),
//            child: IconButton(
//              icon: Icon(
//                Icons.shopping_cart,
//              ),
//              onPressed: () {
//                Navigator.of(context).pushNamed(CartScreen.routeName);
//              },
//            ),
//          ),
//        ],
//      ),
//      drawer: AppDrawer(),
//      body: ProductsGrid(_showOnlyFavorites),
//    );
//  }
//}

// import 'package:flutter/material.dart';
// import 'package:mobile_project/create_event.dart';
// import 'package:mobile_project/join_event.dart';
// import 'package:mobile_project/screens/User_HomeScreen.dart';
// import 'package:mobile_project/googleMaps.dart';
// //import 'package:flutter/services.dart';
// import 'package:provider/provider.dart' as provider;
// import 'package:mobile_project/widgets/badge.dart';
// import 'package:mobile_project/models/cart.dart';
// import 'package:mobile_project/screens/cart_screen.dart';

// import 'package:mobile_project/widgets/app_drawer.dart';
// import 'package:provider/provider.dart';
// import 'package:mobile_project/widgets/products_grid.dart';

// enum FilterOptions {
//   Favorites,
//   All,
// }
// bool _showOnlyFavorites = false;

// class ProductsOverviewScreenLess extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (BuildContext context) {},
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: ProductsGrid(_showOnlyFavorites),
//       ),
//     );
//   }
// }

// class ProductsOverviewScreen extends StatefulWidget {
//   @override
//   _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
// }

// class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
//   var _currentIndex = 0;

//   final List<Widget> _children = [
//     ProductsOverviewScreenLess(),
//     Createevent(),
//     JoinEvent(),
//     HomeScreen(),
//   ];

//   void onTappedBar(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Event organizer'),
//         actions: <Widget>[
//           PopupMenuButton(
//             onSelected: (FilterOptions selectedValue) {
//               setState(() {
//                 if (selectedValue == FilterOptions.Favorites) {
//                   _showOnlyFavorites = true;
//                 } else {
//                   _showOnlyFavorites = false;
//                 }
//               });
//             },
//             icon: Icon(
//               Icons.more_vert,
//             ),
//             itemBuilder: (_) => [
//               PopupMenuItem(
//                 child: Text('Only Favorites'),
//                 value: FilterOptions.Favorites,
//               ),
//               PopupMenuItem(
//                 child: Text('Show All'),
//                 value: FilterOptions.All,
//               ),
//             ],
//           ),
//           provider.Consumer<Cart>(
//             builder: (_, cart, ch) => Badge(
//               child: ch,
//               value: cart.itemCount.toString(),
//             ),
//             child: IconButton(
//               icon: Icon(
//                 Icons.shopping_cart,
//               ),
//               onPressed: () {
//                 Navigator.of(context).pushNamed(CartScreen.routeName);
//               },
//             ),
//           ),
//         ],
//       ),
//       drawer: AppDrawer(),
//       body: _children[_currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         onTap: onTappedBar,
//         currentIndex: _currentIndex,
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//             backgroundColor: Colors.indigo[100],
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.add),
//             label: 'Create Event',
//             backgroundColor: Colors.indigo[100],
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.maps_ugc_outlined),
//             label: 'Google Maps',
//             backgroundColor: Colors.indigo[100],
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.search),
//             label: 'Search Event',
//             backgroundColor: Colors.indigo[100],
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'profile',
//             backgroundColor: Colors.indigo[100],
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:mobile_project/provider/events.dart';
import 'package:mobile_project/screens/searchScreen.dart';
import 'package:mobile_project/screens/user_events_screen.dart';
import 'package:mobile_project/widgets/badge.dart';
import 'package:mobile_project/models/cart.dart';
import 'package:mobile_project/screens/cart_screen.dart';
import 'package:mobile_project/widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import 'package:mobile_project/widgets/event_grid.dart';
import 'edit_event_screen.dart';

class ButtonMenu extends StatefulWidget {
  @override
  _ButtonMenuState createState() => _ButtonMenuState();
}

class _ButtonMenuState extends State<ButtonMenu> {
  final List<Widget> _children = [
    EventsOverviewScreen(),
    EditEventScreen(),
    UserEventsScreen(),
    ListViewSearch()
    //AuthService().signOut();
  ];
  int _currentIndex = 0;

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTappedBar,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.indigo[100],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Create Event',
            backgroundColor: Colors.indigo[100],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.maps_ugc_outlined),
            label: 'Google Maps',
            backgroundColor: Colors.indigo[100],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search Event',
            backgroundColor: Colors.indigo[100],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'profile',
            backgroundColor: Colors.indigo[100],
          ),
        ],
      ),
    );
  }
}

enum FilterOptions {
  Favorites,
  All,
}

class EventsOverviewScreen extends StatefulWidget {
  //final _userName;
  //EventsOverviewScreen(this._userName);
  @override
  _EventsOverviewScreenState createState() => _EventsOverviewScreenState();
}

class _EventsOverviewScreenState extends State<EventsOverviewScreen> {
  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Events>(context).fetchAndSetEvents().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' Events'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : EventsGrid(_showOnlyFavorites),
    );
  }
}
