import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class AddressService {
  final Dio dio = Dio();
  final GetStorage box = GetStorage();

  static const String baseUrl = "http://10.33.220.76:8080/api";

  Options get options {
    final token = box.read("token");
    return Options(
      headers: {"Authorization": "Bearer $token", "Accept": "application/json"},
    );
  }

  Future<Response> getAddresses() async {
    return await dio.get("$baseUrl/addresses", options: options);
  }

  Future<Response> addAddress({
    required String label,
    required String address,
    required String city,
    required String phone,
    required bool isDefault,
  }) async {
    return await dio.post(
      "$baseUrl/addresses",
      data: {
        "label": label,
        "address": address,
        "city": city,
        "phone": phone,
        "is_default": isDefault,
      },
      options: options,
    );
  }

  Future<Response> setDefault(int id) async {
    return await dio.put("$baseUrl/addresses/$id/default", options: options);
  }

  Future<Response> deleteAddress(int id) async {
    return await dio.delete("$baseUrl/addresses/$id", options: options);
  }
}
