import 'package:dio/dio.dart';

class ProductService {
  static const String baseUrl = "http://10.33.220.76:8080/api";

  final Dio dio = Dio();

  Future<Response> searchProducts(String keyword) async {
    return await dio.get(
      "$baseUrl/products",
      queryParameters: {"search": keyword},
    );
  }
}
