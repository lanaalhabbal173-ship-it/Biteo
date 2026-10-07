import 'package:dio/dio.dart';

class HomeService {
  final Dio dio = Dio();

  static const String baseUrl = "http://10.33.220.76:8080/api";

  Future<Response> getCategories() async {
    return await dio.get("$baseUrl/categories");
  }

  Future<Response> getProducts({int? categoryId, bool? offersOnly}) async {
    return await dio.get(
      "$baseUrl/products",
      queryParameters: {
        if (categoryId != null) "category_id": categoryId,

        if (offersOnly == true) "offers": 1,
      },
    );
  }

  Future<Response> searchProducts(String keyword) async {
    return await dio.get(
      "$baseUrl/products",
      queryParameters: {"search": keyword},
    );
  }

  Future<Response> getOffers() async {
    return await dio.get("$baseUrl/products", queryParameters: {"offers": 1});
  }
}
