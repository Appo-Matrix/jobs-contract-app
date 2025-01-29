import 'package:flutter/material.dart';
import 'package:job_contracts/utils/constants/app_text_style.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';

import '../../../../../../utils/constants/image_string.dart';

class TopHeader extends StatelessWidget {

  const TopHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image(
          height: 52,
          width: 86,
          image: AssetImage(PImages.mainLogo),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          PText.login,
          style: AppTextStyle.dmSans(
            color: JAppColors.lightGray900,
            fontSize: JSizes.fontSizeLgx,
            weight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 7,
        ),
        Text(
          PText.loginTitle,
          style: AppTextStyle.dmSans(
            color: JAppColors.lightGray500,
            fontSize: JSizes.fontSizeMd,
            weight: FontWeight.w400,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
