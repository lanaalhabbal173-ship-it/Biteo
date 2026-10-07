import 'package:biteoapp/controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartSummary extends StatelessWidget {
  final CartController controller;

  const CartSummary({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        20,
        16,
        20,
        22,
      ),

      decoration: const BoxDecoration(
        color: Color(0xFFFFFBF7),

        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),

      child: Column(
        children: [
          // =========================
          // SUBTOTAL
          // =========================

          Row(
            mainAxisAlignment:
                MainAxisAlignment
                    .spaceBetween,

            children: [
              const Text(
                "Subtotal",

                style: TextStyle(
                  color:
                      Color(0xFF7B6B60),
                  fontSize: 15,
                ),
              ),

              Obx(
                () => Text(
                  "\$${controller.subtotal.toStringAsFixed(2)}",

                  style: const TextStyle(
                    color:
                        Color(0xFF2B1D16),
                    fontSize: 20,
                    fontWeight:
                        FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // =========================
          // CHECKOUT BUTTON
          // =========================

          Obx(() {
            final bool isCheckingOut =
                controller
                    .isCheckingOut.value;

            return SizedBox(
              width: double.infinity,
              height: 56,

              child: ElevatedButton(
                onPressed: isCheckingOut
                    ? null
                    : controller.checkout,

                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(
                    0xFF8B5E3C,
                  ),

                  disabledBackgroundColor:
                      const Color(
                    0xFFBFA793,
                  ),

                  foregroundColor:
                      Colors.white,

                  elevation: 0,

                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                      18,
                    ),
                  ),
                ),

                child: isCheckingOut
                    ? const SizedBox(
                        width: 23,
                        height: 23,

                        child:
                            CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color:
                              Colors.white,
                        ),
                      )
                    : const Text(
                        "Proceed to Checkout",

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
  }
}