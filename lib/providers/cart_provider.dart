import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> cart = [];

  addProduct(Map<String, dynamic> product) {
    // Check if the product already exists in the cart
    int existingProductIndex = cart.indexWhere((item) =>
        item['id'] == product['id'] && item["size"] == product["size"]);

    if (existingProductIndex != -1) {
      // Product already exists, increase the count
      cart[existingProductIndex]['count']++;
    } else {
      // Product doesn't exist, add it to the cart
      product['count'] = 1; // Add a 'count' field to track the quantity
      cart.add(product);
    }

    notifyListeners();
  }

  removeProduct(Map<String, dynamic> product) {
    cart.remove(product);
    notifyListeners();
  }

  placeOrder() {
    cart.clear();
  }
}
