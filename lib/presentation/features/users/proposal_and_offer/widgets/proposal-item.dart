import 'package:flutter/material.dart';

import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';

class ProposalItem extends StatelessWidget {
  final bool isDark;
  final String date;
  final String title;
  final String timeAgo;
  final VoidCallback onTap;

  const ProposalItem({
    Key? key,
    required this.isDark,
    required this.date,
    required this.title,
    required this.timeAgo,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Date
        Text(
          date,
          style: AppTextStyle.dmSans(
            fontSize: 14.0,
            weight: FontWeight.w500,
            color: isDark
                ? JAppColors.darkGray100.withOpacity(0.7)
                : JAppColors.darkGray800.withOpacity(0.6),
          ),
        ),

        const SizedBox(height: 8),

        // Title
        Text(
          title,
          style: AppTextStyle.dmSans(
            fontSize: 16.0,
            weight: FontWeight.w600,
            color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray800,
          ),
        ),

        const SizedBox(height: 6),

        // Time ago
        Text(
          timeAgo,
          style: AppTextStyle.dmSans(
            fontSize: 13.0,
            weight: FontWeight.w400,
            color: isDark
                ? JAppColors.darkGray100.withOpacity(0.5)
                : JAppColors.darkGray800.withOpacity(0.5),
          ),
        ),

        const SizedBox(height: 16),

        // See Details Button
        SizedBox(
          width: 140,
          height: 42,
          child: MainButton(
            btn_title: 'See Details',
            btn_radius: 8,
            btn_color: JAppColors.primary,
            title_color: Colors.white,
            text_fontweight: FontWeight.w600,
            image_value: false,
            onTap: onTap,
            isDark: isDark,
          ),
        ),
      ],
    );
  }
}
