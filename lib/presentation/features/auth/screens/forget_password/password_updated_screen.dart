import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_string.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../routes/app_routes.dart';
import 'package:easy_localization/easy_localization.dart';

class PasswordUpdatedScreen extends StatelessWidget {
  const PasswordUpdatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0 ,vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              // Logo
              Align(
                alignment: Alignment.centerLeft,
                child: SvgPicture.asset(
                  JImages.logoSVG,
                  height: 40,
                  width: 150,
                ),
              ),

              const Spacer(flex: 1),

              // Title
              Text(
                'Your Password is updated',
                style: AppTextStyle.dmSans(
                  color: isDark
                      ? JAppColors.lightGray100
                      : JAppColors.darkGray800,
                  fontSize: 22.0,
                  weight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 16),

              Text('Your password has been successfully updated.\nYour account\'s security is our priority.',
                style: AppTextStyle.dmSans(
                  color: isDark
                      ? JAppColors.darkGray300
                      : JAppColors.lightGray600,
                  fontSize: 14.0,
                  weight: FontWeight.w400,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 48),

              // Success Illustration - Using concord.svg
              Align(
                alignment: Alignment.center,

                child: SvgPicture.asset(
                  JImages.conicon,
                  width: 280,
                  height: 280,
                  fit: BoxFit.contain,
                ),
              ),

              const Spacer(flex: 2),

              // Done Button
              MainButton(
                btn_title: 'Done',
                btn_radius: 12,
                btn_color: JAppColors.primary,
                title_color: Colors.white,
                text_fontweight: FontWeight.w600,
                image_value: false,
                onTap: () {
                  // Navigate to login screen
                  AppRouter.router.pushReplacement('/loginScreen');
                },
                isDark: isDark,
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}