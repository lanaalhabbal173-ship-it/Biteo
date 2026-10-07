import 'package:biteoapp/controllers/product_details_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductSizeSelector
    extends StatelessWidget {
  final ProductDetailsController
      controller;

  const ProductSizeSelector({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [
        const Text(
          "Choose size",
          style: TextStyle(
            color: Color(0xFF2B1D16),
            fontSize: 18,
            fontWeight:
                FontWeight.w700,
          ),
        ),

        const SizedBox(height: 13),

        Obx(
          () => Row(
            children: [
              _choiceButton(
                "Small",
              ),

              const SizedBox(
                width: 10,
              ),

              _choiceButton(
                "Medium",
              ),

              const SizedBox(
                width: 10,
              ),

              _choiceButton(
                "Large",
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _choiceButton(
    String size,
  ) {
    final selected =
        controller.selectedSize.value ==
            size;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          controller.selectSize(
            size,
          );
        },

        child: AnimatedContainer(
          duration: const Duration(
            milliseconds: 180,
          ),

          height: 48,

          decoration: BoxDecoration(
            color: selected
                ? const Color(
                    0xFF8B5E3C,
                  )
                : const Color(
                    0xFFFFFBF7,
                  ),

            borderRadius:
                BorderRadius.circular(
              15,
            ),

            border: Border.all(
              color: selected
                  ? const Color(
                      0xFF8B5E3C,
                    )
                  : const Color(
                      0xFFE5D8CC,
                    ),
            ),
          ),

          child: Center(
            child: Text(
              size,

              style: TextStyle(
                color: selected
                    ? Colors.white
                    : const Color(
                        0xFF6F6259,
                      ),

                fontWeight:
                    FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}