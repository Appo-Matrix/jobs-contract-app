import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_string.dart';
import '../../../../../utils/constants/text_strings.dart';

class NotificationsContainer extends StatelessWidget {
  const NotificationsContainer({
    super.key,
    required this.isDark,
    required this.width,
    required this.height,
  });

  final bool isDark;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 2),
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: isDark
                ? JAppColors.lightGray100
                : JAppColors.darkGray800.withValues(alpha: 0.5)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                ClipOval(
                  child: Image(
                    image: AssetImage(JImages.google1), height: 24, width: 24,
                    fit: BoxFit.cover, // Ensures image covers the circle
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  'applicationSent',
                  style: AppTextStyle.dmSans(
                      color: isDark
                          ? JAppColors.lightGray100
                          : JAppColors.darkGray900,
                      fontSize: 16.0,
                      weight: FontWeight.w500),
                ).tr()
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'applicationSentDesc',
              style: AppTextStyle.dmSans(
                  color:
                      isDark ? JAppColors.lightGray400 : JAppColors.darkGray500,
                  fontSize: 14.0,
                  weight: FontWeight.w400),
            ).tr(),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Text(
                  'minutesAago',
                  style: AppTextStyle.dmSans(
                      color: isDark
                          ? JAppColors.lightGray400
                          : JAppColors.darkGray500,
                      fontSize: 16.0,
                      weight: FontWeight.w400),
                ).tr(),
                Spacer(),
                Text(
                  'delete',
                  style: AppTextStyle.dmSans(
                      color: JAppColors.error500,
                      fontSize: 16.0,
                      weight: FontWeight.w400),
                ).tr(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
