import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_string.dart';
import '../../../../../utils/constants/text_strings.dart';

class NotificationDialog extends StatelessWidget {
  const NotificationDialog({
    super.key,
    required this.isDark,
  });

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16 ,horizontal: 16),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              JImages.notifications, // Replace with your image path
              height: 77,
              width: 77,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            Text(
              'noNotifications' ,
              style: AppTextStyle.dmSans(color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900, fontSize: 16.0, weight: FontWeight.w400),
            ).tr(),
            const SizedBox(height: 10),
            Text(
              'noNotificationsDesc',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ).tr(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
