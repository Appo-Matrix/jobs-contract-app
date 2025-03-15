import 'package:flutter/material.dart';
import 'package:job_contracts/utils/device/device_utility.dart';

import '../constants/app_text_style.dart';
import '../constants/colors.dart';
import '../constants/sizes.dart';

class TextFieldWidget extends StatelessWidget {
  final String? hintText;
  final String? subTitle;
  final IconData? prefixIcon;
  final bool? obscureText;
  final Widget? suffixIcon;
  final Color? subtitleColor;
  final Color? titleColor;

  // final TextEditingController? textEditingController;

  const TextFieldWidget({
    super.key,
    this.hintText,
    this.subTitle,
    this.prefixIcon,
    this.obscureText = false,
    this.suffixIcon,
    this.subtitleColor,
    this.titleColor,
    // required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (subTitle != null)
          Text(
            subTitle!,
            style: AppTextStyle.dmSans(
              color:subtitleColor!,
              fontSize: JSizes.fontSizeMd,
              weight: FontWeight.w500,
            ),
          ),
        const SizedBox(height: 12),
        TextField(
          obscureText: obscureText!,
          style: AppTextStyle.dmSans(

            color: titleColor!,
            fontSize: 14.0,
            weight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTextStyle.dmSans(
              color: titleColor!,
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
