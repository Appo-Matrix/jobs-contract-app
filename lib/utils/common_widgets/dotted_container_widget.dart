
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../constants/app_text_style.dart';
import '../constants/colors.dart';
import '../constants/sizes.dart';

class doted_container_widget extends StatelessWidget {
  final VoidCallback onTap;
  const doted_container_widget({
    super.key,
    required this.isDark,
    required this.onTap,
  });

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: DottedBorder(
        color: JAppColors.darkGray400,
        // Border color
        strokeWidth: 1,
        // Thickness
        dashPattern: [6, 3],
        // Dash length & space
        borderType: BorderType.RRect,
        // Rounded rectangle border
        radius: Radius.circular(12),
        // Border radius
        child: Container(
          height: 100,
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/icons/file_icon.png', color: isDark
                    ? JAppColors.lightGray100
                    : JAppColors.darkGray1000,),
                SizedBox(width: 10),
                Text(
                  'Upload CV/Resume',
                  style: AppTextStyle.dmSans(
                    color: isDark
                        ? JAppColors.lightGray100
                        : JAppColors.darkGray1000,
                    fontSize: JSizes.fontSizeSm,
                    weight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}