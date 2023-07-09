import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_app/providers/cart_provider.dart';

class ProductDetailsPage extends StatefulWidget {
  final Map<String, dynamic> product;
  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late int selectedSize;

  @override
  void initState() {
    super.initState();
    deselectSize();
  }

  addToCart() {
    if (selectedSize == -1) {
      return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(milliseconds: 500),
          content: Text("Please Select a size!")));
    }

    Provider.of<CartProvider>(context, listen: false).addProduct({
      'id': widget.product["id"],
      'title': widget.product["title"],
      'price': widget.product["price"],
      'imageUrl': widget.product["imageUrl"],
      'company': widget.product["company"],
      'size': selectedSize,
    });

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(milliseconds: 500),
        content: Text("Product added successfully!")));

    // widget.product
  }

  selectSize(int size) {
    if (selectedSize == size) {
      deselectSize();
    } else {
      selectedSize = size;
    }
    setState(() {});
  }

  deselectSize() {
    selectedSize = -1;
  }

  @override
  Widget build(BuildContext context) {
    log("LISSTTTTT => ${Provider.of<CartProvider>(context).cart}");
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final size = widget.product["sizes"];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
      ),
      body: Column(
        children: [
          Text(
            widget.product["title"] as String,
            style: textTheme.titleLarge,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(widget.product['imageUrl']),
          ),
          const Spacer(
            flex: 2,
          ),
          Container(
            height: 250,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(245, 247, 249, 1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "\$ ${widget.product["price"]}",
                  style: textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: size.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            selectSize(size[index]);
                          },
                          child: Chip(
                            backgroundColor: (selectedSize == size[index])
                                ? theme.colorScheme.primary
                                : Colors.transparent,
                            label: Text(
                              size[index].toString(),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(
                    20.0,
                  ),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        minimumSize: const Size(double.infinity, 50)),
                    onPressed: addToCart,
                    icon: const Icon(
                      Icons.shopping_cart,
                      color: Colors.black,
                    ),
                    label: const Text(
                      "Add to cart",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
