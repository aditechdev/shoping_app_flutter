import 'package:flutter/material.dart';

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({
    super.key,
    required this.imageUrl,
    required this.price,
    required this.productName,
    required this.backgroundColor,
  });
  final String productName;
  final String imageUrl;
  final String price;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    final txtTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: backgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            productName,
            style: txtTheme.titleMedium,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            '\$ $price',
            style: txtTheme.bodySmall,
          ),
          const SizedBox(
            height: 5,
          ),
          Center(
            child: Image.asset(
              imageUrl,
              height: 165,
            ),
          ),
        ],
      ),
    );
  }
}
