import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/features/auth/screens/specilization/widgets/selection_chip.dart';
import 'package:job_contracts/presentation/routes/app_routes.dart';
import 'package:job_contracts/utils/common_widgets/appbar2.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';

import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';

// Main Screen
class SpecializationScreen extends StatefulWidget {
  const SpecializationScreen({super.key});

  @override
  State<SpecializationScreen> createState() => _SpecializationScreenState();
}

class _SpecializationScreenState extends State<SpecializationScreen> {
  // Selected values
  String? selectedSpecialization;
  String? selectedServiceType;
  String? selectedExperience;
  String? selectedServiceRange;

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    final backgroundColor = isDark ? JAppColors.backGroundDark : Colors.white;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: JAppBar2(title: 'back'),


      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Specialization Section
                Text(
                  'selectYourSpecialization',

                  style: AppTextStyle.dmSans(
                      color: isDark ? JAppColors.lightGray100 : JAppColors
                          .darkGray900,
                      fontSize: 22.0,
                      weight: FontWeight.w600,
                  ),

                ).tr(),
                const SizedBox(height: 16),

                // Specialization Options
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    for (final option in JText.specializationOptions)
                      SelectionChip(
                        label: option,
                        isSelected: selectedSpecialization == option,
                        onTap: () {
                          setState(() {
                            selectedSpecialization = option;
                          });
                        }, isDark: isDark,
                      ),
                  ],
                ),

                const SizedBox(height: 32),

                // Service Type Section
                Text(
                  'serviceType',
                  style: AppTextStyle.dmSans(
                    color: isDark ? JAppColors.lightGray100 : JAppColors
                        .darkGray900,
                    fontSize: 24.0,
                    weight: FontWeight.w600,
                  ),
                ).tr(),
                const SizedBox(height: 16),

                // Service Type Options
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    for (final option in JText.serviceTypeOptions)
                      SelectionChip(
                        isDark: isDark,
                        label: option,
                        isSelected: selectedServiceType == option,
                        onTap: () {
                          setState(() {
                            selectedServiceType = option;
                          });
                        },
                      ),
                  ],
                ),

                const SizedBox(height: 32),

                // Years of Experience Section
                Text(
                  JText.yearsOfExperience,
                  style: AppTextStyle.dmSans(
                    color: isDark ? JAppColors.lightGray100 : JAppColors
                        .darkGray900,
                    fontSize: 24.0,
                    weight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),

                // Experience Options
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    for (final option in JText.experienceOptions)
                      SelectionChip(
                        isDark: isDark,
                        label: option,
                        isSelected: selectedExperience == option,
                        onTap: () {
                          setState(() {
                            selectedExperience = option;
                          });
                        },
                      ),
                  ],
                ),

                const SizedBox(height: 32),

                // Service Range Section
                Text(
                  JText.serviceRange,
                  style: AppTextStyle.dmSans(
                    color: isDark ? JAppColors.lightGray100 : JAppColors
                        .grayBlue800,
                    fontSize: 24.0,
                    weight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),

                // Service Range Options
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    for (final option in JText.serviceRangeOptions)
                      SelectionChip(
                        isDark: isDark,

                        label: option,
                        isSelected: selectedServiceRange == option,
                        onTap: () {
                          setState(() {
                            selectedServiceRange = option;
                          });
                        },
                      ),
                  ],
                ),

                const SizedBox(height: 40),
                MainButton(
                  btn_title: JText.nextStepVerification,
                  btn_radius: 10,
                  btn_color: JAppColors.primary,
                  btn_boarder_color: Colors.transparent,
                  title_color: Colors.white,
                  text_fontweight: FontWeight.w600,
                  image_value: false,
                  onTap: (){


                    AppRouter.router.push('/verificationScreen');

                  },

                  text_size:  JSizes.fontSizeMd,
                ),

                // Next Button
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Custom Selection Chip Widget

