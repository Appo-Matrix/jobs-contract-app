

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../constants/app_text_style.dart';
import '../constants/colors.dart';
import '../constants/sizes.dart';
import '../device/device_utility.dart';

class TextFieldWidget extends StatelessWidget {
  final String? hintText;
  final String? subTitle;
  final IconData? prefixIcon;
  final bool? obscureText;
  final Widget? suffixIcon;
  final Color? subtitleColor;
  final Color? titleColor;
  final TextEditingController? textEditingController;
  final bool isRequired;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool readOnly;
  final VoidCallback? onTap;
  final int? maxLines;
  final FocusNode? focusNode;
  final Function(String)? onChanged;

  const TextFieldWidget({
    super.key,
    this.hintText,
    this.subTitle,
    this.prefixIcon,
    this.obscureText = false,
    this.suffixIcon,
    this.subtitleColor,
    this.titleColor,
    this.textEditingController,
    this.isRequired = false,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
    this.onTap,
    this.maxLines = 1,
    this.focusNode,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = JDeviceUtils.isDarkMode(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (subTitle != null)
          RichText(
            text: TextSpan(
              text: subTitle!.tr(), // Use .tr() to translate the subtitle
              style: AppTextStyle.dmSans(
                color: subtitleColor ?? JAppColors.darkGray700,
                fontSize: JSizes.fontSizeSm,
                weight: FontWeight.w500,
              ),
              children: isRequired
                  ? [
                TextSpan(
                  text: ' *',
                  style: AppTextStyle.dmSans(
                    color: JAppColors.error600,
                    fontSize: JSizes.fontSizeMd,
                    weight: FontWeight.w500,
                  ),
                ),
              ]
                  : [],
            ),
          ),
        const SizedBox(height: 6),
        TextFormField(
          controller: textEditingController,
          obscureText: obscureText!,
          style: AppTextStyle.dmSans(
            color: isDark ? Colors.white : JAppColors.darkGray800,
            fontSize: 16.0,
            weight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            hintText: hintText?.tr(), // Use .tr() to translate the hint text
            fillColor:  isDark ? JAppColors.backGroundDarkCard.withValues(alpha: 0.4) : Colors.transparent,
            filled: true,
            hintStyle: AppTextStyle.dmSans(
              color: titleColor?.withValues(alpha: 0.5) ?? JAppColors.darkGray800.withValues(alpha: 0.5),
              fontSize: JSizes.fontSizeMd,
              weight: FontWeight.w400,
            ),
            prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: JAppColors.darkGray500) : null,
            suffixIcon: suffixIcon,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Colors.grey,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: JAppColors.lightGray300,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: JAppColors.light, // Use primary color when focused
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: JAppColors.error600,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: JAppColors.error600,
                width: 1.5,
              ),
            ),
          ),
          validator: validator,
          keyboardType: keyboardType,
          readOnly: readOnly,
          onTap: onTap,
          maxLines: maxLines,
          focusNode: focusNode,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
