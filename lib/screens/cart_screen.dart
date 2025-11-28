import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:shop_app/widgets/product_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, provider, _) {
        if (provider.items.isEmpty){
          return _buildEmptyState();
        }
        return ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          itemCount: provider.items.length,
          separatorBuilder: (ctx, idx) => Divider(),
          itemBuilder: (ctx, idx){
            final currentProduct = provider.items[idx];
            return ProductItem(product: currentProduct);
          }
        );
      },
    );
  }

  Widget _buildEmptyState(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add_shopping_cart_sharp, size: 72,),
          Text(
            'Empty Cart',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text('Add items to the cart and it will show up here')
        ],
      ),
    );
  }
}