import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:job_contracts/presentation/features/auth/screens/sign_up_type/widgets/option_cardwidget.dart';
import 'package:job_contracts/presentation/routes/app_routes.dart';
import 'package:job_contracts/utils/common_widgets/appbar2.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';
import 'package:job_contracts/utils/constants/app_text_style.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/device/device_utility.dart';

import '../../../../../utils/constants/image_string.dart';

class AccountCreationScreen extends StatelessWidget {
  const AccountCreationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
      appBar: JAppBar2(
        title: 'backToLogin',
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                'createAccount',
                style: AppTextStyle.dmSans(
                  color:
                      isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                  fontSize: 24.0,
                  weight: FontWeight.w600,
                ),
              ).tr(),
              const SizedBox(height: 10),
              Text(
                'chooseOption',
                style: AppTextStyle.dmSans(
                  color:
                      isDark ? JAppColors.lightGray300 : JAppColors.darkGray500,
                  fontSize: 16.0,
                  weight: FontWeight.w400,
                ),
              ).tr(),
              const SizedBox(height: 40),
              Row(
                children: [
                  Expanded(
                    child: OptionCardWidget(
                      title: 'contractor',
                      svgPath: JImages.contractor,
                      onTap: () {
                        AppRouter.router.push('/signupScreen');

                        // Handle contractor selection
                        print('${JText.selected}${JText.contractor}');
                      },
                      isDark: isDark,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: OptionCardWidget(
                      title: 'professional',
                      svgPath: JImages.professional,
                      onTap: () {
                        AppRouter.router.push('/signupScreen');
                        // Handle professional selection
                        print('${JText.selected}${JText.professional}');
                      },
                      isDark: isDark,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
