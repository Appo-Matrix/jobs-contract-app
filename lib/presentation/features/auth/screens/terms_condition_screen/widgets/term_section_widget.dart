import 'package:flutter/material.dart';
import '../../../../../../utils/constants/app_text_style.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';
import 'bullet_point_widget.dart';

class TermSectionWidget extends StatelessWidget {
  final String title;
  final String content;
  final bool isDark;
  final List<String>? bulletPoints;

  const TermSectionWidget({
    super.key,
    required this.title,
    required this.content,
    required this.isDark,
    this.bulletPoints,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
            fontSize: JSizes.fontSizeMd,
            weight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        if (content.isNotEmpty)
          Text(
            content,
            style: AppTextStyle.dmSans(
              color: isDark ? JAppColors.lightGray300 : JAppColors.darkGray700,
              fontSize: 14.0,
              weight: FontWeight.w400,
            ),
          ),
        if (bulletPoints != null && bulletPoints!.isNotEmpty) ...[
          const SizedBox(height: 8),
          ...bulletPoints!.map((point) => BulletPointWidget(text: point, isDark: isDark)),
        ],
        const SizedBox(height: 16),
      ],
    );
  }
}


