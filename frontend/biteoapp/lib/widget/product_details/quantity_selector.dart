import 'package:biteoapp/controllers/product_details_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuantitySelector
    extends StatelessWidget {
  final ProductDetailsController
      controller;

  const QuantitySelector({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,

      children: [
        const Text(
          "Quantity",
          style: TextStyle(
            color: Color(0xFF2B1D16),
            fontSize: 18,
            fontWeight:
                FontWeight.w700,
          ),
        ),

        Container(
          decoration: BoxDecoration(
            color:
                const Color(0xFFFFFBF7),

            borderRadius:
                BorderRadius.circular(
              17,
            ),

            border: Border.all(
              color:
                  const Color(
                0xFFE6D8CC,
              ),
            ),
          ),

          child: Row(
            children: [
              IconButton(
                onPressed:
                    controller
                        .decreaseQuantity,

                icon: const Icon(
                  Icons.remove_rounded,
                  color:
                      Color(
                    0xFF8B5E3C,
                  ),
                ),
              ),

              Obx(
                () => Text(
                  "${controller.quantity.value}",

                  style:
                      const TextStyle(
                    color:
                        Color(
                      0xFF2B1D16,
                    ),
                    fontSize: 16,
                    fontWeight:
                        FontWeight
                            .w700,
                  ),
                ),
              ),

              IconButton(
                onPressed:
                    controller
                        .increaseQuantity,

                icon: const Icon(
                  Icons.add_rounded,
                  color:
                      Color(
                    0xFF8B5E3C,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}