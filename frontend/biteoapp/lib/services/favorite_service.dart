import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class FavoriteService {
  static const String baseUrl = "http://10.33.220.76:8080/api";

  final Dio dio = Dio();
  final GetStorage box = GetStorage();

  Options get _options {
    final token = box.read('token');

    return Options(
      headers: {"Authorization": "Bearer $token", "Accept": "application/json"},
    );
  }

  // =========================
  // GET FAVORITES
  // =========================

  Future<Response> getFavorites() async {
    return await dio.get("$baseUrl/favorites", options: _options);
  }

  // =========================
  // ADD FAVORITE
  // =========================

  Future<Response> addFavorite(int productId) async {
    return await dio.post("$baseUrl/favorites/$productId", options: _options);
  }

  // =========================
  // REMOVE FAVORITE
  // =========================

  Future<Response> removeFavorite(int productId) async {
    return await dio.delete("$baseUrl/favorites/$productId", options: _options);
  }
}
