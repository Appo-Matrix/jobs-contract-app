import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';

class QuestionField extends StatelessWidget {
  final String question;
  final String hint;
  final bool isDark;

  const QuestionField({
    super.key,
    required this.question,
    required this.isDark, required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.lightGray300 : JAppColors.lightGray800,
            fontSize: 14.0,
            weight: FontWeight.w400,
          ),
        ).tr(),
        const SizedBox(height: 8),
        Container(
          height: 48,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
            color: isDark ? JAppColors.backGroundDarkCard.withValues(alpha: 0.6) : Colors.transparent,
          ),
          child: TextField(

            style: AppTextStyle.dmSans(
              color: isDark ? JAppColors.lightGray100 : JAppColors.lightGray800,
              fontSize: 14.0,
              weight: FontWeight.w400,
            ),
            decoration:  InputDecoration(
              hintText: hint.tr(),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
        ),
      ],
    );
  }
}
