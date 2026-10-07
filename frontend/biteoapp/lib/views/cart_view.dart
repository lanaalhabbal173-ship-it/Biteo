import 'package:biteoapp/controllers/cart_controller.dart';
import 'package:biteoapp/widget/cart/cart_empty_state.dart';
import 'package:biteoapp/widget/cart/cart_item_card.dart';
import 'package:biteoapp/widget/cart/cart_summary.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartView extends StatelessWidget {
  CartView({super.key});

  final CartController controller =
      Get.isRegistered<CartController>()
          ? Get.find<CartController>()
          : Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F1EA),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F1EA),
        elevation: 0,
        centerTitle: true,

        title: const Text(
          "My Cart",
          style: TextStyle(
            color: Color(0xFF2B1D16),
            fontWeight: FontWeight.w700,
          ),
        ),

        leading: IconButton(
          onPressed: Get.back,
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF2B1D16),
          ),
        ),
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF8B5E3C),
            ),
          );
        }

        if (controller.items.isEmpty) {
          return const CartEmptyState();
        }

        return Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                color: const Color(0xFF8B5E3C),
                onRefresh: controller.fetchCart,

                child: ListView.separated(
                  physics:
                      const AlwaysScrollableScrollPhysics(),

                  padding: const EdgeInsets.all(20),

                  itemCount: controller.items.length,

                  separatorBuilder: (_, __) =>
                      const SizedBox(height: 14),

                  itemBuilder: (context, index) {
                    final item =
                        controller.items[index];

                    return CartItemCard(
                      item: item,
                      controller: controller,
                    );
                  },
                ),
              ),
            ),

            CartSummary(
              controller: controller,
            ),
          ],
        );
      }),
    );
  }
}