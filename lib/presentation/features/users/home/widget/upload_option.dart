import 'package:flutter/material.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/constants/app_text_style.dart';

class UploadOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isDark;

  const UploadOption({
    super.key,
    required this.icon,
    required this.title,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: JAppColors.main,
          size: 22,
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: AppTextStyle.dmSans(
            color: isDark ? Colors.white : JAppColors.lightGray100,
            fontSize: 14.0,
            weight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

