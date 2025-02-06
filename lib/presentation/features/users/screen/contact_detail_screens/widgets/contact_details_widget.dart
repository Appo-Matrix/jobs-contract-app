import 'package:flutter/material.dart';

import '../../../../../../utils/constants/app_text_style.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';

class ContactDetailsWidget extends StatelessWidget {
  final String title;
  final String subTitle;

  const ContactDetailsWidget({
    super.key,
    required this.isDark,
    required this.title,
    required this.subTitle,
  });

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Row(
          children: [
            Text(
              title,
              style: AppTextStyle.dmSans(
                color:
                isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                fontSize: JSizes.fontSizeSmx,
                weight: FontWeight.w400,
              ),
            ),
            Spacer(),
            Text(
              subTitle,
              style: AppTextStyle.dmSans(
                color:
                isDark ? JAppColors.darkGray100 : JAppColors.lightGray500,
                fontSize: JSizes.fontSizeSmx,
                weight: FontWeight.w400,
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
      ],
    );
  }
}