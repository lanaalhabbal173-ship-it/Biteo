import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/otp_controller.dart';

class OtpView extends GetView<OtpController> {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F3EE),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            24,
            18,
            24,
            30,
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // BACK BUTTON
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: const Color(0xFFE9DDD2),
                    ),
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 18,
                    color: Color(0xFF2B1D16),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // IMAGE
              Center(
                child: Container(
                  height: 115,
                  width: 115,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0E3D8),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      "assets/images/forgot_password_coffee.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // TITLE
              const Center(
                child: Text(
                  "Verify your code",
                  style: TextStyle(
                    color: Color(0xFF2B1D16),
                    fontSize: 29,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Center(
                child: Text(
                  "We sent a 4-digit code to\n${controller.email}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF74665D),
                    fontSize: 14.5,
                    height: 1.5,
                  ),
                ),
              ),

              const SizedBox(height: 34),

              // OTP BOXES
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  4,
                  (index) => _otpField(index),
                ),
              ),

              const SizedBox(height: 26),

              // RESEND
              Obx(
                () => Center(
                  child: controller.canResend.value
                      ? TextButton(
                          onPressed: controller.isResending.value
                              ? null
                              : controller.resendCode,
                          child: controller.isResending.value
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Color(0xFF8B5E3C),
                                  ),
                                )
                              : const Text(
                                  "Resend Code",
                                  style: TextStyle(
                                    color: Color(0xFF8B5E3C),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                        )
                      : Text(
                          "Resend code in ${controller.secondsRemaining.value}s",
                          style: const TextStyle(
                            color: Color(0xFF9B8C82),
                            fontSize: 13.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 24),

              // VERIFY BUTTON
              Obx(
                () => SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : controller.verifyOtp,

                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8B5E3C),
                      disabledBackgroundColor:
                          const Color(0xFFC6AA95),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    child: controller.isLoading.value
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.4,
                              color: Colors.white,
                            ),
                          )
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Verify Code",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(width: 10),
                              Icon(
                                Icons.arrow_forward_rounded,
                                size: 20,
                              ),
                            ],
                          ),
                  ),
                ),
              ),

              const SizedBox(height: 22),

              Center(
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: const Text(
                    "Change email address",
                    style: TextStyle(
                      color: Color(0xFF8B5E3C),
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _otpField(int index) {
    return SizedBox(
      width: 67,
      height: 67,

      child: TextField(
        controller: controller.otpControllers[index],
        focusNode: controller.focusNodes[index],

        keyboardType: TextInputType.number,

        textAlign: TextAlign.center,

        maxLength: 1,

        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],

        style: const TextStyle(
          color: Color(0xFF2B1D16),
          fontSize: 24,
          fontWeight: FontWeight.w800,
        ),

        decoration: InputDecoration(
          counterText: "",

          filled: true,
          fillColor: Colors.white,

          contentPadding: EdgeInsets.zero,

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(
              color: Color(0xFFE4D8CE),
              width: 1.3,
            ),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(
              color: Color(0xFF8B5E3C),
              width: 2,
            ),
          ),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),

        onChanged: (value) {
          controller.onOtpChanged(
            value,
            index,
          );
        },
      ),
    );
  }
}