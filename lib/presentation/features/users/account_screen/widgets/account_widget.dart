import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../utils/constants/app_text_style.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/device/device_utility.dart';

class AccountWidgetContainer extends StatelessWidget {
  final String iconsImage;
  final String title;
  final String? subTitle;
  final Widget child;

  const AccountWidgetContainer({
    super.key,
    required this.iconsImage,
    required this.title,
    this.subTitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    return Container(
      decoration: BoxDecoration(
        color: isDark ? JAppColors.backGroundDarkCard : Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12)),
          border: Border.all(color: JAppColors.lightGray300)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Column(

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  iconsImage,
                  width: 22,
                  height: 22,
                  color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                ),
                SizedBox(width: 10),
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.dmSans(
                    color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                    fontSize: JSizes.fontSizeMd,
                    weight: FontWeight.w500,
                    height: 1.5,
                  ),
                ).tr(),

                Spacer(),
                child,
              ],
            ),
            Row(
              children: [
                SizedBox(height: 32,width: 24),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    subTitle!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: AppTextStyle.dmSans(
                      color: isDark ? JAppColors.lightGray100 : JAppColors.lightGray500,
                      fontSize: JSizes.fontSizeEaSm,
                      weight: FontWeight.w400,
                      height: 1.5,
                    ),
                  ).tr(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
