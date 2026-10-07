import 'package:dio/dio.dart';

class BannerService {
  final Dio dio = Dio();

  final String baseUrl = "http://10.33.220.76:8080/api";

  Future<Response> getBanners() async {
    return await dio.get("$baseUrl/banners");
  }
}
