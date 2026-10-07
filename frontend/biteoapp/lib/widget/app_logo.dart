import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppLogo extends StatelessWidget {
  final double width;

  const AppLogo({
    super.key,
    this.width = 200,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/images/biteo_logo.svg',
      width: width,
    );
  }
}