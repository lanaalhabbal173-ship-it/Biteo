import 'package:biteoapp/controllers/product_details_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductInfoSection
    extends StatelessWidget {
  final ProductDetailsController
      controller;

  const ProductInfoSection({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final product =
        controller.product;

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [
        Row(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  Text(
                    product.name,

                    style:
                        const TextStyle(
                      color:
                          Color(0xFF2B1D16),
                      fontSize: 27,
                      fontWeight:
                          FontWeight.w800,
                    ),
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  const Row(
                    children: [
                      Icon(
                        Icons.star_rounded,
                        color:
                            Color(0xFFD9A26C),
                        size: 19,
                      ),

                      SizedBox(width: 5),

                      Text(
                        "4.8",
                        style:
                            TextStyle(
                          color:
                              Color(
                            0xFF6F6259,
                          ),
                          fontWeight:
                              FontWeight
                                  .w600,
                        ),
                      ),

                      SizedBox(width: 8),

                      Text(
                        "(120 reviews)",
                        style:
                            TextStyle(
                          color:
                              Color(
                            0xFF9D8D81,
                          ),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Obx(
              () => Text(
                "\$${controller.totalPrice.toStringAsFixed(2)}",

                style:
                    const TextStyle(
                  color:
                      Color(0xFF7A4F33),
                  fontSize: 23,
                  fontWeight:
                      FontWeight.w800,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 18),

        Text(
          product.description,

          style: const TextStyle(
            color: Color(0xFF81746A),
            fontSize: 14,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}