import 'package:flutter/material.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';

class InfoRowWidget extends StatelessWidget {
  final bool isDark;
  final IconData icon;
  final String label;
  final String value;

  const InfoRowWidget({
    super.key,
    required this.isDark,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// Icon
        Icon(
          icon,
          size: 18,
          color: isDark
              ? JAppColors.darkGray100.withOpacity(0.6)
              : JAppColors.darkGray800.withOpacity(0.6),
        ),
        const SizedBox(width: 8),

        /// Label
        Text(
          '$label: ',
          style: AppTextStyle.dmSans(
            fontSize: 13.0,
            weight: FontWeight.w500,
            color: isDark
                ? JAppColors.darkGray100.withOpacity(0.7)
                : JAppColors.darkGray800.withOpacity(0.7),
          ),
        ),

        /// Value (expands if text is long)
        Expanded(
          child: Text(
            value,
            style: AppTextStyle.dmSans(
              fontSize: 13.0,
              weight: FontWeight.w600,
              color: isDark
                  ? JAppColors.darkGray100
                  : JAppColors.darkGray800,
            ),
          ),
        ),
      ],
    );
  }
}
