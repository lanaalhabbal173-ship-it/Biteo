import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,

      decoration: BoxDecoration(
        color: const Color(0xFFFFFBF7),

        borderRadius: BorderRadius.circular(22),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.08),
            blurRadius: 22,
            offset: const Offset(0, 8),
          ),
        ],

        border: Border.all(color: const Color(0xFFEDE2D8)),
      ),

      child: Row(
        children: [
          const SizedBox(width: 18),

          const Icon(Icons.search_rounded, color: Color(0xFF9C8A7C), size: 26),

          const SizedBox(width: 12),

          const Expanded(
            child: Text(
              "Search coffee, tea, desserts...",
              style: TextStyle(
                color: Color(0xFFA89B90),
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          Container(
            margin: const EdgeInsets.only(right: 7),

            height: 48,
            width: 48,

            decoration: BoxDecoration(
              color: const Color(0xFF8B5E3C),
              borderRadius: BorderRadius.circular(16),
            ),

            child: const Icon(
              Icons.tune_rounded,
              color: Colors.white,
              size: 23,
            ),
          ),
        ],
      ),
    );
  }
}
