import 'package:flutter/material.dart';
import 'package:marvel_comics/models/comic_model.dart';

class CartController extends ChangeNotifier {
  List<ComicModel> _cart = <ComicModel>[];

  List<ComicModel> get cart => _cart;

  int get cartCount => _cart != null ? _cart.length : 0;

  void addItem(ComicModel comic) {
    _cart.add(comic);
    notifyListeners();
  }

  void deleteItem(ComicModel comic) {
    _cart.remove(comic);
    notifyListeners();
  }

  void clear() {
    _cart.clear();
    notifyListeners();
  }
}
