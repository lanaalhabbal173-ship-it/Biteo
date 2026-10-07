import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class CartService {
  final Dio dio = Dio();

  static const String baseUrl = "http://10.33.220.76:8080/api";

  final box = GetStorage();

  Future<Response> addToCart({
    required int productId,
    required int quantity,
    required String size,
    required String temperature,
    required List<String> extras,
  }) async {
    final token = box.read("token");

    return await dio.post(
      "$baseUrl/cart/add",
      data: {
        "product_id": productId,
        "quantity": quantity,
        "size": size,
        "temperature": temperature,
        "extras": extras,
      },
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      ),
    );
  }

  Future<Response> getCart() async {
    final token = box.read("token");

    return await dio.get(
      "$baseUrl/cart",
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      ),
    );
  }

  Future<Response> removeItem(int id) async {
    final token = box.read("token");

    return await dio.delete(
      "$baseUrl/cart/remove/$id",
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      ),
    );
  }

  Future<Response> updateQuantity({
    required int itemId,
    required int quantity,
  }) async {
    final token = box.read("token");

    return await dio.put(
      "$baseUrl/cart/update/$itemId",
      data: {"quantity": quantity},
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      ),
    );
  }
}
