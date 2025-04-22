import 'package:flutter/material.dart';

import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';

class FilterChips extends StatelessWidget {
  final String label;
  final bool isSelected;
  final bool isDark;
  final VoidCallback? onTap;

  const FilterChips({
    super.key,
    required this.label,
    required this.isSelected,
    required this.isDark,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? JAppColors.backGroundDarkCard: JAppColors.primary.withOpacity(0.1))
              : (isDark ? JAppColors.darkGray700 : Colors.grey[100]),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: AppTextStyle.dmSans(
            color: isSelected
                ? (isDark ? Colors.white : JAppColors.primary)
                : (isDark ? JAppColors.darkGray300 : JAppColors.lightGray600),
            fontSize: 14.0,
            weight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
