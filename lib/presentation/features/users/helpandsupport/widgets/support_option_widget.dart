import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';

class SupportOptionWidget extends StatelessWidget {
  final String iconAsset;
  final String title;
  final String description;
  final VoidCallback onTap;
  final bool isDark;

  const SupportOptionWidget({
    super.key,
    required this.iconAsset,
    required this.title,
    required this.description,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? JAppColors.backGroundDarkCard : JAppColors.lightGray100.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDark
              ? JAppColors.darkGray700
              : JAppColors.lightGray300,
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark
                        ? JAppColors.primary.withOpacity(0.1)
                        : JAppColors.primary.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: JAppColors.primary.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: SvgPicture.asset(
                    iconAsset,
                    height: 24,
                    width: 24,
                    colorFilter: ColorFilter.mode(
                      JAppColors.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  title,
                  style: AppTextStyle.dmSans(
                    color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                    fontSize: 18.0,
                    weight: FontWeight.w600,
                  ),
                ).tr(),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: AppTextStyle.dmSans(
                    color: isDark ? JAppColors.darkGray200 : JAppColors.lightGray700,
                    fontSize: 12.0,
                    weight: FontWeight.w500,
                  ),
                ).tr(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}