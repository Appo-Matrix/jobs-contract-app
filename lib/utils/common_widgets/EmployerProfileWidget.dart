
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/app_text_style.dart';
import '../constants/colors.dart';
import '../constants/image_string.dart';

class EmployerProfileWidget extends StatelessWidget {
  final String employerName;
  final String location;
  final String postedTime;
  final String? employerImage;
  final bool isVerified;
  final bool isDark;

  const EmployerProfileWidget({
    super.key,
    required this.employerName,
    required this.location,
    required this.postedTime,
    this.employerImage,
    this.isVerified = false,
    this.isDark = false,
  });

  @override
  Widget build(BuildContext context) {
    // Define colors based on dark mode
    final textColor = isDark ? Colors.white : const Color(0xFF344054);
    final iconColor = isDark ? JAppColors.lightGray100 : JAppColors.primary;

    return
      Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Employer Avatar with verification badge
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: employerImage != null
                  ? Image.asset(
                employerImage!,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              )
                  : Container(
                width: 50,
                height: 50,
                color: isDark ? Colors.grey[700] : Colors.grey[300],
                child: Icon(
                  Icons.person,
                  size: 36,
                  color: isDark ? Colors.grey[500] : Colors.grey,
                ),
              ),
            ),
            if (isVerified)
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: isDark ? JAppColors.backGroundDarkCard : Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isDark ? JAppColors.backGroundDarkCard : Colors.white,
                      width: 2,
                    ),
                  ),
                  child: Image(
                    height: 16,
                    width: 16,
                    image: AssetImage(JImages.verify),
                  ),
                ),

              ),
          ],
        ),
        const SizedBox(width: 16),

        // Employer Details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Employer Name
              Text(
                employerName,
                style: AppTextStyle.dmSans(
                  fontSize: 14.0,
                  weight: FontWeight.w500,
                  color: isDark ? Colors.white : JAppColors.lightGray900,
                ),
              ),
              const SizedBox(height: 4),

              // Location and Posted Time
              Row(
                children: [
                  SvgPicture.asset(

                    JImages.locationSvg,
                    width: 12,
                    height: 16,
                    colorFilter: ColorFilter.mode(
                      iconColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    location,
                    style: AppTextStyle.dmSans(
                      fontSize: 12.0,
                      color: textColor.withValues(alpha: 0.8),
                      weight: FontWeight.w500,
                    ),
                  ).tr(),
                  const SizedBox(width: 10),

                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}