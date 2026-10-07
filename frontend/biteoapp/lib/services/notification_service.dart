import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class NotificationService {
  final Dio dio = Dio();
  final GetStorage box = GetStorage();

  static const String baseUrl =
      "http://10.33.220.76:8080/api";

  Options get options {
    final token = box.read("token");

    return Options(
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      },
    );
  }

  Future<Response> getNotifications() async {
    return await dio.get(
      "$baseUrl/notifications",
      options: options,
    );
  }

  Future<Response> getUnreadCount() async {
    return await dio.get(
      "$baseUrl/notifications/unread-count",
      options: options,
    );
  }

  Future<Response> markAsRead(
    String id,
  ) async {
    return await dio.put(
      "$baseUrl/notifications/$id/read",
      options: options,
    );
  }

  Future<Response> deleteNotification(
    String id,
  ) async {
    return await dio.delete(
      "$baseUrl/notifications/$id",
      options: options,
    );
  }
}