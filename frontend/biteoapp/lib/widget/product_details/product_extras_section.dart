import 'package:biteoapp/controllers/product_details_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductExtrasSection
    extends StatelessWidget {
  final ProductDetailsController
      controller;

  const ProductExtrasSection({
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
          "Add extras",
          style: TextStyle(
            color: Color(0xFF2B1D16),
            fontSize: 18,
            fontWeight:
                FontWeight.w700,
          ),
        ),

        const SizedBox(height: 10),

        Obx(
          () => Column(
            children: [
              _extraTile(
                title: "Extra Shot",
                price: "+ \$1.00",
                value: controller
                    .extraShot.value,
                onChanged: (value) {
                  controller
                          .extraShot.value =
                      value;
                },
              ),

              _extraTile(
                title:
                    "Caramel Syrup",
                price: "+ \$0.50",
                value: controller
                    .caramelSyrup.value,
                onChanged: (value) {
                  controller
                          .caramelSyrup
                          .value =
                      value;
                },
              ),

              _extraTile(
                title:
                    "Vanilla Syrup",
                price: "+ \$0.50",
                value: controller
                    .vanillaSyrup.value,
                onChanged: (value) {
                  controller
                          .vanillaSyrup
                          .value =
                      value;
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _extraTile({
    required String title,
    required String price,
    required bool value,
    required ValueChanged<bool>
        onChanged,
  }) {
    return Container(
      margin:
          const EdgeInsets.only(
        bottom: 10,
      ),

      padding:
          const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 5,
      ),

      decoration: BoxDecoration(
        color:
            const Color(0xFFFFFBF7),

        borderRadius:
            BorderRadius.circular(
          17,
        ),

        border: Border.all(
          color:
              const Color(0xFFE9DED4),
        ),
      ),

      child: Row(
        children: [
          Expanded(
            child: Text(
              title,

              style:
                  const TextStyle(
                color:
                    Color(0xFF4D3A2E),
                fontSize: 14,
                fontWeight:
                    FontWeight.w600,
              ),
            ),
          ),

          Text(
            price,

            style: const TextStyle(
              color:
                  Color(0xFF8B5E3C),
              fontSize: 13,
              fontWeight:
                  FontWeight.w600,
            ),
          ),

          const SizedBox(width: 5),

          Checkbox(
            value: value,

            onChanged: (
              newValue,
            ) {
              onChanged(
                newValue ?? false,
              );
            },

            activeColor:
                const Color(
              0xFF8B5E3C,
            ),

            shape:
                RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(
                5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}