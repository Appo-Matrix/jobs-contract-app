import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../../utils/common_widgets/appbar.dart';
import '../../../../../../utils/common_widgets/back_circle.dart';
import '../../../../../../utils/common_widgets/main_button.dart';
import '../../../../../../utils/constants/app_text_style.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/device/device_utility.dart';
import 'model/success_screen_args.dart';

class SuccessScreen extends StatelessWidget {
  final SuccessScreenArgs args;

  const SuccessScreen({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
      appBar: JAppbar(
        leadingIcon: BackCircle(
          isDark: isDark,
          onTap: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                args.imagePath,
                height: 77,
                width: 77,
              ),
              const SizedBox(height: 20),
              Text(
                args.title,
                style: AppTextStyle.dmSans(
                  color: isDark
                      ? JAppColors.darkGray100
                      : JAppColors.lightGray900,
                  fontSize: 16.0,
                  weight: FontWeight.w400,
                ),
              ).tr(),
              const SizedBox(height: 10),
              Text(
                args.message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ).tr(),
              const SizedBox(height: 30),
              MainButton(
                btn_color: JAppColors.primary,

                onTap: args.onButtonTap,
                btn_title: args.buttonText,
                btn_radius: 10,
                title_color: Colors.white,
                text_fontweight: FontWeight.w600,
                image_value: false, isDark: isDark,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
