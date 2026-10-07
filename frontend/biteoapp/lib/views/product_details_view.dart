import 'package:biteoapp/controllers/product_details_controller.dart';

import 'package:biteoapp/widget/product_details/add_to_cart_bar.dart';
import 'package:biteoapp/widget/product_details/drink_type_selector.dart';
import 'package:biteoapp/widget/product_details/product_extras_section.dart';
import 'package:biteoapp/widget/product_details/product_image_header.dart';
import 'package:biteoapp/widget/product_details/product_info_section.dart';
import 'package:biteoapp/widget/product_details/product_size_selector.dart';
import 'package:biteoapp/widget/product_details/quantity_selector.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsView extends GetView<ProductDetailsController> {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F1EA),

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    // IMAGE + BACK + FAVORITE
                    ProductImageHeader(product: controller.product),

                    const SizedBox(height: 24),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          // NAME + PRICE
                          ProductInfoSection(controller: controller),

                          const SizedBox(height: 28),

                          // SIZE
                          ProductSizeSelector(controller: controller),

                          const SizedBox(height: 28),

                          // HOT / ICED
                          DrinkTypeSelector(controller: controller),

                          const SizedBox(height: 28),

                          // EXTRAS
                          ProductExtrasSection(controller: controller),

                          const SizedBox(height: 24),

                          // QUANTITY
                          QuantitySelector(controller: controller),

                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ADD TO CART
            AddToCartBar(controller: controller),
          ],
        ),
      ),
    );
  }
}
