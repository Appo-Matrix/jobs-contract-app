import 'package:flutter/material.dart';

import '../../../../../utils/common_widgets/appbar.dart';
import '../../../../../utils/common_widgets/back_circle.dart';
import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/common_widgets/text_field_widget.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_string.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../routes/app_routes.dart';
import '../success/model/success_screen_args.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
      appBar: JAppbar(
        leadingIcon: BackCircle(
          isDark: isDark,
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        // Proper spacing
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              JText.resetPassword,
              style: AppTextStyle.dmSans(
                color:
                    isDark ? JAppColors.darkGray200 : JAppColors.lightGray900,
                fontSize: 24.0,
                weight: FontWeight.w600,
              ),
            ),

            SizedBox(height: JSizes.spaceBtwItems - 6),

            Text(
              JText.resetPasswordDec,

              style: AppTextStyle.dmSans(
                height: 1.3,
                color:
                    isDark ? JAppColors.darkGray200 : JAppColors.lightGray600,
                fontSize: 16.0,
                weight: FontWeight.w400,
              ),
            ),

            SizedBox(height: JSizes.spaceBtwSections),
            TextFieldWidget(
              subTitle: JText.enterNewPass,
              hintText: JText.enterNewPass,
              subtitleColor:
                  isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
              titleColor:
                  isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
            ),

            SizedBox(height: JSizes.spaceBtwInputFields),

            TextFieldWidget(
              subTitle: JText.repeatNewPass,
              hintText: JText.repeatNewPass,
              subtitleColor:
                  isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
              titleColor:
                  isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
            ),

            SizedBox(height: JSizes.spaceBtwInputFields + 20),

            MainButton(
              btn_color: JAppColors.primary,

              onTap: () {
                AppRouter.router.push(
                  '/successScreen',
                  extra: SuccessScreenArgs(
                    title: 'Password changed',
                    message: 'Your password has been change successfully!',
                    imagePath: JImages.successImage,
                    buttonText: 'Continue',
                    onButtonTap: () {
                      AppRouter.router.push('/loginScreen');
                    },
                  ),
                );
              },

              btn_title: JText.resetPassword,
              btn_radius: 10,
              btn_boarder_color: Color(0xff7030F1),
              title_color: Colors.white,
              text_fontweight: FontWeight.w600,
              image_value: false, isDark: isDark,
            ),
          ],
        ),
      ),
    );
  }
}
