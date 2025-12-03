import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/repository/product_repository.dart';

class ProductsProvider extends ChangeNotifier{
  final ProductRepository _repository;
  String? _error;
  bool _isLoading = false;
  List<Product> _items = [];

  List<Product> get items => _items;
  String? get error => _error;
  bool get isLoading => _isLoading;

  ProductsProvider(this._repository);

  Future<void> fetchProducts() async{
    _isLoading = true;
    notifyListeners();

    try {
      _items = await _repository.fetchProducts();
    } on DioException catch (e) {
      _error = e.message;
    } 
    on Exception catch (e){
      _error = e.toString();
    } finally{
      _isLoading = false;
      notifyListeners();
    }
    
  }
  
}