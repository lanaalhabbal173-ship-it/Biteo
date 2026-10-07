import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderStatusBadge
    extends StatelessWidget {
  final String status;

  const OrderStatusBadge({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    Color background;
    Color textColor;

    switch (status) {
      case "completed":
        background =
            const Color(
          0xFFE6F2E8,
        );

        textColor =
            const Color(
          0xFF537A5B,
        );

        break;

      case "cancelled":
        background =
            const Color(
          0xFFF7E4E1,
        );

        textColor =
            const Color(
          0xFFA4584D,
        );

        break;

      default:
        background =
            const Color(
          0xFFFFEDD9,
        );

        textColor =
            const Color(
          0xFFA66B32,
        );
    }

    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 11,
        vertical: 6,
      ),

      decoration: BoxDecoration(
        color: background,

        borderRadius:
            BorderRadius.circular(
          20,
        ),
      ),

      child: Text(
        status.capitalizeFirst ??
            status,

        style: TextStyle(
          color: textColor,
          fontSize: 11,
          fontWeight:
              FontWeight.w700,
        ),
      ),
    );
  }
}