import 'package:flutter/material.dart';
import 'package:shoping_app/global_variables.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                  onPressed: () {},
                  icon: const Icon(Icons.delete),
                  color: Colors.red,
                ),
              );

              // Text(["title"] as String);
            }));
  }
}
