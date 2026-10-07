import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final SplashController controller =
        Get.find<SplashController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F1EA),
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              "assets/images/splash_coffee.png",
              fit: BoxFit.cover,
            ),
          ),

          // Loading bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 110,
            child: Center(
              child: Obx(
                () => Container(
                  width: 165,
                  height: 7,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5D1BC),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: AnimatedContainer(
                      duration: const Duration(
                        milliseconds: 180,
                      ),
                      width: 165 *
                          controller.loadingValue.value,
                      height: 7,
                      decoration: BoxDecoration(
                        color: const Color(0xFF4A2114),
                        borderRadius:
                            BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Loading text
          const Positioned(
            left: 0,
            right: 0,
            bottom: 80,
            child: Center(
              child: Text(
                "Brewing your experience...",
                style: TextStyle(
                  color: Color(0xFF5E463A),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}