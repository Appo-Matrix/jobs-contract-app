import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';


class EmptyStateWidget extends StatelessWidget {
  final String message;
  final IconData icon;
  final double iconSize;
  final Color? iconColor;
  final bool isDark;

  const EmptyStateWidget({
    Key? key,
    required this.message,
    this.icon = Icons.article_outlined,
    this.iconSize = 64.0,
    this.iconColor,
    required this.isDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: iconSize,
            color: iconColor ??
                (isDark ? JAppColors.darkGray600 : JAppColors.lightGray500),
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: AppTextStyle.dmSans(
              fontSize: 16.0,
              weight: FontWeight.w500,
              color: isDark ? JAppColors.darkGray400 : JAppColors.darkGray600,
            ),
            textAlign: TextAlign.center,
          ).tr(),
        ],
      ),
    );
  }
}
