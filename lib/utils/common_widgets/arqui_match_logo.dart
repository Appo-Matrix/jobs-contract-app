import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ArquiMatchLogo extends StatelessWidget {
  final String logo;
  final double logoHeight;
  final double logoWidth;

  const ArquiMatchLogo({
    super.key,
    required this.logo,
    this.logoHeight = 52.0, // default height
    this.logoWidth = 86.0,  // default width
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      width: double.infinity,
      child: SvgPicture.asset(
        logo, // dynamic logo path
        height: logoHeight,
        width: logoWidth,
      ),
    );
  }
}
