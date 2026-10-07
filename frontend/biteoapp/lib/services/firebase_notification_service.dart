import 'package:biteoapp/controllers/orders_controller.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FirebaseNotificationService {
  final FirebaseMessaging messaging =
      FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin
      localNotifications =
      FlutterLocalNotificationsPlugin();

  final Dio dio = Dio();
  final GetStorage box = GetStorage();

  static const String baseUrl =
      "http://10.33.220.76:8080/api";

  static const AndroidNotificationChannel channel =
      AndroidNotificationChannel(
    'biteo_orders',
    'Order Notifications',
    description:
        'Notifications for Biteo order updates',
    importance: Importance.high,
  );

  Future<String?> initialize() async {
    final settings =
        await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    print(
      "NOTIFICATION PERMISSION: "
      "${settings.authorizationStatus}",
    );

    const androidSettings =
        AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const initializationSettings =
        InitializationSettings(
      android: androidSettings,
    );

    await localNotifications.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse response) {
        print(
          "LOCAL NOTIFICATION CLICKED: "
          "${response.payload}",
        );

        _handleNotificationClick(
          response.payload,
        );
      },
    );

    await localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(
          channel,
        );

    final token =
        await messaging.getToken();

    print("FCM TOKEN: $token");

    if (token != null) {
      await saveToken(token);
    }

    messaging.onTokenRefresh.listen(
      (newToken) async {
        print(
          "FCM TOKEN REFRESHED: $newToken",
        );

        await saveToken(newToken);
      },
    );

    // =====================================
    // FOREGROUND
    // =====================================

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        print(
          "FOREGROUND TITLE: "
          "${message.notification?.title}",
        );

        print(
          "FOREGROUND BODY: "
          "${message.notification?.body}",
        );

        print(
          "FOREGROUND DATA: "
          "${message.data}",
        );

        await _showLocalNotification(
          message,
        );
      },
    );

    // =====================================
    // APP IN BACKGROUND
    // USER TAPS FCM NOTIFICATION
    // =====================================

    FirebaseMessaging.onMessageOpenedApp
        .listen(
      (RemoteMessage message) {
        print(
          "FCM NOTIFICATION OPENED: "
          "${message.data}",
        );

        _handleRemoteMessageClick(
          message,
        );
      },
    );

    // =====================================
    // APP WAS COMPLETELY CLOSED
    // AND OPENED FROM NOTIFICATION
    // =====================================

    final initialMessage =
        await messaging.getInitialMessage();

    if (initialMessage != null) {
      print(
        "APP OPENED FROM TERMINATED "
        "NOTIFICATION: "
        "${initialMessage.data}",
      );

      // نعطي GetMaterialApp وقت يشتغل
      Future.delayed(
        const Duration(
          milliseconds: 1200,
        ),
        () {
          _handleRemoteMessageClick(
            initialMessage,
          );
        },
      );
    }

    return token;
  }

  Future<void> _showLocalNotification(
    RemoteMessage message,
  ) async {
    final notification =
        message.notification;

    if (notification == null) {
      return;
    }

    final orderId =
        message.data['order_id']
            ?.toString();

    final payload =
        orderId != null
            ? "order:$orderId"
            : null;

    const androidDetails =
        AndroidNotificationDetails(
      'biteo_orders',
      'Order Notifications',
      channelDescription:
          'Notifications for Biteo order updates',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      icon: '@mipmap/ic_launcher',
    );

    const details =
        NotificationDetails(
      android: androidDetails,
    );

    await localNotifications.show(
      id: notification.hashCode,
      title:
          notification.title ?? 'Biteo',
      body:
          notification.body ?? '',
      notificationDetails: details,
      payload: payload,
    );
  }

  // =====================================
  // LOCAL NOTIFICATION CLICK
  // =====================================

  void _handleNotificationClick(
    String? payload,
  ) {
    if (payload == null) {
      return;
    }

    print(
      "NOTIFICATION PAYLOAD: $payload",
    );

    if (payload.startsWith("order:")) {
      final orderIdString =
          payload.replaceFirst(
        "order:",
        "",
      );

      final orderId =
          int.tryParse(
        orderIdString,
      );

      if (orderId != null) {
        _openOrder(orderId);
      }
    }
  }

  // =====================================
  // FCM NOTIFICATION CLICK
  // =====================================

  void _handleRemoteMessageClick(
    RemoteMessage message,
  ) {
    final type =
        message.data['type']
            ?.toString();

    final orderId =
        int.tryParse(
      message.data['order_id']
              ?.toString() ??
          '',
    );

    if (type == 'order' &&
        orderId != null) {
      _openOrder(orderId);
    }
  }

  // =====================================
  // OPEN ORDER DETAILS
  // =====================================

  Future<void> _openOrder(
    int orderId,
  ) async {
    print(
      "OPEN ORDER ID: $orderId",
    );

    try {
      OrdersController controller;

      if (Get.isRegistered<
          OrdersController>()) {
        controller =
            Get.find<
                OrdersController>();
      } else {
        controller =
            Get.put(
          OrdersController(),
        );
      }

      await controller
          .openOrderFromNotification(
        orderId,
      );
    } catch (e) {
      print(
        "OPEN ORDER ERROR: $e",
      );
    }
  }

  // =====================================
  // SAVE TOKEN IN LARAVEL
  // =====================================

  Future<void> saveToken(
    String token,
  ) async {
    try {
      final authToken =
          box.read("token");

      if (authToken == null) {
        print(
          "FCM TOKEN NOT SAVED: "
          "User not logged in",
        );

        return;
      }

      final response =
          await dio.post(
        "$baseUrl/device-token",

        data: {
          "fcm_token": token,
        },

        options: Options(
          headers: {
            "Authorization":
                "Bearer $authToken",
            "Accept":
                "application/json",
          },
        ),
      );

      print(
        "FCM TOKEN SAVED: "
        "${response.data}",
      );
    } catch (e) {
      print(
        "FCM TOKEN SAVE ERROR: $e",
      );
    }
  }
}