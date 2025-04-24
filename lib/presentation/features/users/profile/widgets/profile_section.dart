
// Generic Profile Section Widget
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';

class ProfileSection extends StatelessWidget {
  final String title;
  final Widget content;
  final bool isDark;
  final VoidCallback? voidCallback;
  final String? iconPath;


  const ProfileSection({
    super.key,
    required this.title,
    required this.content,
    required this.isDark,  this.voidCallback, this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: AppTextStyle.dmSans(
                  fontSize: 18.0,
                  weight: FontWeight.w600,
                  color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                ),
              ).tr(),
              Spacer(),
              GestureDetector(
                onTap: voidCallback,
                child: SvgPicture.asset(

                  color: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                  iconPath!,
                  width: 20,
                  height: 20,
                ),
              )
            ],
          ),
          SizedBox(height: 12),
          content,
        ],
      ),
    );
  }
}