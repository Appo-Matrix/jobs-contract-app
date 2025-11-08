
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/common_widgets/appbar.dart';
import '../../../../../utils/common_widgets/back_circle.dart';
import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../routes/app_routes.dart';
import '../widgets/activity_log_section.dart';
import '../widgets/contract_description_section.dart';
import '../widgets/contract_detail_section.dart';

class ContractDetailScreen extends StatelessWidget {
  const ContractDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,

      appBar: JAppbar(
        title: Text(
          'appBarTitle',
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
            fontSize: 19.0,
            weight: FontWeight.w500,
          ),
        ).tr(),
        leadingIcon: Padding(
          padding: const EdgeInsets.all(3.0),
          child: BackCircle(
            isDark: isDark,
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Contract description section

              const SizedBox(height: 12),

              ContractDescription(isDark: isDark),

              const SizedBox(height: 16),

              // Activity log section
              ActivityLogSection(isDark: isDark),

              const SizedBox(height: 16),

              // Contract details section with salary and contractor info


              ContractDetailsSection(isDark: isDark),

              const SizedBox(height: 24),
              Row(
                children: [

                  Expanded(
                    child: MainButton(
                      btn_title: 'sendMessage',
                      btn_radius: 10,
                      btn_color: Colors.transparent,

                      title_color:
                      isDark ? JAppColors.darkGray100 : JAppColors.primary,
                      text_fontweight: FontWeight.w600,
                      image_value: false,
                      onTap: () {                    AppRouter.router.push('/chatScreen');
                      },
                      text_size: JSizes.fontSizeMd,
                    ),
                  ),
                  const SizedBox(width: 12),

                  Expanded(
                    child: MainButton(
                      btn_title: 'deliverNowButton',
                      btn_radius: 10,
                      btn_color: JAppColors.main,

                      title_color: Colors.white,
                      text_fontweight: FontWeight.w600,
                      image_value: false,
                      onTap: () {

                        AppRouter.router.push('/deliverContractScreen');
                      },
                    ),
                  ),
                ],
              ),

              // Bottom indicator
            ],
          ),
        ),
      ),
    );
  }
}

