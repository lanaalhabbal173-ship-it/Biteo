import 'package:flutter/material.dart';

class FavoritesEmptyState
    extends StatelessWidget {
  const FavoritesEmptyState({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize:
            MainAxisSize.min,

        children: [
          Container(
            width: 110,
            height: 110,

            decoration: BoxDecoration(
              color:
                  const Color(
                0xFFF0E3D7,
              ),

              borderRadius:
                  BorderRadius.circular(
                32,
              ),
            ),

            child: const Icon(
              Icons.favorite_border_rounded,
              size: 54,
              color:
                  Color(
                0xFF8B5E3C,
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            "No favorites yet",

            style: TextStyle(
              color:
                  Color(
                0xFF2B1D16,
              ),
              fontSize: 19,
              fontWeight:
                  FontWeight.w700,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            "Tap the heart on any product\nto save it here.",

            textAlign:
                TextAlign.center,

            style: TextStyle(
              color:
                  Color(
                0xFF8B7A6F,
              ),
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}