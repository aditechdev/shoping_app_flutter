import 'package:flutter/material.dart';
import 'package:shoping_app/global_variables.dart';

class ProductProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _productProvider = [];
  String _selectedFilter = 'All';

  String get getSelectedFilter => _selectedFilter;

  set selectedFilter(String filter) {
    _selectedFilter = filter;
    querryProductList();
  }

  void querryProductList() {
    List<Map<String, dynamic>> data = [];
    if (_selectedFilter == 'All') {
      data = products;
    } else {
      data = products
          .where(
            (e) =>
                e['company'].toString().toLowerCase() ==
                _selectedFilter.toLowerCase(),
          )
          .toList();
    }
    clearProduct();
    _productProvider.addAll(data);
    notifyListeners();
  }

  void searchProduct(String q) {
    List<Map<String, dynamic>> data = [];
    if (q.trim().isEmpty) {
      data = products;
    } else {
      data = products
          .where((e) => e['company']
              .toString()
              .toLowerCase()
              .contains(q.trim().toLowerCase()))
          .toList();
    }

    clearProduct();
    _productProvider.addAll(data);
    notifyListeners();
  }

  clearProduct() {
    _productProvider.clear();
  }

  List<Map<String, dynamic>> get getProductList => _productProvider;
}
