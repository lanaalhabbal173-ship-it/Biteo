import 'package:biteoapp/widget/auth/auth_primary_button.dart';
import 'package:biteoapp/widget/auth/auth_text_field.dart';
import 'package:biteoapp/widget/auth/coffee_auth_header.dart';
import 'package:biteoapp/widget/auth/social_login_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F1EA),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 10, 24, 30),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CoffeeAuthHeader(),

              const SizedBox(height: 20),

              // EMAIL
              AuthTextField(
                controller: controller.email,
                hint: "Email",
                icon: Icons.email_outlined,
              ),

              const SizedBox(height: 16),

              // PASSWORD
              Obx(
                () => AuthTextField(
                  controller: controller.password,
                  hint: "Password",
                  icon: Icons.lock_outline,
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

              const SizedBox(height: 8),

              // REMEMBER + FORGOT PASSWORD
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Obx(
                    () => Row(
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Checkbox(
                            value: controller.rememberMe.value,

                            activeColor: const Color(0xFF8B5E3C),

                            side: const BorderSide(color: Color(0xFFCAB8AA)),

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),

                            onChanged: (_) {
                              controller.toggleRememberMe();
                            },
                          ),
                        ),

                        const SizedBox(width: 8),

                        const Text(
                          "Remember me",
                          style: TextStyle(
                            color: Color(0xFF74665D),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),

                  TextButton(
                    onPressed: () {
                      Get.toNamed('/forgot-password');
                    },

                    style: TextButton.styleFrom(padding: EdgeInsets.zero),

                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Color(0xFF8B5E3C),
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // SIGN IN BUTTON
              Obx(
                () => AuthPrimaryButton(
                  text: "Sign In",
                  isLoading: controller.isLoading.value,

                  onTap: () {
                    controller.login(
                      controller.email.text,
                      controller.password.text,
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              // OR
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.brown.shade100)),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14),

                    child: Text(
                      "OR",
                      style: TextStyle(
                        color: Color(0xFFAA9B91),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  Expanded(child: Divider(color: Colors.brown.shade100)),
                ],
              ),

              const SizedBox(height: 20),

              // GOOGLE
              SocialLoginButton(
                text: "Continue with Google",

                icon: Image.asset(
                  "assets/images/google.jpg",
                  width: 22,
                  height: 22,
                ),
              ),

              const SizedBox(height: 12),

              // APPLE
              const SocialLoginButton(
                text: "Continue with Apple",

                icon: Icon(Icons.apple, size: 27, color: Colors.black),
              ),

              const SizedBox(height: 28),

              // SIGN UP
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(color: Color(0xFF74665D), fontSize: 14),
                  ),

                  GestureDetector(
                    onTap: () {
                      Get.toNamed('/register');
                    },

                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Color(0xFF8B5E3C),
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
