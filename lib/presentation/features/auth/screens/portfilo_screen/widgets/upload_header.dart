import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../../utils/constants/app_text_style.dart';
import '../../../../../../utils/constants/colors.dart';

class UploadHeader extends StatelessWidget {
  const UploadHeader({
    super.key,
    required this.textColor,
  });

  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'uploadPortfolio',
          style: AppTextStyle.dmSans(
            color: textColor,
            fontSize: 24.0,
            weight: FontWeight.w600,
          ),
        ).tr(),
        const SizedBox(height: 12),
        Text(
          'choosePreferredOption',
          style: AppTextStyle.dmSans(
            color: JAppColors.lightGray500,
            fontSize: 14.0,
            weight: FontWeight.w400,
          ),
        ).tr(),
        const SizedBox(height: 32),

        // Upload Portfolios Section
        Text(
          'uploadPortfolios',
          style: AppTextStyle.dmSans(
            color: textColor,
            fontSize: 20.0,
            weight: FontWeight.w500,
          ),
        ).tr(),
        const SizedBox(height: 24),
      ],
    );
  }
}