import 'package:biteoapp/widget/auth/auth_primary_button.dart';
import 'package:biteoapp/widget/auth/auth_text_field.dart';
import 'package:biteoapp/widget/auth/social_login_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F1EA),

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(24, 18, 24, 30),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TOP BAR
              Row(
                children: [
                  GestureDetector(
                    onTap: Get.back,
                    child: Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFBF7),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFE4D7CC)),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 18,
                        color: Color(0xFF2B1D16),
                      ),
                    ),
                  ),

                  const Spacer(),

                  const Text(
                    "Create Account",
                    style: TextStyle(
                      color: Color(0xFF8B5E3C),
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // TITLE
              const Text(
                "Join the coffee\njourney ☕",
                style: TextStyle(
                  color: Color(0xFF2B1D16),
                  fontSize: 32,
                  height: 1.08,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.4,
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                "Create your account and discover your perfect cup.",
                style: TextStyle(
                  color: Color(0xFF74665D),
                  fontSize: 14,
                  height: 1.45,
                ),
              ),

              const SizedBox(height: 30),

              // NAME
              AuthTextField(
                controller: controller.name,
                hint: "Full Name",
                icon: Icons.person_outline_rounded,
              ),

              const SizedBox(height: 14),

              // EMAIL
              AuthTextField(
                controller: controller.email,
                hint: "Email",
                icon: Icons.email_outlined,
              ),

              const SizedBox(height: 14),

              // PHONE
              AuthTextField(
                controller: controller.phone,
                hint: "Phone",
                icon: Icons.phone_android_outlined,
              ),

              const SizedBox(height: 14),

              // PASSWORD
              Obx(
                () => AuthTextField(
                  controller: controller.password,
                  hint: "Password",
                  icon: Icons.lock_outline_rounded,
                  obscureText: controller.isPasswordHidden.value,

                  suffix: IconButton(
                    onPressed: controller.changePasswordVisibility,
                    icon: Icon(
                      controller.isPasswordHidden.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: const Color(0xFF8B5E3C),
                      size: 22,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // CONFIRM PASSWORD
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
                      size: 22,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // CREATE ACCOUNT
              Obx(
                () => AuthPrimaryButton(
                  text: "Create Account",
                  isLoading: controller.isLoading.value,

                  onTap: () {
                    controller.register(
                      controller.name.text,
                      controller.email.text,
                      controller.phone.text,
                      controller.password.text,
                      controller.confirmPassword.text,
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              // OR
              Row(
                children: [
                  const Expanded(child: Divider(color: Color(0xFFE1D4CA))),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14),
                    child: Text(
                      "OR",
                      style: TextStyle(
                        color: Color(0xFFA99A90),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const Expanded(child: Divider(color: Color(0xFFE1D4CA))),
                ],
              ),

              const SizedBox(height: 18),

              SocialLoginButton(
                text: "Continue with Google",
                icon: Image.asset(
                  "assets/images/google.jpg",
                  width: 22,
                  height: 22,
                ),
              ),

              const SizedBox(height: 12),

              const SocialLoginButton(
                text: "Continue with Apple",
                icon: Icon(Icons.apple, size: 27, color: Colors.black),
              ),

              const SizedBox(height: 24),

              // SIGN IN
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account? ",
                    style: TextStyle(color: Color(0xFF74665D), fontSize: 13.5),
                  ),

                  GestureDetector(
                    onTap: Get.back,
                    child: const Text(
                      "Sign In",
                      style: TextStyle(
                        color: Color(0xFF8B5E3C),
                        fontSize: 13.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),
            ],
          ),
        ),
      ),
    );
  }
}
