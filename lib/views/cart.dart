import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marvel_comics/controllers/cart_controller.dart';
import 'package:marvel_comics/models/comic_model.dart';
import 'package:marvel_comics/views/maps.dart';
import 'package:marvel_comics/widgets/my_dialogs.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartController>(
      builder: (BuildContext context, CartController cart, Widget child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Cart'),
            centerTitle: true,
            actions: <Widget>[
              Visibility(
                visible: cart.cartCount > 0 ? true : false,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: GestureDetector(
                    onTap: () => MyDialogs.yesNo(
                      context: context,
                      title: 'Empty Cart',
                      message: 'Are You sure?',
                      noLabel: 'No',
                      yesLabel: 'Yes',
                      onYes: cart.clear,
                    ),
                    child: Icon(Icons.delete_sweep),
                  ),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      ComicModel comic = cart.cart.elementAt(index);
                      return _buildItem(comic, cart);
                    },
                    itemCount: cart.cartCount,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => Maps(),
                      ),
                    ),
                    label: Text('Send Me (${cart.cartCount})'),
                    icon: Icon(Icons.delivery_dining),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildItem(ComicModel comic, CartController cart) {
    String url = comic.thumbnail.replaceAll('http', 'https');
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CachedNetworkImage(
                imageUrl: '$url/portrait_uncanny.jpg',
                width: 70,
                placeholder: (BuildContext context, String url) =>
                    CircularProgressIndicator(),
                errorWidget:
                    (BuildContext context, String url, dynamic error) =>
                        Icon(Icons.error),
              ),
            ),
            Expanded(
              child: Text(
                comic.title,
                textScaleFactor: 1.2,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ),
            TextButton(
              onPressed: () => cart.deleteItem(comic),
              child: Icon(
                Icons.delete,
                color: Colors.white38,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
