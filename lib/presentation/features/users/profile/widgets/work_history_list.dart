import 'package:flutter/cupertino.dart';


import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
class WorkHistoryList extends StatelessWidget {
  final bool isDark;

  const WorkHistoryList({
    super.key,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WorkHistoryItem(
          period: '2002-Now',
          description: 'Self-Employed/Independent Contractors',
          isDark: isDark,
        ),
        SizedBox(height: 12),
        WorkHistoryItem(
          period: '2024-Now',
          description: 'Home Renovation & Remodeling Companies',
          isDark: isDark,
        ),
      ],
    );
  }
}



class WorkHistoryItem extends StatelessWidget {
  final String period;
  final String description;
  final bool isDark;

  const WorkHistoryItem({
    super.key,
    required this.period,
    required this.description,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          period,
          style: AppTextStyle.dmSans(
            fontSize: JSizes.fontSizeSm,
            weight: FontWeight.w500,
            color: JAppColors.primary,
          ),
        ),
        SizedBox(height: 4),
        Text(
          description,
          style: AppTextStyle.dmSans(
            fontSize: JSizes.fontSizeSm,
            weight: FontWeight.normal,
            color: isDark ? JAppColors.darkGray300 : JAppColors.lightGray600,
          ),
        ),
      ],
    );
  }
}