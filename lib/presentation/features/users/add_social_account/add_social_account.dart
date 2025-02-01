import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';
import '../../../../utils/common_widgets/appbar.dart';
import '../../../../utils/common_widgets/circular_shape.dart';
import '../../../../utils/common_widgets/main_button.dart';
import '../../../../utils/constants/app_text_style.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';

class AddSocialAccount extends StatefulWidget {
  const AddSocialAccount({super.key});

  @override
  State<AddSocialAccount> createState() => _AddSocialAccountState();
}

class _AddSocialAccountState extends State<AddSocialAccount> {
  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      appBar: JAppbar(
        title: Text(
          JText.addSocialAccount11s,
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
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(

          children: [
            Text(
              JText.addSocialAccount11s,
              style: AppTextStyle.dmSans(
                color:
                    isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                fontSize: 20.0,
                weight: FontWeight.w600,
              ),
            ),

            Text(

              JText.addSocialAccountDesc,
              style: AppTextStyle.dmSans(
                color:
                    isDark ? JAppColors.darkGray100 : JAppColors.lightGray800.withValues(alpha: 0.5),
                fontSize: 16.0,
                weight: FontWeight.w400,
              ),
            ),

            MainButton(
              btn_title: JText.connectWithFacebook,
              btn_radius: 10,
              btn_color: JAppColors.main,
              btn_boarder_color: Color(0xff7030F1),
              title_color: Colors.white,
              btn_image: JImages.facebook1,
              text_fontweight: FontWeight.w600,
              image_value: false,
            ),
            const SizedBox(height: 12),
            MainButton(
              btn_title: JText.connectWithGoogle,
              btn_radius: 10,
              btn_color: Colors.transparent,
              btn_boarder_color: JAppColors.t,
              title_color: JAppColors.lightGray700,
              text_fontweight: FontWeight.w600,
              btn_image: JImages.google1,
              image_value: true,
              text_size: JSizes.fontSizeMd,
            ),

          ],
        ),
      ),
    );
  }
}
