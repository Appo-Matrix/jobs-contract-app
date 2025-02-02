import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/features/users/notification/widgets/NotificationDialog.dart';
import 'package:job_contracts/presentation/features/users/notification/widgets/NotificationsContainer.dart';
import 'package:job_contracts/utils/constants/image_string.dart';
import 'package:job_contracts/utils/device/device_utility.dart';

import '../../../../utils/common_widgets/appbar.dart';
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
      appBar: JAppbar(
        title: Text(
          JText.notifications,
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            fontSize: 20.0,
            weight: FontWeight.w600,
          ),
        ),
        leadingIcon: JCircularAvatar(
          isDark: isDark,
          radius: 20, // Modify the radius to make it larger
          child: Icon(
            CupertinoIcons.back,
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
          ),
        ),
      ),


      body: Padding(padding: EdgeInsets.symmetric(vertical: 16,horizontal: 16),

      child: SingleChildScrollView(
        child: Column(
        
          children: [

            NotificationsContainer(isDark: isDark, width: double.infinity, height: 130,),
            NotificationDialog(isDark: isDark),


          ],
        
        
        ),
      ),),
    );
  }
}


