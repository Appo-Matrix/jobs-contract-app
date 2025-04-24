import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/common_widgets/appbar2.dart';
import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../routes/app_routes.dart';


class CheckEmailScreen extends StatelessWidget {

  const CheckEmailScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final isDark = JDeviceUtils.isDarkMode(context);
    final backgroundColor = isDark ? JAppColors.backGroundDark : Colors.white;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: JAppBar2(title: 'back'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'checkEmail',
                style: AppTextStyle.dmSans(
                  color: isDark
                      ? JAppColors.lightGray100
                      : JAppColors.darkGray800,
                  fontSize: 24.0,
                  weight: FontWeight.w600,
                ),

              ).tr(),
              const SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'passwordResetSent'.tr(),
                      style: AppTextStyle.dmSans(
                        color: isDark
                            ? JAppColors.lightGray300
                            : JAppColors.darkGray600,
                        fontSize: 14.0,
                        weight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: 'email'.tr(),
                      style: AppTextStyle.dmSans(
                        color: isDark
                            ? JAppColors.lightGray100
                            : JAppColors.darkGray800,
                        fontSize: 16.0,
                        weight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 100),

              // Open email app button
              MainButton(
                btn_title: 'openEmailApp',
                btn_radius: 10,
                btn_color: JAppColors.primary,
                btn_boarder_color: Colors.transparent,
                title_color: Colors.white,
                text_fontweight: FontWeight.w600,
                image_value: false,
                onTap: (){


                  AppRouter.router.push('/emailVerifiedScreen');

                },

                text_size:  JSizes.fontSizeMd,
              ),

              const SizedBox(height:32),

              // Didn't receive email text
              Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'didntReceiveEmail'.tr(),
                        style: AppTextStyle.dmSans(
                          color: isDark
                              ? JAppColors.lightGray300
                              : JAppColors.darkGray600,
                          fontSize: 16.0,
                          weight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: 'clickToResend'.tr() ,
                        style: AppTextStyle.dmSans(
                          color: isDark
                              ? JAppColors.lightGray100
                              : JAppColors.primary,
                          fontSize: 16.0,
                          weight: FontWeight.w500,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Implement resend logic
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}