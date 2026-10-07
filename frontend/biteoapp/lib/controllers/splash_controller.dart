import 'dart:async';

import 'package:biteoapp/services/deep_link_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {
  final GetStorage box = GetStorage();

  final RxDouble loadingValue = 0.0.obs;

  Timer? timer;

  @override
  void onInit() {
    super.onInit();

    startLoading();
    handleNavigation();
  }

  void startLoading() {
    timer = Timer.periodic(
      const Duration(milliseconds: 18),
      (_) {
        if (loadingValue.value >= 1) {
          loadingValue.value = 0;
        } else {
          loadingValue.value += 0.01;
        }
      },
    );
  }

  Future<void> handleNavigation() async {
    await Future.delayed(
      const Duration(seconds: 2),
    );

    // =========================
    // RESET PASSWORD DEEP LINK
    // =========================

    if (DeepLinkService.hasResetLink) {
      final uri =
          DeepLinkService.resetUri!;

      print("RESET URI = $uri");

      Get.offNamed(
        '/reset-password',
        parameters: {
          "email":
              uri.queryParameters['email'] ??
                  "",
          "token":
              uri.queryParameters['token'] ??
                  "",
        },
      );

      DeepLinkService.clear();

      return;
    }

    // =========================
    // CHECK LOGIN
    // =========================

    final token =
        box.read('token');

    print("SAVED TOKEN EXISTS: ${token != null}");

    if (token != null &&
        token.toString().isNotEmpty) {
      // User already logged in
      Get.offAllNamed('/home');
    } else {
      // User not logged in
      Get.offAllNamed('/login');
    }
  }

  @override
  void onClose() {
    timer?.cancel();

    super.onClose();
  }
}