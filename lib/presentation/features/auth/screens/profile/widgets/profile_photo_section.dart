import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../utils/constants/app_text_style.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/text_strings.dart';

class ProfilePhotoSection extends StatelessWidget {
  final bool isDark;

  const ProfilePhotoSection({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'profilePhoto'.tr(),
                style: AppTextStyle.dmSans(
                  color: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                  fontSize: 20.0,
                  weight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: ' *',
                style: AppTextStyle.dmSans(
                  color: Colors.red,
                  fontSize: 20.0,
                  weight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Stack(
          children: [
            Positioned.fill(
              child: CircleAvatar(
                backgroundColor: isDark
                    ? JAppColors.darkGray700
                    : const Color(0xFFF1F2F6),
              ),
            ),
            const CircleAvatar(
              radius: 60,
              backgroundColor: Colors.transparent,
              child: Icon(
                Icons.person,
                size: 80,
                color: Colors.white,
              ),
            ),
            const Positioned(
              bottom: 10,
              right: 0,
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Color(0xFF6C38FF),
                child: Icon(
                  Icons.camera_alt_outlined,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
