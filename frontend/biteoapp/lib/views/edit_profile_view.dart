import 'package:biteoapp/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileView extends StatelessWidget {
  EditProfileView({super.key});

  final ProfileController controller =
      Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F1EA),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F1EA),
        elevation: 0,

        leading: IconButton(
          onPressed: Get.back,
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF2B1D16),
          ),
        ),

        centerTitle: true,

        title: const Text(
          "Edit Profile",
          style: TextStyle(
            color: Color(0xFF2B1D16),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF8B5E3C),
            ),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [
              Container(
                width: 90,
                height: 90,

                decoration: const BoxDecoration(
                  color: Color(0xFFF0E3D7),
                  shape: BoxShape.circle,
                ),

                child: Center(
                  child: Obx(
                    () => Text(
                      controller.name.value.isNotEmpty
                          ? controller.name.value[0]
                              .toUpperCase()
                          : "U",

                      style: const TextStyle(
                        color: Color(0xFF8B5E3C),
                        fontSize: 34,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              _field(
                controller:
                    controller.nameController,
                label: "Full Name",
                icon: Icons.person_outline_rounded,
              ),

              const SizedBox(height: 16),

              _field(
                controller:
                    controller.emailController,
                label: "Email Address",
                icon: Icons.email_outlined,
                keyboardType:
                    TextInputType.emailAddress,
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
                        : controller.updateProfile,

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
                            "Save Changes",
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
        );
      }),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,

      decoration: InputDecoration(
        labelText: label,

        prefixIcon: Icon(
          icon,
          color: const Color(0xFF8B5E3C),
        ),

        filled: true,
        fillColor: const Color(0xFFFFFBF7),

        labelStyle: const TextStyle(
          color: Color(0xFF8D7D72),
        ),

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