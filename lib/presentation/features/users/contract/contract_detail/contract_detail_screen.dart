
import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/features/users/contract/contract_detail/widgets/activity_log_section.dart';
import 'package:job_contracts/presentation/features/users/contract/contract_detail/widgets/conractor_profile.dart';
import 'package:job_contracts/presentation/features/users/contract/contract_detail/widgets/contract_description_section.dart';
import 'package:job_contracts/presentation/features/users/contract/contract_detail/widgets/contract_detail_section.dart';
import 'package:job_contracts/presentation/features/users/contract/contract_detail/widgets/file_attachment.dart';

import '../../../../../utils/common_widgets/appbar.dart';
import '../../../../../utils/common_widgets/back_circle.dart';
import '../../../../../utils/common_widgets/bottom_indicator.dart';
import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../routes/app_routes.dart';

class ContractDetailScreen extends StatelessWidget {
  const ContractDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: SizedBox(
          height: 50,
          child: Row(
            children: [
              Expanded(
                child: MainButton(
                  btn_title: JText.submitWork,
                  btn_radius: 10,
                  btn_color: JAppColors.main,
                  btn_boarder_color: const Color(0xff7030F1),
                  title_color: Colors.white,
                  text_fontweight: FontWeight.w600,
                  image_value: false,
                  onTap: () {
                    AppRouter.router.push('/contractDetailScreen');
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: MainButton(
                  btn_title: JText.sendMessage,
                  btn_radius: 10,
                  btn_color: Colors.transparent,
                  btn_boarder_color:
                      isDark ? JAppColors.darkGray100 : JAppColors.primary,
                  title_color:
                      isDark ? JAppColors.darkGray100 : JAppColors.primary,
                  text_fontweight: FontWeight.w600,
                  image_value: false,
                  onTap: () {                    AppRouter.router.push('/chatScreen');
                  },
                  text_size: JSizes.fontSizeMd,
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: JAppbar(
        title: Text(
          JText.appBarTitle,
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
            fontSize: 19.0,
            weight: FontWeight.w500,
          ),
        ),
        leadingIcon: BackCircle(
          isDark: isDark,
          onTap: () {
            Navigator.pop(context);
          },
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

              // Bottom indicator
            ],
          ),
        ),
      ),
    );
  }
}

// Separate widgets moved to contract_detail_widgets.dart
