import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../../utils/constants/app_text_style.dart';
import '../../../../../../../utils/constants/colors.dart';
import '../../../../../../../utils/device/device_utility.dart';

Widget buildOtpBox(int index ,BuildContext context) {
  final isDark = JDeviceUtils.isDarkMode(context);
  return Container(
    width: 64,
    height: 75,
    margin: const EdgeInsets.symmetric(horizontal: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),

    ),
    child: TextField(
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      maxLength: 1,
      cursorColor: JAppColors.primary, // Cursor color
      style: AppTextStyle.dmSans(
        color: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
        fontSize: 44.0,
        weight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        border: InputBorder.none, // Remove default borders
        counterText: "",
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: JAppColors.primary, // Highlight color when focused
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: JAppColors.lightGray500, // Default color
            width: 1.5,
          ),
        ),
      ),
    ),
  );
}
