import 'package:dio/dio.dart';
import 'package:flutter_stream/const/constants.dart';
import 'package:flutter_stream/model/product.dart';
import 'package:retrofit/http.dart';
part 'rest_client.g.dart';

@RestApi(baseUrl: BASE_URL)
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;

  @GET(PATH)
  Future<Product> getAllProducts();
}
