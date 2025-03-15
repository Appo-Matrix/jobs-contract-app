
// Generic Profile Section Widget
import 'package:flutter/cupertino.dart';

import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';

class ProfileSection extends StatelessWidget {
  final String title;
  final Widget content;
  final bool isDark;

  const ProfileSection({
    Key? key,
    required this.title,
    required this.content,
    required this.isDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyle.dmSans(
              fontSize: 18.0,
              weight: FontWeight.w600,
              color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            ),
          ),
          SizedBox(height: 12),
          content,
        ],
      ),
    );
  }
}