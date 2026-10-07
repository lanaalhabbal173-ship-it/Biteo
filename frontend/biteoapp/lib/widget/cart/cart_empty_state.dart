import 'package:flutter/material.dart';

class CartEmptyState extends StatelessWidget {
  const CartEmptyState({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,

        children: [
          Icon(
            Icons.shopping_bag_outlined,
            size: 70,
            color: Color(0xFF8B5E3C),
          ),

          SizedBox(height: 15),

          Text(
            "Your cart is empty",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2B1D16),
            ),
          ),
        ],
      ),
    );
  }
}