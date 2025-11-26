import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/providers/cart_provider.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({super.key, required this.product});

  

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();
    return ListTile(
      leading: CircleAvatar(backgroundColor: product.avatar,),
      title: Text(product.name),
      subtitle: Text('₦ ${product.price.toStringAsFixed(2)}'),
      trailing: Checkbox(
        value: cartProvider.items.contains(product), 
        onChanged: (checked){
          if(checked == true){
            cartProvider.addToCart(product);
          } else {
            cartProvider.removeFromCart(product);
          }
        }
      ),      
    );
  }
}