import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  void addItem(Map<String, dynamic> item) {

    bool found = false;
    for (var i = 0; i < _cartItems.length; i++) {
      if (_cartItems[i]['name'] == item['name'] && _cartItems[i]['size'] == item['size']) {
        _cartItems[i]['quantity'] += item['quantity'];
        _cartItems[i]['total'] = _cartItems[i]['quantity'] * _cartItems[i]['price'];
        found = true;
        break;
      }
    }
    if (!found) {
      _cartItems.add(item);
    }
    notifyListeners();
  }

  void removeItem(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  void updateItemQuantity(int index, int newQuantity) {
    if (newQuantity > 0) {
      _cartItems[index]['quantity'] = newQuantity;
      _cartItems[index]['total'] = _cartItems[index]['quantity'] * _cartItems[index]['price'];
      notifyListeners();
    } else {
      removeItem(index);
    }
  }

  int get totalCartPrice {
    return _cartItems.fold(0, (sum, item) => sum + (item['total'] as int));
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
} 