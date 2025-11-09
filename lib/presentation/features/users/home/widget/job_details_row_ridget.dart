import 'package:flutter/material.dart';

import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';

class JobDetailsRowWidget extends StatelessWidget {
  final String label;
  final String value;
  final bool isDark;

  const JobDetailsRowWidget({
    super.key,
    required this.label,
    required this.value,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyle.onest(
            fontSize: 14.0,
            weight: FontWeight.w400,
            color: isDark ? JAppColors.lightGray300 : JAppColors.lightGray600,
          ),
        ),
        Text(
          value,
          style: AppTextStyle.onest(
            fontSize: 14.0,
            weight: FontWeight.w600,
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
          ),
        ),
      ],
    );
  }
}
