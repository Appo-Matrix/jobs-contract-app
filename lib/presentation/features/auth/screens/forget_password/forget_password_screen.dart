import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/common_widgets/appbar.dart';
import '../../../../../utils/common_widgets/back_circle.dart';
import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/common_widgets/text_field_widget.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../routes/app_routes.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,

      // Use SingleChildScrollView to prevent overflow
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(height: 40),
                Center(
                  child: Text(
                    'logo',
                    style: AppTextStyle.dmSans(
                      color: const Color(0xFF7C3AED),
                      fontSize: 28.0,
                      weight: FontWeight.bold,
                    ),
                  ).tr(),
                ),

                const SizedBox(height: 60),
                Text(
                  'forgetPassword',
                  style: AppTextStyle.dmSans(
                    color: isDark
                        ? JAppColors.darkGray200
                        : JAppColors.lightGray800,
                    fontSize: JSizes.fontSizeLg,
                    weight: FontWeight.w600,
                  ),
                ).tr(),
        
                SizedBox(height: JSizes.spaceBtwItems - 6),
        
                Text(
                  'plesdr',
                  style: AppTextStyle.dmSans(
                    height: 1.3,
                    color: isDark
                        ? JAppColors.darkGray200
                        : JAppColors.lightGray600,
                    fontSize: 16.0,
                    weight: FontWeight.w400,
                  ),
                ).tr(),
        
                SizedBox(height: JSizes.spaceBtwSections),
                TextFieldWidget(
                  subTitle: 'email',
                  hintText: 'email@gmail.com',
                  subtitleColor:
                  isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
                  titleColor:
                  isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
                ),
        
        
                SizedBox(height: JSizes.spaceBtwSections - 8),
        
                MainButton(
                  btn_color: JAppColors.primary,
        
                  btn_title: 'continue',
                  btn_radius: 10,isDark: isDark,
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
                      'alreadyAccount',
                      style: AppTextStyle.dmSans(
                        color: isDark
                            ? JAppColors.darkGray100
                            : JAppColors.lightGray800,
                        fontSize: 16.0,
                        weight: FontWeight.w400,
                      ),
        
                    ).tr(),
        
                    SizedBox(width: JSizes.spaceBtwItems - 10),
        
                    GestureDetector(
                      onTap: (){
                        AppRouter.router.push('/loginScreen');
                      },
                      child: Text(
                        'login',
                        style: AppTextStyle.dmSans(
                            color: isDark
                                ? JAppColors.darkGray100
                                : JAppColors.primary,
                            fontSize: 18.0,
                            weight: FontWeight.w600),
                      ).tr(),
                    ),
                  ],
                ),
        
                // Add some bottom padding to ensure everything is visible
                SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
