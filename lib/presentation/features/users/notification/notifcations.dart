import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/features/users/notification/widgets/NotificationDialog.dart';
import 'package:job_contracts/presentation/features/users/notification/widgets/NotificationsContainer.dart';
import 'package:job_contracts/utils/constants/image_string.dart';
import 'package:job_contracts/utils/device/device_utility.dart';

import '../../../../utils/common_widgets/appbar.dart';
import '../../../../utils/common_widgets/back_circle.dart';
import '../../../../utils/common_widgets/circular_shape.dart';
import '../../../../utils/constants/app_text_style.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/text_strings.dart';

class NotifcationsScreen extends StatefulWidget {
  const NotifcationsScreen({super.key});

  @override
  State<NotifcationsScreen> createState() => _NotifcationsScreenState();
}

class _NotifcationsScreenState extends State<NotifcationsScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    return Scaffold(
      backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
      appBar: JAppbar(
        title: Text(
          JText.notifications,
          style: AppTextStyle.dmSans(
              color: isDark ? JAppColors.lightGray100 : JAppColors.lightGray800,
              fontSize: 16.0,
              weight: FontWeight.w500),
        ),
        leadingIcon: BackCircle(
          isDark: isDark,
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              NotificationsContainer(
                isDark: isDark,
                width: double.infinity,
                height: 130,
              ),
              NotificationDialog(isDark: isDark),
            ],
          ),
        ),
      ),
    );
  }
}
