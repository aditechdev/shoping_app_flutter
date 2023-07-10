import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shoping_app/global_variables.dart';

class ProductProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _productProvider = [];

  querryProductList({String? company}) {
    List<Map<String, dynamic>> data = [];
    log("company $company");

    products;
    if (company == null || company == "All") {
      data = products;
    } else {
      data = products
          .where(
            (e) =>
                e["company"].toString().toLowerCase() == company.toLowerCase(),
          )
          .toList();
      // log("here $data");
    }
    _productProvider.addAll(data);

    notifyListeners();
  }

  List<Map<String, dynamic>> get getProductList => _productProvider;
}
