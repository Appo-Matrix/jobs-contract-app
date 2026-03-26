import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';

class ProfileSection extends StatelessWidget {
  final String title;
  final Widget content;
  final bool isDark;
  final Future<void> Function()? voidCallback; // ✅ async compatible
  final String? iconPath;
  final Future<void> Function()? onDelete;     // ✅ optional delete action

  const ProfileSection({
    super.key,
    required this.title,
    required this.content,
    required this.isDark,
    this.voidCallback,
    this.iconPath,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: AppTextStyle.dmSans(
                  fontSize: 18.0,
                  weight: FontWeight.w600,
                  color: isDark
                      ? JAppColors.darkGray100
                      : JAppColors.lightGray800,
                ),
              ).tr(),
              const Spacer(),

              // ✅ Delete button — only shown if onDelete is provided
              if (onDelete != null)
                GestureDetector(
                  onTap: onDelete,
                  child: Icon(
                    Icons.delete_outline,
                    size: 20,
                    color: JAppColors.error600,
                  ),
                ),

              if (onDelete != null) const SizedBox(width: 8),

              // ✅ Edit button — only shown if iconPath + voidCallback provided
              if (iconPath != null && iconPath!.isNotEmpty)
                GestureDetector(
                  onTap: voidCallback,
                  child: SvgPicture.asset(
                    iconPath!,
                    width: 20,
                    height: 20,
                    colorFilter: ColorFilter.mode(
                      isDark
                          ? JAppColors.lightGray100
                          : JAppColors.darkGray800,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          content,
        ],
      ),
    );
  }
}