import 'package:flutter/material.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.location_on_outlined, color: Colors.white, size: 30),

        const SizedBox(width: 8),

        const Text(
          "Current Location",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        const Icon(Icons.keyboard_arrow_down, color: Colors.white),
      ],
    );
  }
}
