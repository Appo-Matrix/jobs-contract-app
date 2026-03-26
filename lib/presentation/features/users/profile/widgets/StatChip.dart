import 'package:flutter/material.dart';

import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';

class StatChip extends StatelessWidget {
  final String label;
  final String value;
  final bool isDark;

  const StatChip({
    required this.label,
    required this.value,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: isDark
            ? JAppColors.darkGray800.withOpacity(0.6)
            : JAppColors.lightGray100,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isDark
              ? JAppColors.darkGray600.withOpacity(0.4)
              : JAppColors.lightGray300,
        ),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: AppTextStyle.dmSans(
              fontSize: 15.0,
              weight: FontWeight.w700,
              color:
              isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: AppTextStyle.dmSans(
              fontSize: 11.0,
              weight: FontWeight.w400,
              color:
              isDark ? JAppColors.darkGray400 : JAppColors.lightGray500,
            ),
          ),
        ],
      ),
    );
  }
}