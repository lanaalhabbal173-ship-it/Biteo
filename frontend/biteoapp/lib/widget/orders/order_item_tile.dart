import 'package:biteoapp/models/order_model.dart';
import 'package:flutter/material.dart';

class OrderItemTile extends StatelessWidget {
  final OrderItemModel item;

  const OrderItemTile({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),

      decoration: BoxDecoration(
        color: const Color(0xFFF9F3ED),
        borderRadius: BorderRadius.circular(16),
      ),

      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),

            child: item.productImage.isEmpty
                ? _fallback()
                : Image.network(
                    item.productImage,
                    width: 55,
                    height: 55,
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

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  item.productName,

                  style: const TextStyle(
                    color: Color(0xFF3B2A20),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  "${item.size} • ${item.temperature}",

                  style: const TextStyle(
                    color: Color(0xFF9A8C82),
                    fontSize: 11.5,
                  ),
                ),

                if (item.extras.isNotEmpty) ...[
                  const SizedBox(height: 3),

                  Text(
                    item.extras.join(", "),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,

                    style: const TextStyle(
                      color: Color(0xFFB09D90),
                      fontSize: 10.5,
                    ),
                  ),
                ],
              ],
            ),
          ),

          Text(
            "x${item.quantity}",

            style: const TextStyle(
              color: Color(0xFF8B5E3C),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _fallback() {
    return Container(
      width: 55,
      height: 55,

      color: const Color(0xFFEDE1D6),

      child: const Icon(
        Icons.local_cafe_rounded,
        color: Color(0xFF8B5E3C),
        size: 28,
      ),
    );
  }
}