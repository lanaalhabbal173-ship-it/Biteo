import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class ProfileService {
  final Dio dio = Dio();
  final GetStorage box = GetStorage();

  static const String baseUrl = "http://10.33.220.76:8080/api";

  Options get _options {
    final token = box.read("token");

    return Options(
      headers: {"Authorization": "Bearer $token", "Accept": "application/json"},
    );
  }

  Future<Response> getProfile() async {
    return await dio.get("$baseUrl/profile", options: _options);
  }

  Future<Response> updateProfile({
    required String name,
    required String email,
  }) async {
    return await dio.put(
      "$baseUrl/profile",
      data: {"name": name, "email": email},
      options: _options,
    );
  }
}
