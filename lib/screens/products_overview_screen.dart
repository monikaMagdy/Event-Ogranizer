import 'package:flutter/material.dart';
import 'package:mobile_project/create_event.dart';
import 'package:mobile_project/join_event.dart';
import 'package:mobile_project/screens/User_HomeScreen.dart';
import 'package:mobile_project/googleMaps.dart';
//import 'package:flutter/services.dart';
import 'package:provider/provider.dart' as provider;
import 'package:mobile_project/widgets/badge.dart';
import 'package:mobile_project/models/cart.dart';
import 'package:mobile_project/screens/cart_screen.dart';

import 'package:mobile_project/widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import 'package:mobile_project/widgets/products_grid.dart';

enum FilterOptions {
  Favorites,
  All,
}
bool _showOnlyFavorites = false;

class ProductsOverviewScreenLess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {},
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ProductsGrid(_showOnlyFavorites),
      ),
    );
  }
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _currentIndex = 0;

  final List<Widget> _children = [
    ProductsOverviewScreenLess(),
    Createevent(),
    JoinEvent(),
    HomeScreen(),
  ];

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event organizer'),
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
          provider.Consumer<Cart>(
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
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
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
