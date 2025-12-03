import 'package:dio/dio.dart';
import 'package:shop_app/models/product.dart';

class ApiService{
  final _dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.npoint.io',
      headers: {'Content-Type': 'application/json'},
    ),
  );
  final String endpoint = '/7e09ae95cabb76d14f1b';

  Future<List<Product>> getProducts() async{
    final response = await _dio.get(endpoint);
    final data = response.data as List<dynamic>;
    final products = data.map((item) => Product.fromJson(item)).toList();
    return products;
  }
}