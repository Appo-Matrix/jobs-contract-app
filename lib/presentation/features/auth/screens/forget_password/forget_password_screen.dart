import 'package:flutter/material.dart';
import '../../../../../utils/common_widgets/appbar.dart';
import '../../../../../utils/common_widgets/back_circle.dart';
import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/common_widgets/text_field_widget.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../routes/app_routes.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      appBar: JAppbar(
        leadingIcon: BackCircle(
          isDark: isDark,
          onTap: (){
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,

      // Use SingleChildScrollView to prevent overflow
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                JText.forgetPassword,
                style: AppTextStyle.dmSans(
                  color: isDark
                      ? JAppColors.darkGray200
                      : JAppColors.lightGray800,
                  fontSize: JSizes.fontSizeLg,
                  weight: FontWeight.w600,
                ),
              ),

              SizedBox(height: JSizes.spaceBtwItems - 6),

              Text(
                JText.plesdr,
                style: AppTextStyle.dmSans(
                  height: 1.3,
                  color: isDark
                      ? JAppColors.darkGray200
                      : JAppColors.lightGray600,
                  fontSize: 16.0,
                  weight: FontWeight.w400,
                ),
              ),

              SizedBox(height: JSizes.spaceBtwSections),
              TextFieldWidget(
                subTitle: JText.email,
                hintText: JText.emailEnter,
                subtitleColor:
                isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
                titleColor:
                isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
              ),


              SizedBox(height: JSizes.spaceBtwSections - 8),

              MainButton(
                btn_color: JAppColors.primary,

                btn_title: JText.sendCode,
                btn_radius: 10,isDark: isDark,
                btn_boarder_color: Color(0xff7030F1),
                title_color: Colors.white,
                text_fontweight: FontWeight.w600,
                image_value: false,
                onTap: (){
                  AppRouter.router.push('/forgetPasswordOtpScreen');
                },
              ),

              SizedBox(height: JSizes.spaceBtwSections),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    JText.alreadyAccount,
                    style: AppTextStyle.dmSans(
                      color: isDark
                          ? JAppColors.darkGray100
                          : JAppColors.lightGray800,
                      fontSize: 16.0,
                      weight: FontWeight.w400,
                    ),

                  ),

                  SizedBox(width: JSizes.spaceBtwItems - 10),

                  GestureDetector(
                    onTap: (){
                      AppRouter.router.push('/loginScreen');
                    },
                    child: Text(
                      JText.login,
                      style: AppTextStyle.dmSans(
                          color: isDark
                              ? JAppColors.darkGray100
                              : JAppColors.primary,
                          fontSize: 18.0,
                          weight: FontWeight.w600),
                    ),
                  ),
                ],
              ),

              // Add some bottom padding to ensure everything is visible
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}