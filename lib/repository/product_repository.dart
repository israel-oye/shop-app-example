import 'package:shop_app/models/product.dart';
import 'package:shop_app/services/api_service.dart';

class ProductRepository {
  final ApiService _service;

  ProductRepository({required ApiService service}): _service = service;

  Future<List<Product>> fetchProducts(){
    return _service.getProducts();
  }
}