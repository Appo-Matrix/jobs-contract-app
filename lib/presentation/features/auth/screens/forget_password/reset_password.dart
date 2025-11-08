import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/common_widgets/text_field_widget.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_string.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../routes/app_routes.dart';
import '../success/model/success_screen_args.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),

                // Logo Section
                Text(
                  'logo',
                  style: AppTextStyle.dmSans(
                    color: const Color(0xFF7C3AED),
                    fontSize: 28.0,
                    weight: FontWeight.bold,
                  ),
                ).tr(),

                const SizedBox(height: 60),

                // Title
                Text(
                  'resetPassword',
                  style: AppTextStyle.dmSans(
                    color: isDark ? JAppColors.darkGray200 : JAppColors.lightGray900,
                    fontSize: 24.0,
                    weight: FontWeight.w600,
                  ),
                ).tr(),

                SizedBox(height: JSizes.spaceBtwItems - 6),

                // Description
                Text(
                  'resetPasswordDec',
                  style: AppTextStyle.dmSans(
                    height: 1.3,
                    color: isDark ? JAppColors.darkGray200 : JAppColors.lightGray600,
                    fontSize: 16.0,
                    weight: FontWeight.w400,
                  ),
                ).tr(),

                SizedBox(height: JSizes.spaceBtwSections),

                // New Password Field
                TextFieldWidget(
                  subTitle: 'enterNewPass',
                  hintText: 'enterNewPass',
                  subtitleColor: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                  titleColor: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                  obscureText: !_isNewPasswordVisible,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isNewPasswordVisible = !_isNewPasswordVisible;
                      });
                    },
                    child: Icon(
                      _isNewPasswordVisible
                          ? CupertinoIcons.eye_slash
                          : CupertinoIcons.eye,
                      color: isDark ? JAppColors.lightGray300 : JAppColors.darkGray600,
                    ),
                  ),
                ),

                SizedBox(height: JSizes.spaceBtwInputFields),

                // Repeat Password Field
                TextFieldWidget(
                  subTitle: 'repeatNewPass',
                  hintText: 'repeatNewPass',
                  subtitleColor: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                  titleColor: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                  obscureText: !_isConfirmPasswordVisible,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      });
                    },
                    child: Icon(
                      _isConfirmPasswordVisible
                          ? CupertinoIcons.eye_slash
                          : CupertinoIcons.eye,
                      color: isDark ? JAppColors.lightGray300 : JAppColors.darkGray600,
                    ),
                  ),
                ),

                SizedBox(height: JSizes.spaceBtwInputFields + 20),

                // Reset Password Button
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
                  btn_title: 'resetPassword',
                  btn_radius: 10,
                  title_color: Colors.white,
                  text_fontweight: FontWeight.w600,
                  image_value: false,
                  isDark: isDark,
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}