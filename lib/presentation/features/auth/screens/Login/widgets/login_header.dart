import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:job_contracts/utils/constants/app_text_style.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/constants/sizes.dart';

import '../../../../../../utils/constants/image_string.dart';

class TopHeader extends StatelessWidget {
  final String logo;
  final String title;
  final String subTitle;
  final bool isDark;

  const TopHeader({super.key, required this.logo, required this.title, required this.subTitle, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image(
          height: 52,
          width: 86,
          image: AssetImage(JImages.mainLogo23),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(

          title,
          style: AppTextStyle.dmSans(
            color: isDark
                ? JAppColors.darkGray100
                : JAppColors.lightGray900,
            fontSize: JSizes.fontSizeLgx,
            weight: FontWeight.w600,
          ),
        ).tr(),
        const SizedBox(
          height: 7,
        ),
        Text(
          subTitle,
          style: AppTextStyle.dmSans(
            color: isDark
            ? JAppColors.darkGray100
            : JAppColors.lightGray500,
            fontSize: JSizes.fontSizeMd,
            weight: FontWeight.w500,
          ),
        ).tr(),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
