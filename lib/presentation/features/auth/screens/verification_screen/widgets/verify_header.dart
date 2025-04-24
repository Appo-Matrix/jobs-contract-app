import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../../utils/constants/app_text_style.dart';
import '../../../../../../utils/constants/colors.dart';

class VerifyHeader extends StatelessWidget {
  const VerifyHeader({
    super.key,
    required this.isDark,
  });

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'verifyAccount',
          style: AppTextStyle.dmSans(
            color: isDark
                ? JAppColors.lightGray100
                : JAppColors.darkGray800,
            fontSize: 24.0,
            weight: FontWeight.w600,
          ),
        ).tr(),
        const SizedBox(height: 10),
        Text(
          'verifyAccountChoose',
          style: AppTextStyle.dmSans(
            color: isDark
                ? JAppColors.lightGray300
                : JAppColors.darkGray500,
            fontSize: 16.0,
            weight: FontWeight.w400,
          ),
        ).tr(),

      ],
    );
  }
}
