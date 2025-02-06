import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_contracts/utils/common_widgets/main_button.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';
import '../../../../../utils/common_widgets/appbar.dart';
import '../../../../../utils/common_widgets/circular_shape.dart';
import '../../../../../utils/common_widgets/text_field_widget.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/device/device_utility.dart';

class ChangedPasswordScreen extends StatelessWidget {
  const ChangedPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: JAppbar(
        title: Text(
          JText.changedPassword,
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            fontSize: JSizes.fontSizeLg,
            weight: FontWeight.w600,
          ),
        ),
        leadingIcon: JCircularAvatar(
          isDark: isDark,
          radius: 20,
          // Modify the radius to make it larger
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
              Text(
                JText.changedPasswordTitle,
                style: AppTextStyle.dmSans(
                    color: isDark
                        ? JAppColors.lightGray100
                        : JAppColors.darkGray500,
                    fontSize: JSizes.fontSizeSm,
                    weight: FontWeight.w400,
                    height: 1.5),
              ),
              SizedBox(height: 25),
              TextFieldWidget(
                subTitle: 'Type your current password*',
                hintText: 'Current Password',
                subtitleColor: JAppColors.darkGray700,
              ),
              SizedBox(height: 25),
              TextFieldWidget(
                subTitle: 'Type your new password*',
                hintText: 'New Password',
                subtitleColor: JAppColors.darkGray700,
              ),
              SizedBox(height: 25),
              TextFieldWidget(
                subTitle: 'Retype your new password*',
                hintText: 'Re-type Password',
                subtitleColor: JAppColors.darkGray700,
              ),
              SizedBox(height: 55),
              Row(
                children: [
                  Image.asset(
                    'assets/icons/tick_icon.png',
                    width: 18,
                    height: 18,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Require all devices to sign in with new password',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.dmSans(
                      color: isDark
                          ? JAppColors.lightGray100
                          : JAppColors.darkGray500,
                      fontSize: JSizes.fontSizeXESm,
                      weight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 35),
              MainButton(
                btn_title: 'Save Password',
                btn_radius: 10,
                btn_color: JAppColors.main,
                btn_boarder_color: Colors.transparent,
                title_color: Colors.white,
                image_value: false,
              ),
              SizedBox(height: 20),
              Center(
                child: Text('Forget Password',style:  AppTextStyle.dmSans(
                  color: isDark
                      ? JAppColors.primary
                      : JAppColors.primary,
                  fontSize: JSizes.fontSizeLg,
                  weight: FontWeight.w600,
                ),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
