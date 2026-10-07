import 'package:biteoapp/controllers/address_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAddressView extends StatelessWidget {
  AddAddressView({super.key});

  final AddressController controller =
      Get.find<AddressController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F1EA),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F1EA),
        elevation: 0,
        centerTitle: true,

        leading: IconButton(
          onPressed: Get.back,
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF2B1D16),
          ),
        ),

        title: const Text(
          "Add Address",
          style: TextStyle(
            color: Color(0xFF2B1D16),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Address Label",
              style: TextStyle(
                color: Color(0xFF2B1D16),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            _field(
              controller: controller.labelController,
              hint: "Home, Work...",
              icon: Icons.bookmark_outline_rounded,
            ),

            const SizedBox(height: 18),

            const Text(
              "Full Address",
              style: TextStyle(
                color: Color(0xFF2B1D16),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            _field(
              controller: controller.addressController,
              hint: "Street, building, floor...",
              icon: Icons.location_on_outlined,
              maxLines: 3,
            ),

            const SizedBox(height: 18),

            const Text(
              "City",
              style: TextStyle(
                color: Color(0xFF2B1D16),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            _field(
              controller: controller.cityController,
              hint: "City",
              icon: Icons.location_city_outlined,
            ),

            const SizedBox(height: 18),

            const Text(
              "Phone Number",
              style: TextStyle(
                color: Color(0xFF2B1D16),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            _field(
              controller: controller.phoneController,
              hint: "Phone number",
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
            ),

            const SizedBox(height: 20),

            Obx(
              () => Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFBF7),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: const Color(0xFFE8DDD3),
                  ),
                ),

                child: SwitchListTile(
                  value: controller.isDefault.value,

                  onChanged: (value) {
                    controller.isDefault.value = value;
                  },

                  activeColor: const Color(0xFF8B5E3C),

                  title: const Text(
                    "Set as default address",
                    style: TextStyle(
                      color: Color(0xFF2B1D16),
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  subtitle: const Text(
                    "Use this address automatically at checkout",
                    style: TextStyle(
                      color: Color(0xFF9A8C82),
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            Obx(() {
              final isSaving =
                  controller.isSaving.value;

              return SizedBox(
                width: double.infinity,
                height: 56,

                child: ElevatedButton(
                  onPressed: isSaving
                      ? null
                      : controller.addAddress,

                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF8B5E3C),

                    disabledBackgroundColor:
                        const Color(0xFFBFA793),

                    foregroundColor: Colors.white,

                    elevation: 0,

                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(18),
                    ),
                  ),

                  child: isSaving
                      ? const SizedBox(
                          width: 23,
                          height: 23,
                          child:
                              CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          "Save Address",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight:
                                FontWeight.w700,
                          ),
                        ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,

      decoration: InputDecoration(
        hintText: hint,

        hintStyle: const TextStyle(
          color: Color(0xFFB4A59B),
        ),

        prefixIcon: maxLines == 1
            ? Icon(
                icon,
                color: const Color(0xFF8B5E3C),
              )
            : Padding(
                padding: const EdgeInsets.only(
                  bottom: 48,
                ),
                child: Icon(
                  icon,
                  color: const Color(0xFF8B5E3C),
                ),
              ),

        filled: true,
        fillColor: const Color(0xFFFFFBF7),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: Color(0xFFE8DDD3),
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: Color(0xFFE8DDD3),
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: Color(0xFF8B5E3C),
            width: 1.5,
          ),
        ),
      ),
    );
  }
}