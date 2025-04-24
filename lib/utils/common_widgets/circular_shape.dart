import 'package:flutter/material.dart';
import '../constants/colors.dart';

class JCircularAvatar extends StatelessWidget {
  final bool isDark;
  final double radius;  // Required radius
  final Widget child;    // Required child inside CircleAvatar
  final Color borderColor;  // Border color
  final double borderWidth;
  final Color? backColor;  // Background color

  const JCircularAvatar({
    super.key,
    required this.isDark,
    required this.radius,  // Accept radius as a parameter
    required this.child,    // Accept child widget as a parameter
    this.borderColor = JAppColors.lightGray300, // Default border color
    this.borderWidth = 2.0,
    this.backColor,  // Default border width
  });

  @override
  Widget build(BuildContext context) {
    // Calculate total diameter including border
    final totalDiameter = (radius * 2) + (borderWidth * 2);

    return Container(
      width: totalDiameter,
      height: totalDiameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backColor ?? Colors.transparent,
        border: Border.all(
          color: isDark ? borderColor.withOpacity(0.5) : borderColor,
          width: borderWidth,
        ),
      ),
      child: Center(
        child: SizedBox(
          width: radius * 2,
          height: radius * 2,
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}