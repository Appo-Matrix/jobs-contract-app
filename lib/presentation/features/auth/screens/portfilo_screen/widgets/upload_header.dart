import 'package:flutter/cupertino.dart';

import '../../../../../../utils/constants/app_text_style.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/text_strings.dart';

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
          JText.uploadPortfolio,
          style: AppTextStyle.dmSans(
            color: textColor,
            fontSize: 24.0,
            weight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          JText.choosePreferredOption,
          style: AppTextStyle.dmSans(
            color: JAppColors.lightGray500,
            fontSize: 14.0,
            weight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 32),

        // Upload Portfolios Section
        Text(
          JText.uploadPortfolios,
          style: AppTextStyle.dmSans(
            color: textColor,
            fontSize: 20.0,
            weight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}