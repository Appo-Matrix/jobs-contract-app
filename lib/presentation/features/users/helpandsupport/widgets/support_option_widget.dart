import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Make sure to add this package to pubspec.yaml

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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDark ? JAppColors.backGroundDarkCard : JAppColors.lightGray100,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              iconAsset,
              height: 24,
              width: 24,
              colorFilter: ColorFilter.mode(
                isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                BlendMode.srcIn,
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
    );
  }
}