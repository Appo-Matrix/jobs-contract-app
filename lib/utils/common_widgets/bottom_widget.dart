import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../constants/app_text_style.dart';
import '../constants/colors.dart';
import '../constants/sizes.dart';

class BottomWidget extends StatelessWidget {
  const BottomWidget({
    super.key,
    required this.isDark, required this.title, required this.titleDes, required this.onPressed,
  });

  final bool isDark;
  final String title;
  final String titleDes;
  final VoidCallback onPressed;


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: AppTextStyle.dmSans(
            color: isDark
                ? JAppColors.lightGray400
                : JAppColors.darkGray600,
            fontSize: 16.0,
            weight: FontWeight.w400,
          ),
        ).tr(),
        SizedBox(
          width: JSizes.xs + 2,
        ),
        GestureDetector(
          onTap: onPressed,
          child: Text(
            titleDes,
            style: AppTextStyle.dmSans(
              color: isDark
                  ? JAppColors.lightGray100
                  : JAppColors.primary,
              fontSize: 18.0,
              weight: FontWeight.w600,
            ),
          ).tr(),
        ),
      ],
    );
  }
}
