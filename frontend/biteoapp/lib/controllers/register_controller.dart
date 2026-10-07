import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../services/auth_service.dart';

class RegisterController extends GetxController {
  final box = GetStorage();
  final AuthService service = AuthService();

  final name = TextEditingController();

  final email = TextEditingController();
  final phone = TextEditingController();

  final password = TextEditingController();

  final confirmPassword = TextEditingController();

  var isPasswordHidden = true.obs;

  var isConfirmPasswordHidden = true.obs;

  var isLoading = false.obs;

  Future<void> register(
    String name,
    String email,
    String phone,

    String password,
    String confirmPassword,
  ) async {
    if (password != confirmPassword) {
      Get.snackbar("Error", "Passwords do not match");

      return;
    }

    try {
      isLoading.value = true;

      final response = await service.register(
        name,
        email,
        phone,

        password,
        confirmPassword,
      );

      print(response.data);
      box.write('token', response.data['token']);
      
      Get.offNamed('/login');
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void changePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void changeConfirmPasswordVisibility() {
    isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;
  }

  @override
  void onClose() {
    name.dispose();

    email.dispose();

    password.dispose();

    confirmPassword.dispose();

    super.onClose();
  }
}
