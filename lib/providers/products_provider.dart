import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
  String? _error;
  bool _isLoading = false;
  List<Product> _items = [];

  List<Product> get items => _items;
  String? get error => _error;
  bool get isLoading => _isLoading;

  Future<void> fetchProducts() async{
    _isLoading = true;
    notifyListeners();

    try {
      final response = await dio.get(endpoint);
      final data = response.data as List<dynamic>;

      _items = data.map((item) => Product.fromJson(item)).toList();
    } on DioException catch (e) {
      _error = e.message;
    } finally{
      _isLoading = false;
      notifyListeners();
    }
    
  }
  
}