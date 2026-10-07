import 'package:biteoapp/models/address_model.dart';
import 'package:biteoapp/services/address_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressController extends GetxController {
  final AddressService addressService =
      AddressService();

  RxList<AddressModel> addresses =
      <AddressModel>[].obs;

  RxBool isLoading = false.obs;
  RxBool isSaving = false.obs;

  final labelController =
      TextEditingController();

  final addressController =
      TextEditingController();

  final cityController =
      TextEditingController();

  final phoneController =
      TextEditingController();

  RxBool isDefault = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAddresses();
  }

  Future<void> fetchAddresses() async {
    try {
      isLoading.value = true;

      final response =
          await addressService.getAddresses();

      if (response.data is List) {
        addresses.value =
            (response.data as List)
                .map(
                  (e) =>
                      AddressModel.fromJson(e),
                )
                .toList();
      }
    } catch (e) {
      print("ADDRESS ERROR: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addAddress() async {
    if (labelController.text.trim().isEmpty ||
        addressController.text.trim().isEmpty) {
      Get.snackbar(
        "Missing information",
        "Label and address are required",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      isSaving.value = true;

      await addressService.addAddress(
        label: labelController.text.trim(),
        address: addressController.text.trim(),
        city: cityController.text.trim(),
        phone: phoneController.text.trim(),
        isDefault: isDefault.value,
      );

      clearForm();

      await fetchAddresses();

      Get.back();

      Get.snackbar(
        "Added",
        "Address added successfully",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      print("ADD ADDRESS ERROR: $e");

      Get.snackbar(
        "Error",
        "Could not add address",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isSaving.value = false;
    }
  }

  Future<void> setDefault(
    AddressModel address,
  ) async {
    try {
      await addressService.setDefault(
        address.id,
      );

      await fetchAddresses();
    } catch (e) {
      print("DEFAULT ADDRESS ERROR: $e");
    }
  }

  Future<void> deleteAddress(
    AddressModel address,
  ) async {
    try {
      await addressService.deleteAddress(
        address.id,
      );

      await fetchAddresses();

      Get.snackbar(
        "Deleted",
        "Address removed",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      print("DELETE ADDRESS ERROR: $e");
    }
  }

  void clearForm() {
    labelController.clear();
    addressController.clear();
    cityController.clear();
    phoneController.clear();

    isDefault.value = false;
  }

  @override
  void onClose() {
    labelController.dispose();
    addressController.dispose();
    cityController.dispose();
    phoneController.dispose();

    super.onClose();
  }
}