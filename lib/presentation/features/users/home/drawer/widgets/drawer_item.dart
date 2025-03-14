import 'package:flutter/material.dart';
import 'package:job_contracts/utils/device/device_utility.dart';

import '../../../../../../utils/constants/app_text_style.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';

// Custom drawer item for PNG/JPG icons only
class DrawerItem extends StatelessWidget {
  final String iconPath;
  final String title;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? textColor;

  const DrawerItem({
    Key? key,
    required this.iconPath,
    required this.title,
    required this.onTap,
    this.iconColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return ListTile(
      leading: Image.asset(
        iconPath,
        width: 24,
        height: 24,
        color: iconColor,
      ),
      title: Text(
        title,
        style: AppTextStyle.dmSans(
          fontSize: JSizes.fontSizeSm,
          weight: FontWeight.w500,
          color: textColor ?? (isDark ? JAppColors.darkGray100 : JAppColors.lightGray800),
        ),
      ),
      onTap: onTap,
    );
  }
}

