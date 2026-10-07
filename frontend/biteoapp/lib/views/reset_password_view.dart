import 'package:biteoapp/widget/auth/auth_primary_button.dart';
import 'package:biteoapp/widget/auth/auth_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F3EE),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 18, 24, 30),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              GestureDetector(
                onTap: () => Get.back(),

                child: Container(
                  width: 44,
                  height: 44,

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFE9DDD2)),
                  ),

                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 18,
                    color: Color(0xFF2B1D16),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              Center(
                child: Container(
                  width: 110,
                  height: 110,

                  decoration: BoxDecoration(
                    color: const Color(0xFFF0E3D8),

                    borderRadius: BorderRadius.circular(28),
                  ),

                  child: const Icon(
                    Icons.lock_reset_rounded,
                    size: 56,
                    color: Color(0xFF8B5E3C),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              const Center(
                child: Text(
                  "Create new password",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF2B1D16),
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              const Center(
                child: Text(
                  "Choose a strong password for your account",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF74665D),
                    fontSize: 14.5,
                    height: 1.5,
                  ),
                ),
              ),

              const SizedBox(height: 34),

              Obx(
                () => AuthTextField(
                  controller: controller.password,

                  hint: "New Password",

                  icon: Icons.lock_outline_rounded,

                  obscureText: controller.isPasswordHidden.value,

                  suffix: IconButton(
                    onPressed: controller.changePasswordVisibility,

                    icon: Icon(
                      controller.isPasswordHidden.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,

                      color: const Color(0xFF8B5E3C),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              Obx(
                () => AuthTextField(
                  controller: controller.confirmPassword,

                  hint: "Confirm Password",

                  icon: Icons.lock_outline_rounded,

                  obscureText: controller.isConfirmPasswordHidden.value,

                  suffix: IconButton(
                    onPressed: controller.changeConfirmPasswordVisibility,

                    icon: Icon(
                      controller.isConfirmPasswordHidden.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,

                      color: const Color(0xFF8B5E3C),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 26),

              Obx(
                () => AuthPrimaryButton(
                  text: "Reset Password",

                  isLoading: controller.isLoading.value,

                  onTap: controller.resetPassword,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
