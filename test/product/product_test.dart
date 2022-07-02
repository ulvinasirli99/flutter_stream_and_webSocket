import 'package:dio/dio.dart';
import 'package:flutter_stream/domain/network/rest_client.dart';
import 'package:flutter_stream/model/product.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late RestClient client;
  Product product;
  test(
    "Test a Product Api",
    () async {
      client = RestClient(Dio());
      product = Product();
      product = await client.getAllProducts();
      expect(product, isNotNull);
    },
  );
}
