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
    Key? key,
    required this.isDark,
    required this.radius,  // Accept radius as a parameter
    required this.child,    // Accept child widget as a parameter
    this.borderColor = JAppColors.lightGray300, // Default border color
    this.borderWidth = 2.0,
    this.backColor,  // Default border width
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2 + borderWidth * 2,  // Adjust width to include border
      height: radius * 2 + borderWidth * 2,  // Adjust height to include border
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backColor,  // Set the background color here
        border: Border.all(
          color: isDark ? borderColor.withOpacity(0.5) : borderColor,  // Border color
          width: borderWidth,  // Border width
        ),
      ),
      // Use Center to position the child properly in the container
      child: Center(
        child: SizedBox(
          width: radius * 2,
          height: radius * 2,
          child: child,
        ),
      ),
    );
  }
}