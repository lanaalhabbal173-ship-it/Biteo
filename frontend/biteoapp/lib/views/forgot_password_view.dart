import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F3EE),

      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 18, 24, 140),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  // Top Bar
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },

                        child: Container(
                          height: 46,
                          width: 46,

                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),

                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 20,
                            color: Color(0xFF2B1D16),
                          ),
                        ),
                      ),

                      const Spacer(),

                      const Text(
                        "Forgot Password",
                        style: TextStyle(
                          color: Color(0xFF2B1D16),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const Spacer(),

                      const SizedBox(width: 46),
                    ],
                  ),

                  const SizedBox(height: 28),

                  // Header Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(22),

                    decoration: BoxDecoration(
                      color: const Color(0xFF3B261C),
                      borderRadius: BorderRadius.circular(28),
                    ),

                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: const [
                              Text(
                                "Reset your password ☕",
                                style: TextStyle(
                                  color: Color(0xFFE7CDB8),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              SizedBox(height: 10),

                              Text(
                                "We’ll help you\nget back in",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  height: 1.15,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),

                              SizedBox(height: 10),

                              Text(
                                "Enter your email and we’ll send you a reset link.",
                                style: TextStyle(
                                  color: Color(0xFFD8C5B6),
                                  fontSize: 13.5,
                                  height: 1.45,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 14),

                        Container(
                          height: 88,
                          width: 88,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.10),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(1),
                            child: Image.asset(
                              "assets/images/forgot_password_coffee.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 34),

                  const Text(
                    "Email Address",
                    style: TextStyle(
                      color: Color(0xFF2B1D16),
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 10),

                  TextField(
                    controller: controller.email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: inputDecoration(
                      "Enter your email",
                      Icons.email_outlined,
                    ),
                  ),

                  const SizedBox(height: 18),

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFBF7),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: const Color(0xFFE9DDD2)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Icon(
                          Icons.info_outline_rounded,
                          color: Color(0xFF8B5E3C),
                          size: 20,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "Make sure you enter the same email you used when creating your account.",
                            style: TextStyle(
                              color: Color(0xFF74665D),
                              fontSize: 13.5,
                              height: 1.45,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  Obx(
                    () => SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: controller.isLoading.value
                            ? null
                            : controller.forgotPassword,

                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8B5E3C),
                          disabledBackgroundColor: const Color(
                            0xFF8B5E3C,
                          ).withOpacity(.7),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),

                        child: controller.isLoading.value
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                "Send Reset Link",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },

                      child: const Text(
                        "Back to Login",
                        style: TextStyle(
                          color: Color(0xFF8B5E3C),
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFF9B8C82), fontSize: 14),
      prefixIcon: const Icon(Icons.email_outlined, color: Color(0xFF8B5E3C)),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 18),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Color(0xFFE1D6CC), width: 1.3),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Color(0xFF8B5E3C), width: 1.8),
      ),
    );
  }
}
