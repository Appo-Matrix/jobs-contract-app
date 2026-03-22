import 'package:flutter/material.dart';

import '../constants/app_text_style.dart';
import '../constants/colors.dart';

class EmptyStateWidget extends StatelessWidget {
  final bool isDark;
  final String title;
  final IconData icon;

  const EmptyStateWidget({
    super.key,
    required this.isDark,
    this.title = "No data found",
    this.icon = Icons.inbox_outlined,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 52,
            color: isDark
                ? JAppColors.darkGray500
                : Colors.grey[400],
          ),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyle.dmSans(
              fontSize: 14.0,
              weight: FontWeight.w400,
              color: isDark
                  ? JAppColors.darkGray500
                  : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}