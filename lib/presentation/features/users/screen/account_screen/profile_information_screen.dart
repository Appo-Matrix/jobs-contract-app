import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/features/users/screen/account_screen/widgets/account_widget.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/constants/image_string.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';

import '../../../../../utils/common_widgets/appbar.dart';
import '../../../../../utils/common_widgets/circular_shape.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/device/device_utility.dart';

class ProfileInformationScreen extends StatelessWidget {
  const ProfileInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    bool light = true;
    return Scaffold(
      appBar: JAppbar(
        title: Text(
          JText.accountSetting,
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            fontSize: JSizes.fontSizeLg,
            weight: FontWeight.w600,
          ),
        ),
        leadingIcon: JCircularAvatar(
          isDark: isDark,
          radius: 50, // Modify the radius to make it larger
          child: Icon(
            CupertinoIcons.back,
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 18, right: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [

          ],
          ),
        ),
      ),
    );
  }
}
