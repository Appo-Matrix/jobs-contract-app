import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

class BottomIndicator extends StatelessWidget {
  final bool isDark;
  final double height;

  const BottomIndicator({super.key, required this.isDark, required this.height});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: isDark ? JAppColors.darkGray400 : Colors.black,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}