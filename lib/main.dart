import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/skeleton.dart';

void main() {
  runApp(
    MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (ctx) {
            final productProvider = ProductsProvider();
            productProvider.fetchProducts();
            return productProvider;
          },
        ),
      ChangeNotifierProvider(create: (ctx)=>CartProvider())
    ],
    child: ShopApp()
    ));
}

class ShopApp extends StatelessWidget {
  const ShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF286E6B)),
      ),
      home: Skeleton(),
    );
  }
}

