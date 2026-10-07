import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class OrderService {
  final Dio dio = Dio();

  static const String baseUrl =
      "http://10.33.220.76:8080/api";

  final box = GetStorage();

  Options get _options {
    final token = box.read("token");

    return Options(
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      },
    );
  }

  Future<Response> getOrders() async {
    return await dio.get(
      "$baseUrl/orders",
      options: _options,
    );
  }

  Future<Response> getOrderById(
    int id,
  ) async {
    return await dio.get(
      "$baseUrl/orders/$id",
      options: _options,
    );
  }

  Future<Response> checkout() async {
    return await dio.post(
      "$baseUrl/checkout",
      options: _options,
    );
  }
}