import 'package:flutter/material.dart';

class CoffeeAuthHeader extends StatelessWidget {
  const CoffeeAuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 285,
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // DARK BROWN CIRCLE
          Positioned(
            top: -110,
            right: -70,
            child: Container(
              width: 265,
              height: 265,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF9A6846),
              ),
            ),
          ),

          // LIGHT BEIGE CIRCLE
          Positioned(
            top: -35,
            right: -55,
            child: Container(
              width: 225,
              height: 225,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFC5A184),
              ),
            ),
          ),

          // COFFEE IMAGE
          Positioned(
            top: 5,
            right: -6,
            child: Image.asset(
              "assets/images/login_coffee.png",
              width: 175,
              height: 175,
              fit: BoxFit.contain,
            ),
          ),

          // WELCOME
          const Positioned(
            left: 0,
            top: 145,
            child: Text(
              "Welcome Back ☕",
              style: TextStyle(
                color: Color(0xFF9A6846),
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          // MAIN TITLE
          const Positioned(
            left: 0,
            top: 182,
            right: 20,
            child: Text(
              "Your perfect\ncoffee is waiting.",
              style: TextStyle(
                color: Color(0xFF2B1D16),
                fontSize: 31,
                height: 1.08,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
            ),
          ),

          // SUBTITLE
          const Positioned(
            left: 0,
            bottom: 0,
            right: 70,
            child: Text(
              "Sign in and continue your\ncoffee journey",
              style: TextStyle(
                color: Color(0xFF74665D),
                fontSize: 14,
                height: 1.45,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
