import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/widgets/product_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {   
    

    return Consumer<ProductsProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return RefreshIndicator(
          onRefresh: ()async{
            provider.fetchProducts();
          },
          child: ListView.builder(
            itemCount: provider.items.length,
            itemBuilder: (ctx, idx) {
              Product currentProduct = provider.items[idx];
              return ProductItem(product: currentProduct);
            },
          ),
        );
      },
    );
  }
}