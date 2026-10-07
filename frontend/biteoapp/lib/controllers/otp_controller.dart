import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/auth_service.dart';

class OtpController extends GetxController {
  final AuthService service = AuthService();

  final List<TextEditingController> otpControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );

  final List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());

  final RxBool isLoading = false.obs;
  final RxBool isResending = false.obs;

  final RxInt secondsRemaining = 30.obs;
  final RxBool canResend = false.obs;

  String email = '';

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;

    if (args is Map) {
      email = args['email']?.toString() ?? '';
    } else if (args is String) {
      email = args;
    } else {
      email = '';
    }

    print("OTP EMAIL: $email");

    startTimer();
  }

  // =========================
  // GET FULL OTP
  // =========================

  String get otpCode {
    return otpControllers.map((controller) => controller.text.trim()).join();
  }

  // =========================
  // OTP FIELD CHANGED
  // =========================

  void onOtpChanged(String value, int index) {
    if (value.isNotEmpty && index < focusNodes.length - 1) {
      focusNodes[index + 1].requestFocus();
    }

    if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }
  }

  // =========================
  // TIMER
  // =========================

  void startTimer() {
    _timer?.cancel();

    secondsRemaining.value = 30;
    canResend.value = false;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        canResend.value = true;
        timer.cancel();
      }
    });
  }

  // =========================
  // VERIFY OTP
  // =========================

  Future<void> verifyOtp() async {
    final otp = otpCode;

    if (email.isEmpty) {
      Get.snackbar(
        "Error",
        "Email address is missing",
        snackPosition: SnackPosition.TOP,
      );

      return;
    }

    if (otp.length != 4) {
      Get.snackbar(
        "Invalid Code",
        "Please enter the complete 4-digit code",
        snackPosition: SnackPosition.TOP,
      );

      return;
    }

    try {
      isLoading.value = true;

      final response = await service.verifyOtp(email, otp);

      print(
        "VERIFY OTP STATUS: "
        "${response.statusCode}",
      );

      print(
        "VERIFY OTP RESPONSE: "
        "${response.data}",
      );

      if (response.statusCode == 200) {
        String? verificationToken;

        String message = "OTP verified successfully";

        if (response.data is Map) {
          verificationToken = response.data['verification_token']?.toString();

          message = response.data['message']?.toString() ?? message;
        }

        if (verificationToken == null || verificationToken.isEmpty) {
          Get.snackbar(
            "Error",
            "Verification token was not returned",
            snackPosition: SnackPosition.TOP,
          );

          return;
        }

        print("VERIFICATION TOKEN RECEIVED: true");

        Get.snackbar("Success", message, snackPosition: SnackPosition.TOP);

        Get.offNamed(
          '/reset-password',
          arguments: {'email': email, 'verification_token': verificationToken},
        );
      } else {
        String message = "OTP verification failed";

        if (response.data is Map) {
          message = response.data['message']?.toString() ?? message;
        }

        Get.snackbar("Invalid Code", message, snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      print("VERIFY OTP ERROR: $e");

      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.TOP);
    } finally {
      isLoading.value = false;
    }
  }

  // =========================
  // RESEND OTP
  // =========================

  Future<void> resendCode() async {
    if (!canResend.value || isResending.value) {
      return;
    }

    if (email.isEmpty) {
      Get.snackbar(
        "Error",
        "Email address is missing",
        snackPosition: SnackPosition.TOP,
      );

      return;
    }

    try {
      isResending.value = true;

      final response = await service.forgotPasswordOtp(email);

      print(
        "RESEND OTP STATUS: "
        "${response.statusCode}",
      );

      print(
        "RESEND OTP RESPONSE: "
        "${response.data}",
      );

      if (response.statusCode == 200) {
        String? devOtp;

        String message = "A new verification code was generated";

        if (response.data is Map) {
          devOtp = response.data['otp']?.toString();

          message = response.data['message']?.toString() ?? message;
        }

        if (devOtp != null && devOtp.isNotEmpty) {
          print("==========================");
          print("DEV RESEND OTP: $devOtp");
          print("==========================");
        }

        clearOtp();

        startTimer();

        Get.snackbar(
          "Code Generated",
          message,
          snackPosition: SnackPosition.TOP,
        );
      } else {
        String message = "Could not generate new OTP";

        if (response.data is Map) {
          message = response.data['message']?.toString() ?? message;
        }

        Get.snackbar("Error", message, snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      print("RESEND OTP ERROR: $e");

      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.TOP);
    } finally {
      isResending.value = false;
    }
  }

  // =========================
  // CLEAR OTP
  // =========================

  void clearOtp() {
    for (final controller in otpControllers) {
      controller.clear();
    }

    if (focusNodes.isNotEmpty) {
      focusNodes.first.requestFocus();
    }
  }

  // =========================
  // CLOSE
  // =========================

  @override
  void onClose() {
    _timer?.cancel();

    // intentionally not disposing TextEditingControllers
    // or FocusNodes here to avoid using them after disposal
    // during GetX navigation transitions

    super.onClose();
  }
}
