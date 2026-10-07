import 'package:biteoapp/models/order_model.dart';
import 'package:biteoapp/widget/orders/order_address_card.dart';
import 'package:biteoapp/widget/orders/order_item_tile.dart';
import 'package:biteoapp/widget/orders/order_status_badge.dart';

import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;
  final VoidCallback onTap;

  const OrderCard({super.key, required this.order, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: const Color(0xFFFFFBF7),

          borderRadius: BorderRadius.circular(22),

          border: Border.all(color: const Color(0xFFE9DDD2)),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.035),
              blurRadius: 15,
              offset: const Offset(0, 6),
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // =========================
            // HEADER
            // =========================
            Row(
              children: [
                Container(
                  height: 45,
                  width: 45,

                  decoration: BoxDecoration(
                    color: const Color(0xFFF0E3D7),

                    borderRadius: BorderRadius.circular(14),
                  ),

                  child: const Icon(
                    Icons.coffee_rounded,
                    color: Color(0xFF8B5E3C),
                    size: 23,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        "Order #${order.id}",

                        style: const TextStyle(
                          color: Color(0xFF2B1D16),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const SizedBox(height: 3),

                      Text(
                        "${order.items.length} item${order.items.length == 1 ? '' : 's'}",

                        style: const TextStyle(
                          color: Color(0xFF9A8C82),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),

                OrderStatusBadge(status: order.status),
              ],
            ),

            const SizedBox(height: 16),

            // =========================
            // ITEMS
            // =========================
            ...order.items.map<Widget>((item) => OrderItemTile(item: item)),

            // =========================
            // ADDRESS
            // =========================
            OrderAddressCard(order: order),

            const Divider(color: Color(0xFFEADFD6), height: 28),

            // =========================
            // TOTAL
            // =========================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                const Text(
                  "Total",

                  style: TextStyle(color: Color(0xFF88786D), fontSize: 14),
                ),

                Text(
                  "\$${order.total}",

                  style: const TextStyle(
                    color: Color(0xFF6F472E),
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
