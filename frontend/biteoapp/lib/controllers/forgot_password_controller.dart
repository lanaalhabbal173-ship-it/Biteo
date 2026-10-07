import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/auth_service.dart';

class ForgotPasswordController extends GetxController {
  final AuthService service = AuthService();

  final TextEditingController email =
      TextEditingController();

  final RxBool isLoading = false.obs;

  Future<void> forgotPassword() async {
    final userEmail = email.text.trim();

    if (userEmail.isEmpty) {
      Get.snackbar(
        "Email Required",
        "Please enter your email address",
        snackPosition: SnackPosition.TOP,
      );

      return;
    }

    if (!GetUtils.isEmail(userEmail)) {
      Get.snackbar(
        "Invalid Email",
        "Please enter a valid email address",
        snackPosition: SnackPosition.TOP,
      );

      return;
    }

    try {
      isLoading.value = true;

      final response =
          await service.forgotPasswordOtp(
        userEmail,
      );

      print(
        "FORGOT PASSWORD STATUS: "
        "${response.statusCode}",
      );

      print(
        "FORGOT PASSWORD DATA: "
        "${response.data}",
      );

      if (response.statusCode == 200) {
        String message =
            "Verification code generated successfully";

        String? devOtp;

        if (response.data is Map) {
          message =
              response.data['message']
                      ?.toString() ??
                  message;

          devOtp =
              response.data['otp']
                  ?.toString();
        }

        if (devOtp != null &&
            devOtp.isNotEmpty) {
          print("==========================");
          print("DEV OTP: $devOtp");
          print("==========================");
        }

        Get.snackbar(
          "Code Generated",
          message,
          snackPosition: SnackPosition.TOP,
        );

        Get.toNamed(
          '/otp',
          arguments: {
            'email': userEmail,
          },
        );

        return;
      }

      if (response.statusCode == 422) {
        String message =
            "Please check your email address";

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

        return;
      }

      String message =
          "Could not generate verification code";

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
    } on DioException catch (e) {
      print(
        "FORGOT PASSWORD DIO ERROR:",
      );

      print(
        "TYPE: ${e.type}",
      );

      print(
        "MESSAGE: ${e.message}",
      );

      print(
        "STATUS: ${e.response?.statusCode}",
      );

      print(
        "DATA: ${e.response?.data}",
      );

      String message =
          "Something went wrong";

      if (e.response?.data is Map) {
        message =
            e.response?.data['message']
                    ?.toString() ??
                message;
      } else if (e.message != null) {
        message = e.message!;
      }

      Get.snackbar(
        "Error",
        message,
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      print(
        "FORGOT PASSWORD UNKNOWN ERROR: $e",
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
    email.dispose();

    super.onClose();
  }
}