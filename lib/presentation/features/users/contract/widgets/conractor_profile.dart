import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_string.dart';

class ContractorProfile extends StatelessWidget {
  final bool isDark;

  const ContractorProfile({Key? key, required this.isDark}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(
            'https://www.dmarge.com/wp-content/uploads/2021/01/dwayne-the-rock-.jpg',
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Amélie Laurent',
                  style: AppTextStyle.dmSans(
                    color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                    fontSize: 16.0,
                    weight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.verified,
                  color: Colors.amber,
                  size: 16,
                ),
              ],
            ),
            const SizedBox(height: 8),


            Row(
              children: [
                SvgPicture.asset(
                  JImages.locationSvg,
                  height: 20,
                  width: 20,
                  colorFilter: ColorFilter.mode(
                    isDark
                        ? JAppColors.lightGray100
                        : JAppColors.lightest,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'United States',
                  style: AppTextStyle.dmSans(
                    color: isDark ? JAppColors.lightGray100 : JAppColors.primary,
                    fontSize: 14.0,
                    weight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
