import 'package:flutter/material.dart';

import '../../../../../../utils/constants/app_text_style.dart';
import '../../../../../../utils/constants/colors.dart';

class RequirementItem extends StatelessWidget {
  final String text;
  final bool isDark;

  const RequirementItem({
    super.key,
    required this.text,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.check_circle_outline,
          size: 16,
          color: isDark ? JAppColors.darkGray300 : JAppColors.lightGray600,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: AppTextStyle.dmSans(
              color: isDark ? JAppColors.darkGray300 : JAppColors.lightGray600,
              fontSize: 13.0,
              weight: FontWeight.w400,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}
