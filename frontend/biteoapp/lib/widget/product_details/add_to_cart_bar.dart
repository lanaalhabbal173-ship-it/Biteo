import 'package:biteoapp/controllers/product_details_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddToCartBar
    extends StatelessWidget {
  final ProductDetailsController
      controller;

  const AddToCartBar({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.fromLTRB(
        20,
        12,
        20,
        18,
      ),

      color:
          const Color(0xFFF7F1EA),

      child: Obx(
        () => SizedBox(
          height: 58,
          width: double.infinity,

          child: ElevatedButton(
            onPressed: controller
                    .isAddingToCart
                    .value
                ? null
                : controller
                    .addToCart,

            style:
                ElevatedButton.styleFrom(
              backgroundColor:
                  const Color(
                0xFF8B5E3C,
              ),

              foregroundColor:
                  Colors.white,

              elevation: 0,

              shape:
                  RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(
                  20,
                ),
              ),
            ),

            child: controller
                    .isAddingToCart
                    .value
                ? const SizedBox(
                    height: 22,
                    width: 22,

                    child:
                        CircularProgressIndicator(
                      strokeWidth: 2,
                      color:
                          Colors.white,
                    ),
                  )
                : Row(
                    mainAxisAlignment:
                        MainAxisAlignment
                            .center,

                    children: [
                      const Icon(
                        Icons
                            .shopping_bag_outlined,
                        size: 22,
                      ),

                      const SizedBox(
                        width: 10,
                      ),

                      Text(
                        "Add to Cart  •  \$${controller.totalPrice.toStringAsFixed(2)}",

                        style:
                            const TextStyle(
                          fontSize: 16,
                          fontWeight:
                              FontWeight
                                  .w700,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}