import 'package:flutter/material.dart';
import 'package:shoping_app/global_variables.dart';
import 'package:shoping_app/product_card.dart';
import 'package:shoping_app/product_details_page.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<String> filters = const ['All', 'Addidas', 'Nike', 'Bata'];
  late String selectedFilters;

  @override
  void initState() {
    super.initState();
    selectedFilters = filters[0];
  }

  Color getProductCardBackGroundColor(int index) {
    if (index.isEven) {
      return const Color.fromRGBO(216, 240, 253, 1);
    } else {
      return const Color.fromRGBO(245, 247, 249, 1);
    }
  }

  selectFilters(String filter) {
    selectedFilters = filter;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
        borderSide: BorderSide(
          color: Color.fromRGBO(
            225,
            225,
            225,
            1,
          ),
        ),
        borderRadius: BorderRadius.horizontal(left: Radius.circular(50)));
    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Shoes\nCollection",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                    prefixIcon: Icon(
                      Icons.search,
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 120,
            child: ListView.builder(
              itemCount: filters.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final filter = filters[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GestureDetector(
                    onTap: () {
                      selectFilters(filter);
                    },
                    child: Chip(
                      backgroundColor: (selectedFilters == filter)
                          ? Theme.of(context).colorScheme.primary
                          : const Color.fromRGBO(245, 247, 249, 1),
                      side: const BorderSide(
                        color: Color.fromRGBO(245, 247, 249, 1),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      labelStyle: const TextStyle(fontSize: 16),
                      label: Text(
                        filter,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          // fullscreenDialog: true,
                          // allowSnapshotting: true,

                          builder: (context) {
                        return ProductDetailsPage(
                          product: product,
                        );
                      }));
                    },
                    child: ProductCardWidget(
                      productName: "${product["title"]}",
                      price: "${product["price"]}",
                      imageUrl: "${product["imageUrl"]}",
                      backgroundColor: getProductCardBackGroundColor(index),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
