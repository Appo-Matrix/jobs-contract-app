import 'package:flutter/material.dart';

import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class SkillChip12 extends StatelessWidget {
  final String name;
  final bool isSelected;
  final bool isDark;
  final VoidCallback onTap;

  const SkillChip12({
    required this.name,
    required this.isSelected,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? JAppColors.primary
              : isDark
              ? JAppColors.backGroundDarkCard
              : JAppColors.lightGray100,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected
                ? JAppColors.primary
                : isDark
                ? JAppColors.darkGray500
                : JAppColors.lightGray300,
            width: isSelected ? 0 : 1,
          ),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: JAppColors.primary.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSelected) ...[
              const Icon(Icons.check_circle, size: 14, color: Colors.white),
              const SizedBox(width: 6),
            ],
            Text(
              name,
              style: AppTextStyle.dmSans(
                fontSize: JSizes.fontSizeSm,
                weight: FontWeight.w500,
                color: isSelected
                    ? Colors.white
                    : isDark
                    ? JAppColors.lightGray100
                    : JAppColors.darkGray700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}