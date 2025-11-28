import 'package:flutter/material.dart';
import 'package:shop_app/models/product.dart';

class CartProvider extends ChangeNotifier{
  final List<Product> _items = [];

  List<Product> get items => _items;

  double get totalPrice{
    double total =_items.fold(0.0, (previousValue, nextItem) {
      return previousValue + nextItem.price;
    });
    return total;
  }

  void addToCart(Product product){
    _items.add(product);
    notifyListeners();
  }

  void removeFromCart(Product product){
    _items.remove(product);
    notifyListeners();
  }

  void clearCart(){
    _items.clear();
    notifyListeners();
  }
}