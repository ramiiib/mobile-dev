import 'package:deliverable_2/Models/food.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'shared_preferences.dart';

class CartModel with ChangeNotifier {
  List<CartItem> cart = [];
  final SharedPreferencesService _prefsService = SharedPreferencesService();

  void addFood(Food product, int quantity, String size) {
    CartItem? existingItem = cart.firstWhereOrNull(
        (item) => item.food.name == product.name && item.size == size);

    if (existingItem != null) {
      existingItem.quantity += quantity;
    } else {
      cart.add(CartItem(food: product, quantity: quantity, size: size));
    }
    notifyListeners();
  }

  double get total {
    return cart.fold(0.0,
        (sum, item) => sum + item.quantity * double.parse(item.food.price));
  }

  void removeItem(int index) {
    if (index >= 0 && index < cart.length) {
      cart.removeAt(index);
      notifyListeners();
    }
  }

  void clearCart() {
    cart.clear();
    notifyListeners();
  }

  Future<void> checkout() async {
    if (cart.isEmpty) {
      throw "It seems like your cart is empty, maybe grab a coffee to drink?";
    }
    double total = this.total;
    await Future.delayed(const Duration(seconds: 2));
    await _prefsService.saveOrder(total);
    notifyListeners();
  }
}

class CartItem {
  final Food food;
  int quantity;
  final String size;

  CartItem({required this.food, required this.quantity, required this.size});
}
