import 'package:biteoapp/services/firebase_notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../services/auth_service.dart';

class LoginController extends GetxController {
  final box = GetStorage();

  final AuthService service = AuthService();

  final FirebaseNotificationService firebaseNotificationService =
      FirebaseNotificationService();

  final email = TextEditingController();
  final password = TextEditingController();

  var isPasswordHidden = true.obs;
  var isLoading = false.obs;
  var rememberMe = false.obs;

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;

      final response = await service.login(email, password);

      print(response.data);

      // Save Laravel auth token
      await box.write('token', response.data['token']);

      // Get Firebase device token
      final fcmToken = await FirebaseMessaging.instance.getToken();

      print("LOGIN FCM TOKEN: $fcmToken");

      // Save FCM token in Laravel
      if (fcmToken != null) {
        await firebaseNotificationService.saveToken(fcmToken);
      }

      Get.offAllNamed('/home');
    } catch (e) {
      print("LOGIN ERROR: $e");

      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  void changePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void toggleRememberMe() {
    rememberMe.value = !rememberMe.value;
  }

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    super.onClose();
  }
}
