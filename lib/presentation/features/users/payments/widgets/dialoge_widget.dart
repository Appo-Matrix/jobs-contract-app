import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_contracts/utils/constants/sizes.dart';

import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_string.dart';
import '../../../../../utils/constants/text_strings.dart';

class  JDialogWidget extends StatelessWidget {
  const JDialogWidget({
    super.key,
    required this.isDark,
  });

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            JImages.card, // Replace with your image path
            height: 77,
            width: 77,
            fit: BoxFit.contain,
          ),
           SizedBox(height: JSizes.spaceBtwSections-20),
          Text(
            'donotCard',
            style:
            AppTextStyle.dmSans(
                color: isDark
                    ? JAppColors.darkGray100
                    : JAppColors.lightGray900,
                fontSize: 16.0,
                weight: FontWeight.w400),
          ).tr(),
          const SizedBox(height: JSizes.spaceBtwSections-10),
          Text(
            textAlign: TextAlign.center,
            'cardDetailText',
            style:
            AppTextStyle.dmSans(
                color: isDark
                    ? JAppColors.darkGray100
                    : JAppColors.lightGray900,
                fontSize: 16.0,
                weight: FontWeight.w400),
          ).tr(),
        ],
      ),
    );
  }
}
