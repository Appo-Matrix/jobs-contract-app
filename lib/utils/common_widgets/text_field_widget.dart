import 'package:flutter/material.dart';

import '../constants/app_text_style.dart';
import '../constants/colors.dart';
import '../constants/sizes.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final String subTitle;
  final IconData prefixIcon;
  final bool obscureText;
  final Widget? suffixIcon;

  const TextFieldWidget({
    super.key,
    required this.hintText,
    required this.subTitle,
    required this.prefixIcon,
    this.obscureText = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          subTitle,
          style: AppTextStyle.dmSans(
            color: JAppColors.darkGray700,
            fontSize: JSizes.fontSizeMd,
            weight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 5),
        Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
          ),
          child: Center(
            child: TextField(
              obscureText: obscureText,
              style: AppTextStyle.dmSans(
                color: JAppColors.t,
                fontSize: JSizes.fontSizeMd,
                weight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: AppTextStyle.dmSans(
                  color: JAppColors.lightGray500,
                  fontSize: JSizes.fontSizeMd,
                  weight: FontWeight.w400,
                ),
                suffixIcon: suffixIcon,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
