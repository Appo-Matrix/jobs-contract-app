import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

class BottomIndicator extends StatelessWidget {
  final bool isDark;

  const BottomIndicator({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 60,
        height: 4,
        decoration: BoxDecoration(
          color: isDark ? JAppColors.darkGray400 : Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}