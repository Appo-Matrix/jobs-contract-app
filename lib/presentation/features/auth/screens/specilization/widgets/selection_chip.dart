import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../utils/constants/app_text_style.dart';
import '../../../../../../utils/constants/colors.dart';

class SelectionChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isDark;

  const SelectionChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 34,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isDark ? JAppColors.darkGray800 : JAppColors.lightGray100,
          borderRadius: BorderRadius.circular(8),
          border: isSelected
              ? Border.all(
                  color: isDark ? JAppColors.darkGray800 : Colors.white,
                  width: 2)
              : null,
        ),
        child: Text(
          label,

          style: AppTextStyle.dmSans(
            color: isSelected
                ? const Color(0xFF6C38FF)
                : isDark
                    ? JAppColors.darkGray100
                    : JAppColors.darkGray900,
            fontSize: 14.0,
            weight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),

          // ),
        ).tr(),
      ),
    );
  }
}
