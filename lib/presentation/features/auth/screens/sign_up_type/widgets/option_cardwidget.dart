import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../utils/constants/app_text_style.dart';
import '../../../../../../utils/constants/colors.dart';


class OptionCardWidget extends StatelessWidget {
  final String title;
  final String svgPath;
  final VoidCallback onTap;
  final bool isDark;

  const OptionCardWidget({
    super.key,
    required this.title,
    required this.svgPath,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          color: isDark ? JAppColors.backGroundDarkCard : JAppColors.lightGray100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              svgPath,
              height: 60,
              width: 60,
              colorFilter: ColorFilter.mode(
                isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: AppTextStyle.dmSans(
                color: isDark
                    ? JAppColors.lightGray100
                    : JAppColors.darkGray800,
                fontSize: 18.0,
                weight: FontWeight.w500,
              ),
            ).tr(),
          ],
        ),
      ),
    );
  }
}
