import 'package:biteoapp/services/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {
  final ProfileService profileService =
      ProfileService();

  final GetStorage box = GetStorage();

  final nameController =
      TextEditingController();

  final emailController =
      TextEditingController();

  RxString name = "".obs;
  RxString email = "".obs;

  RxBool isLoading = false.obs;
  RxBool isSaving = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    try {
      isLoading.value = true;

      final response =
          await profileService.getProfile();

      final user = response.data['user'];

      name.value =
          user['name']?.toString() ?? '';

      email.value =
          user['email']?.toString() ?? '';

      nameController.text = name.value;
      emailController.text = email.value;

      await box.write(
        "name",
        name.value,
      );

      await box.write(
        "email",
        email.value,
      );
    } catch (e) {
      print("PROFILE ERROR: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProfile() async {
    final newName =
        nameController.text.trim();

    final newEmail =
        emailController.text.trim();

    if (newName.isEmpty ||
        newEmail.isEmpty) {
      Get.snackbar(
        "Missing information",
        "Name and email are required",
        snackPosition:
            SnackPosition.BOTTOM,
      );

      return;
    }

    try {
      isSaving.value = true;

      final response =
          await profileService.updateProfile(
        name: newName,
        email: newEmail,
      );

      final user = response.data['user'];

      name.value =
          user['name']?.toString() ?? newName;

      email.value =
          user['email']?.toString() ?? newEmail;

      await box.write(
        "name",
        name.value,
      );

      await box.write(
        "email",
        email.value,
      );

      Get.back();

      Get.snackbar(
        "Updated",
        "Profile updated successfully",
        snackPosition:
            SnackPosition.BOTTOM,
      );
    } catch (e) {
      print("UPDATE PROFILE ERROR: $e");

      Get.snackbar(
        "Error",
        "Could not update profile",
        snackPosition:
            SnackPosition.BOTTOM,
      );
    } finally {
      isSaving.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    super.onClose();
  }
}