import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../constants/app_text_style.dart';
import '../constants/colors.dart';

class StepProgressHeader extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final String stepTitle;
  final bool isDark;

  const StepProgressHeader({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.stepTitle,
    this.isDark = false,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (currentStep + 1) / totalSteps;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // === Top Row ===
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'stepProgress'.tr(args: ['${currentStep + 1}', '$totalSteps']),

              style: AppTextStyle.dmSans(
                fontSize: 14.0,
                weight: FontWeight.w700,
                color: isDark ? JAppColors.darkGray100 : Colors.grey,

              ),


            ),
            Text(
              stepTitle,

              style: AppTextStyle.dmSans(
                fontSize: 14.0,
                color: JAppColors.primary,
                weight: FontWeight.w500,
              ),

            ),
          ],
        ),

        const SizedBox(height: 10),

        // === Rounded Horizontal Progress Bar ===
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 12,
            backgroundColor:
            isDark ? JAppColors.darkGray300 : Colors.grey.shade300,
            valueColor: AlwaysStoppedAnimation<Color>(JAppColors.primary),
          ),
        ),
      ],
    );
  }
}