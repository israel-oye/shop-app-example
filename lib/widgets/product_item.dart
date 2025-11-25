import 'package:flutter/material.dart';
import 'package:shop_app/models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundColor: product.avatar,),
      title: Text(product.name),
      subtitle: Text('₦ ${product.price.toStringAsFixed(2)}'),      
    );
  }
}