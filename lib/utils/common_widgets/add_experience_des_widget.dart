import 'package:flutter/material.dart';
import 'package:job_contracts/utils/device/device_utility.dart';

import '../constants/app_text_style.dart';
import '../constants/colors.dart';
import '../constants/sizes.dart';

class AddExperienceDesWidget extends StatelessWidget {
  final String? hintText;
  final String? subTitle;
  final IconData? prefixIcon;
  final bool? obscureText;
  final Widget? suffixIcon;
  final Color? subtitleColor;
  // final TextEditingController? textEditingController;

  const AddExperienceDesWidget({
    super.key,
    this.hintText,
    this.subTitle,
    this.prefixIcon,
    this.obscureText = false,
    this.suffixIcon, this.subtitleColor,
    // required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (subTitle != null)
          Text(
            subTitle!,
            style: AppTextStyle.dmSans(
              color: subtitleColor!,
              fontSize: JSizes.fontSizeMd,
              weight: FontWeight.w600,
            ),
          ),
        const SizedBox(height: 8),
        TextField(
          maxLines: 6,
          obscureText: obscureText!,
          style: AppTextStyle.dmSans(
            color: isDark? JAppColors.lightGray100 : JAppColors.darkGray800,
            fontSize: JSizes.fontSizeMd,
            weight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTextStyle.dmSans(
              color: isDark? JAppColors.lightGray100 : JAppColors.darkGray500,
              fontSize: JSizes.fontSizeMd,
              weight: FontWeight.w400,
            ),
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.grey,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: JAppColors.lightGray300,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: JAppColors.primary, // Use primary color when focused
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
