import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_app/providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>().cart;
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text("CART"),
      ),
      body: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          var cartItem = cart[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(
                cartItem["imageUrl"] as String,
              ),
              radius: 30,
            ),
            title: Text(
              cartItem["title"] as String,
              style: textTheme.bodySmall,
            ),
            subtitle: Text("Size: ${cartItem["size"]}"),
            trailing: IconButton(
              onPressed: () {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          "Delete product",
                          style: textTheme.titleMedium,
                        ),
                        content: const Text(
                          "Are you sure, you want to remove the product from cart?",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "No",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              context
                                  .read<CartProvider>()
                                  .removeProduct(cartItem);
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Yes",
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      );
                    });
              },
              icon: const Icon(Icons.delete),
              color: Colors.red,
            ),
          );
        },
      ),
    );
  }
}
