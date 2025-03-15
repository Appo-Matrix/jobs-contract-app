// Profile Header Widget
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_string.dart';

class ProfileHeader extends StatelessWidget {
  final bool isDark;

  const ProfileHeader({
    Key? key,
    required this.isDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          // Profile Image with Red Circle Border
          Container(
            width: 96,
            height: 96,

            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.red,
                width: 3,
              ),
            ),
            child: ClipOval(
              child: Image.asset(
                JImages.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 12),

          // Name
          Text(
            'Bessie Cooper',
            style: AppTextStyle.dmSans(
              fontSize: 20.0,
              weight: FontWeight.w600,

              color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            ),
          ),
          SizedBox(height: 8),

          // Job Title
          Text(
            'Drywall Installers Specialist',
            style: AppTextStyle.dmSans(
              fontSize: 16.0,
              weight: FontWeight.w500,
              color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            ),
          ),
          SizedBox(height: 6),

          // Earnings
          Text(
            'Earning: \$550000',
            style: AppTextStyle.dmSans(
              fontSize: 14.0,
              weight: FontWeight.w400,
              color: isDark ? JAppColors.darkGray300 : JAppColors.lightGray600,
            ),
          ),
        ],
      ),
    );
  }
}