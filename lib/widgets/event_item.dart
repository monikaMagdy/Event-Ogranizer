import 'package:flutter/material.dart';
import 'package:mobile_project/provider/userAddNotifier.dart';
import 'package:provider/provider.dart';

import '../screens/Event_detail_screen.dart';
import '../models/event.dart';
import '../models/cart.dart';

class EventItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final event = Provider.of<Event>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final authen = Provider.of<UserAddNotifer>(context, listen: false);
    print('EventItem built again');
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              EventDetailScreen.routeName,
              arguments: event.id,
            );
          },
          child: Image.network(
            event.image,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Event>(
            builder: (ctx, event, _) => IconButton(
              icon: Icon(
                event.isFavorite ? Icons.favorite : Icons.favorite_border,
              ),
              color: Theme.of(context).accentColor,
              onPressed: () {
                event.toggleFavoriteStatus(authen.token, authen.userID);
              },
            ),
          ),
          title: Text(
            event.eventName,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {
              cart.addItem(event.id.toString(), event.minimumCharge.toDouble(),
                  event.eventName);
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Added item to cart!',
                  ),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      cart.removeSingleItem(event.id.toString());
                    },
                  ),
                ),
              );
            },
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
