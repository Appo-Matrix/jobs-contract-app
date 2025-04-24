import 'package:flutter/material.dart';

import '../../../../../../utils/constants/app_text_style.dart';
import '../../../../../../utils/constants/colors.dart';

class CustomCheckboxWidget extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool?> onChanged;
  final bool isDark;

  const CustomCheckboxWidget({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: JAppColors.primary,
            checkColor: Colors.white,
            side: BorderSide(
              color: isDark ? JAppColors.lightGray300 : JAppColors.darkGray500,
              width: 1.5,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: AppTextStyle.dmSans(
              color: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
              fontSize: 14.0,
              weight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
