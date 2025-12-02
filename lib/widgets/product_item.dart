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
      onTap: (){
        showModalBottomSheet(
          context: context, 
          builder: (ctx)=> ProductDetail(product: product));
      },
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


class ProductDetail extends StatelessWidget {
  final Product product;
  const ProductDetail({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(colors: [
                  product.avatar,
                  product.avatar.withAlpha(150),
                ])
              ),
            ),
            SizedBox(height: 8,),
            Text(product.name, style: TextStyle(fontSize: 24),)
          ],
        ),
      ),
    );
  }
}