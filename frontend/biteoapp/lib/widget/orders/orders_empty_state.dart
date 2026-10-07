import 'package:flutter/material.dart';

class OrdersEmptyState
    extends StatelessWidget {
  const OrdersEmptyState({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize:
            MainAxisSize.min,

        children: [
          Icon(
            Icons.receipt_long_rounded,
            size: 70,
            color:
                Color(0xFF8B5E3C),
          ),

          SizedBox(height: 15),

          Text(
            "No orders yet",

            style: TextStyle(
              color:
                  Color(0xFF2B1D16),
              fontSize: 18,
              fontWeight:
                  FontWeight.w700,
            ),
          ),

          SizedBox(height: 6),

          Text(
            "Your coffee orders will appear here",

            style: TextStyle(
              color:
                  Color(0xFF96877C),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}