import 'package:flutter_stream/domain/repository/product_repo.dart';
import 'package:flutter_stream/model/product.dart';
import 'package:rxdart/rxdart.dart';

class ProductCubit {

  final ProductRepository _productRepository = ProductRepository();


  final BehaviorSubject<Product> _behaviorSubject = BehaviorSubject<Product>();

  BehaviorSubject<Product> get productSubject => _behaviorSubject;

  getProductRestult() async {
  
    Product product = await _productRepository.getProductRepo();
  
    _behaviorSubject.sink.add(product);
  
  }

  dispose() {
    _behaviorSubject.close();
  }

}
