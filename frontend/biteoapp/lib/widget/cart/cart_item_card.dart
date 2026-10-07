import 'package:biteoapp/controllers/cart_controller.dart';
import 'package:biteoapp/models/cart_item_model.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartItemCard extends StatelessWidget {
  final CartItemModel item;
  final CartController controller;

  const CartItemCard({
    super.key,
    required this.item,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        color: const Color(0xFFFFFBF7),
        borderRadius: BorderRadius.circular(22),

        border: Border.all(
          color: const Color(0xFFE9DDD2),
        ),
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          // =========================
          // IMAGE
          // =========================

          ClipRRect(
            borderRadius: BorderRadius.circular(16),

            child: item.productImage.isEmpty
                ? _fallback()
                : Image.network(
                    item.productImage,
                    width: 85,
                    height: 85,
                    fit: BoxFit.cover,

                    errorBuilder: (
                      context,
                      error,
                      stackTrace,
                    ) {
                      return _fallback();
                    },
                  ),
          ),

          const SizedBox(width: 14),

          // =========================
          // INFO
          // =========================

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  item.productName,

                  style: const TextStyle(
                    color: Color(0xFF2B1D16),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  "${item.size} • ${item.temperature}",

                  style: const TextStyle(
                    color: Color(0xFF8D7D72),
                    fontSize: 13,
                  ),
                ),

                if (item.extras.isNotEmpty) ...[
                  const SizedBox(height: 5),

                  Text(
                    item.extras.join(", "),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,

                    style: const TextStyle(
                      color: Color(0xFFAA988B),
                      fontSize: 11.5,
                    ),
                  ),
                ],

                const SizedBox(height: 12),

                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                  children: [
                    Text(
                      "\$${item.totalPrice.toStringAsFixed(2)}",

                      style: const TextStyle(
                        color: Color(0xFF6F472E),
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    _quantityControls(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =====================================
  // QUANTITY CONTROLS
  // =====================================

  Widget _quantityControls() {
    return Obx(() {
      final bool isUpdating =
          controller.updatingItemId.value == item.id;

      final bool isDeleting =
          controller.deletingItemId.value == item.id;

      final bool isBusy =
          isUpdating || isDeleting;

      return Row(
        mainAxisSize: MainAxisSize.min,

        children: [
          // MINUS / DELETE
          InkWell(
            onTap: isBusy
                ? null
                : () {
                    controller.decreaseQuantity(
                      item,
                    );
                  },

            borderRadius:
                BorderRadius.circular(10),

            child: Container(
              width: 32,
              height: 32,

              decoration: BoxDecoration(
                color: const Color(0xFFF0E3D7),

                borderRadius:
                    BorderRadius.circular(10),
              ),

              child: Icon(
                item.quantity == 1
                    ? Icons.delete_outline_rounded
                    : Icons.remove_rounded,

                size: 18,

                color: item.quantity == 1
                    ? const Color(0xFFB86B5E)
                    : const Color(0xFF8B5E3C),
              ),
            ),
          ),

          const SizedBox(width: 10),

          // QUANTITY / LOADING
          if (isBusy)
            const SizedBox(
              width: 18,
              height: 18,

              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Color(0xFF8B5E3C),
              ),
            )
          else
            Text(
              "${item.quantity}",

              style: const TextStyle(
                color: Color(0xFF2B1D16),
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),

          const SizedBox(width: 10),

          // PLUS
          InkWell(
            onTap: isBusy
                ? null
                : () {
                    controller.increaseQuantity(
                      item,
                    );
                  },

            borderRadius:
                BorderRadius.circular(10),

            child: Container(
              width: 32,
              height: 32,

              decoration: BoxDecoration(
                color: const Color(0xFF8B5E3C),

                borderRadius:
                    BorderRadius.circular(10),
              ),

              child: const Icon(
                Icons.add_rounded,
                size: 18,
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
    });
  }

  // =====================================
  // FALLBACK IMAGE
  // =====================================

  Widget _fallback() {
    return Container(
      width: 85,
      height: 85,

      color: const Color(0xFFF0E4D8),

      child: const Icon(
        Icons.local_cafe_rounded,
        color: Color(0xFF8B5E3C),
        size: 38,
      ),
    );
  }
}