import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:job_contracts/utils/constants/app_text_style.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/device/device_utility.dart';

class OptionCard extends StatelessWidget {
  final String title;
  final String svgPath;
  final VoidCallback onTap;
  final double? height;
  final double? width;
  final double? iconSize;
  final double? borderRadius;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? textColor;

  const OptionCard({
    super.key,
    required this.title,
    required this.svgPath,
    required this.onTap,
    this.height = 180,
    this.width,
    this.iconSize = 60,
    this.borderRadius = 12,
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.w500,
    this.backgroundColor,
    this.iconColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    // Determine colors based on theme or provided custom colors
    final bgColor = backgroundColor ??
        (isDark ? JAppColors.backGroundDarkCard : const Color(0xFFF1F2F6));

    final defaultIconColor = isDark ? JAppColors.lightGray100 : JAppColors.darkGray800;
    final defaultTextColor = isDark ? JAppColors.lightGray100 : JAppColors.darkGray800;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(borderRadius!),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              svgPath,
              height: iconSize,
              width: iconSize,
              colorFilter: ColorFilter.mode(
                iconColor ?? defaultIconColor,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: AppTextStyle.dmSans(
                color: textColor ?? defaultTextColor,
                fontSize: fontSize,
                weight: fontWeight!,
              ),
              textAlign: TextAlign.center,
            ).tr(),
          ],
        ),
      ),
    );
  }
}