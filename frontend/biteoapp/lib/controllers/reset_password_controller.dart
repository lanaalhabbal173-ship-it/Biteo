import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/auth_service.dart';

class ResetPasswordController extends GetxController {
  final AuthService service = AuthService();

  final TextEditingController password =
      TextEditingController();

  final TextEditingController confirmPassword =
      TextEditingController();

  final RxBool isLoading = false.obs;
  final RxBool isPasswordHidden = true.obs;
  final RxBool isConfirmPasswordHidden = true.obs;

  String email = '';
  String verificationToken = '';

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;

    if (args is Map) {
      email =
          args['email']?.toString() ?? '';

      verificationToken =
          args['verification_token']
                  ?.toString() ??
              '';
    }

    print("RESET EMAIL: $email");
    print(
      "RESET TOKEN RECEIVED: "
      "${verificationToken.isNotEmpty}",
    );
  }

  void changePasswordVisibility() {
    isPasswordHidden.value =
        !isPasswordHidden.value;
  }

  void changeConfirmPasswordVisibility() {
    isConfirmPasswordHidden.value =
        !isConfirmPasswordHidden.value;
  }

  Future<void> resetPassword() async {
    final newPassword =
        password.text.trim();

    final confirmation =
        confirmPassword.text.trim();

    // =========================
    // VALIDATION
    // =========================

    if (newPassword.isEmpty ||
        confirmation.isEmpty) {
      Get.snackbar(
        "Missing Fields",
        "Please fill in both password fields",
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    if (newPassword.length < 6) {
      Get.snackbar(
        "Weak Password",
        "Password must be at least 6 characters",
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    if (newPassword != confirmation) {
      Get.snackbar(
        "Passwords Don't Match",
        "Please make sure both passwords match",
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    if (email.isEmpty ||
        verificationToken.isEmpty) {
      Get.snackbar(
        "Error",
        "Verification data is missing",
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    try {
      isLoading.value = true;

      final response =
          await service.resetPasswordOtp(
        email,
        verificationToken,
        newPassword,
        confirmation,
      );

      print(
        "RESET PASSWORD STATUS: "
        "${response.statusCode}",
      );

      print(
        "RESET PASSWORD DATA: "
        "${response.data}",
      );

      if (response.statusCode == 200) {
        String message =
            "Password reset successfully";

        if (response.data is Map) {
          message =
              response.data['message']
                      ?.toString() ??
                  message;
        }

        Get.snackbar(
          "Success",
          message,
          snackPosition: SnackPosition.TOP,
        );

        // Back to login after success
        Get.offAllNamed('/login');
      } else {
        String message =
            "Could not reset password";

        if (response.data is Map) {
          message =
              response.data['message']
                      ?.toString() ??
                  message;
        }

        Get.snackbar(
          "Error",
          message,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      print(
        "RESET PASSWORD ERROR: $e",
      );

      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    password.dispose();
    confirmPassword.dispose();

    super.onClose();
  }
}