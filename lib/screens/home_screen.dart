import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/providers/cart_provider.dart';
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

        if (provider.error != null){
          return Center(
            child: Column(
              children: [
                Text(provider.error!),
                ElevatedButton(
                  onPressed: (){
                    provider.fetchProducts();
                  },
                  child: Text('Retry'),
                )
              ]
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: ()async{
            context.read<CartProvider>().clearCart();
            provider.fetchProducts();
          },
          child: ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            itemCount: provider.items.length,
            separatorBuilder: (ctx, idx)=> SizedBox(height: 8,),
            itemBuilder: (ctx, idx) {
              Product currentProduct = provider.items[idx];
              return Card(child: ProductItem(product: currentProduct));
            },
          ),
        );
      },
    );
  }
}