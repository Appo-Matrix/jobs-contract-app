import 'package:flutter/material.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';

class ContractDetailRowWidget extends StatelessWidget {
  final bool isDark;
  final String label;
  final String value;

  const ContractDetailRowWidget({
    super.key,
    required this.isDark,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// Label
        Text(
          label,
          style: AppTextStyle.dmSans(
            fontSize: 13.0,
            weight: FontWeight.w500,
            color: isDark
                ? JAppColors.darkGray100.withOpacity(0.7)
                : JAppColors.darkGray800.withOpacity(0.7),
          ),
        ),

        /// Value
        Text(
          value,
          style: AppTextStyle.dmSans(
            fontSize: 13.0,
            weight: FontWeight.w600,
            color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray800,
          ),
        ),
      ],
    );
  }
}
