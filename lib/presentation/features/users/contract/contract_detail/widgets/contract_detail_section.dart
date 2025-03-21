import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../utils/constants/app_text_style.dart';
import '../../../../../../utils/constants/colors.dart';
import 'conractor_profile.dart';

class ContractDetailsSection extends StatelessWidget {
  final bool isDark;

  const ContractDetailsSection({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {

    final containerColor =
    isDark ? JAppColors.darkGray700 : JAppColors.lightGray100;
    final textColor =
    isDark ? JAppColors.lightGray300 : JAppColors.lightGray900;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Salary:',
                style: AppTextStyle.dmSans(
                  color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                  fontSize: 12.0,
                  weight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 8,),
              Text(
                '20,000 - 25,000',
                style: AppTextStyle.dmSans(
                  color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                  fontSize: 12.0,
                  weight: FontWeight.w500,
                ),
              ),
              Spacer(),
              IconButton(
                icon: Icon(
                  Icons.more_vert,
                  color: isDark ? JAppColors.darkGray100 : Colors.black,
                ),
                onPressed: () {},
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                'Category: ',
                style: AppTextStyle.dmSans(
                  color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                  fontSize: 12.0,
                  weight: FontWeight.w500,
                ),
              ),
              Text(
                'Electrician',
                style: AppTextStyle.dmSans(
                  color: isDark ? JAppColors.lightest : JAppColors.primary,
                  fontSize: 12.0,
                  weight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 20),
              Text(
                'Job Type: ',
                style: AppTextStyle.dmSans(
                  color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                  fontSize: 12.0,
                  weight: FontWeight.w500,
                ),
              ),
              Text(
                'Onsite',
                style: AppTextStyle.dmSans(
                  color: isDark ? JAppColors.lightest : JAppColors.primary,
                  fontSize: 12.0,
                  weight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                'Job Duration: ',
                style: AppTextStyle.dmSans(
                  color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                  fontSize: 12.0,
                  weight: FontWeight.w500,
                ),
              ),
              Text(
                '1 Month',
                style: AppTextStyle.dmSans(
                  color: isDark ? JAppColors.lightest : JAppColors.primary,
                  fontSize: 12.0,
                  weight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ContractorProfile(isDark: isDark),
        ],
      ),
    );
  }
}
