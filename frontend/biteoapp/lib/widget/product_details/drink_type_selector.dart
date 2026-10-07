import 'package:biteoapp/controllers/product_details_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrinkTypeSelector
    extends StatelessWidget {
  final ProductDetailsController
      controller;

  const DrinkTypeSelector({
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
          "How do you like it?",
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
              Expanded(
                child: _typeButton(
                  icon: Icons
                      .local_fire_department_rounded,
                  text: "Hot",
                ),
              ),

              const SizedBox(
                width: 12,
              ),

              Expanded(
                child: _typeButton(
                  icon:
                      Icons.ac_unit_rounded,
                  text: "Iced",
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _typeButton({
    required IconData icon,
    required String text,
  }) {
    final selected =
        controller.selectedType.value ==
            text;

    return GestureDetector(
      onTap: () {
        controller.selectType(
          text,
        );
      },

      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: 180,
        ),

        padding:
            const EdgeInsets.symmetric(
          vertical: 15,
        ),

        decoration: BoxDecoration(
          color: selected
              ? const Color(
                  0xFFF0E2D6,
                )
              : const Color(
                  0xFFFFFBF7,
                ),

          borderRadius:
              BorderRadius.circular(
            17,
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

        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [
            Icon(
              icon,
              color: const Color(
                0xFF8B5E3C,
              ),
              size: 20,
            ),

            const SizedBox(
              width: 8,
            ),

            Text(
              text,

              style: const TextStyle(
                color: Color(
                  0xFF5A4437,
                ),
                fontWeight:
                    FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}