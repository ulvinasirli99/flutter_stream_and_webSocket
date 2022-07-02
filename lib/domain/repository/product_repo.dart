import 'package:dio/dio.dart';
import 'package:flutter_stream/domain/network/rest_client.dart';
import 'package:flutter_stream/model/product.dart';

class ProductRepository {
  
  final RestClient _client = RestClient(Dio());
  
  Future<Product> getProductRepo() async {
  
    return await _client.getAllProducts();
  
  }

}
