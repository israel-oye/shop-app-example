import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/data/products.dart' as data;
import 'package:shop_app/models/product.dart';

class ProductsProvider extends ChangeNotifier{
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.npoint.io',
      headers: {
        'Content-Type': 'application/json'
      }
    )
  );
  final String endpoint = '/7e09ae95cabb76d14f1b';
  final List<Product> _items = [];

  List<Product> get items => _items;

  fetchProducts() async{
    final response = await dio.get(endpoint);
    final data = response.data as List<dynamic>;

    // data.map((item)=> Prod)
  }
  
}