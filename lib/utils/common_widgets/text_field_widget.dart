//
//
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
//
// import '../constants/app_text_style.dart';
// import '../constants/colors.dart';
// import '../constants/sizes.dart';
// import '../device/device_utility.dart';
//
// class TextFieldWidget extends StatelessWidget {
//   final String? hintText;
//   final String? subTitle;
//   final IconData? prefixIcon;
//   final bool? obscureText;
//   final Widget? suffixIcon;
//   final Color? subtitleColor;
//   final Color? titleColor;
//   final TextEditingController? textEditingController;
//   final bool isRequired;
//   final String? Function(String?)? validator;
//   final TextInputType keyboardType;
//   final bool readOnly;
//   final VoidCallback? onTap;
//   final int? maxLines;
//   final FocusNode? focusNode;
//   final Function(String)? onChanged;
//
//   const TextFieldWidget({
//     super.key,
//     this.hintText,
//     this.subTitle,
//     this.prefixIcon,
//     this.obscureText = false,
//     this.suffixIcon,
//     this.subtitleColor,
//     this.titleColor,
//     this.textEditingController,
//     this.isRequired = false,
//     this.validator,
//     this.keyboardType = TextInputType.text,
//     this.readOnly = false,
//     this.onTap,
//     this.maxLines = 1,
//     this.focusNode,
//     this.onChanged,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final bool isDark = JDeviceUtils.isDarkMode(context);
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (subTitle != null)
//           RichText(
//             text: TextSpan(
//               text: subTitle!.tr(), // Use .tr() to translate the subtitle
//               style: AppTextStyle.dmSans(
//                 color: subtitleColor ?? JAppColors.darkGray700,
//                 fontSize: JSizes.fontSizeSm,
//                 weight: FontWeight.w500,
//               ),
//               children: isRequired
//                   ? [
//                 TextSpan(
//                   text: ' *',
//                   style: AppTextStyle.dmSans(
//                     color: JAppColors.error600,
//                     fontSize: JSizes.fontSizeMd,
//                     weight: FontWeight.w500,
//                   ),
//                 ),
//               ]
//                   : [],
//             ),
//           ),
//         const SizedBox(height: 6),
//         TextFormField(
//           controller: textEditingController,
//           obscureText: obscureText!,
//           style: AppTextStyle.dmSans(
//             color: isDark ? Colors.white : JAppColors.darkGray800,
//             fontSize: 16.0,
//             weight: FontWeight.w400,
//           ),
//           decoration: InputDecoration(
//             hintText: hintText?.tr(), // Use .tr() to translate the hint text
//             fillColor:  isDark ? JAppColors.backGroundDarkCard.withValues(alpha: 0.4) : Colors.transparent,
//             filled: true,
//             hintStyle: AppTextStyle.dmSans(
//               color: titleColor?.withValues(alpha: 0.5) ?? JAppColors.darkGray800.withValues(alpha: 0.5),
//               fontSize: JSizes.fontSizeMd,
//               weight: FontWeight.w400,
//             ),
//             prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: JAppColors.darkGray500) : null,
//             suffixIcon: suffixIcon,
//             contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: BorderSide(
//                 color: Colors.grey,
//                 width: 1,
//               ),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: BorderSide(
//                 color: JAppColors.lightGray300,
//                 width: 1,
//               ),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: BorderSide(
//                 color: JAppColors.light, // Use primary color when focused
//                 width: 1.5,
//               ),
//             ),
//             errorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: BorderSide(
//                 color: JAppColors.error600,
//                 width: 1,
//               ),
//             ),
//             focusedErrorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: BorderSide(
//                 color: JAppColors.error600,
//                 width: 1.5,
//               ),
//             ),
//           ),
//           validator: validator,
//           keyboardType: keyboardType,
//           readOnly: readOnly,
//           onTap: onTap,
//           maxLines: maxLines,
//           focusNode: focusNode,
//           onChanged: onChanged,
//         ),
//       ],
//     );
//   }
// }


import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/app_text_style.dart';
import '../constants/colors.dart';
import '../constants/sizes.dart';
import '../device/device_utility.dart';

class TextFieldWidget extends StatefulWidget {
  final String? hintText;
  final String? subTitle;
  final IconData? prefixIcon;
  final String? prefixSvgPath;
  final bool obscureText;
  final Widget? suffixIcon;
  final IconData? suffixIconData;
  final String? suffixSvgPath;
  final VoidCallback? onSuffixIconPressed;
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
  final Function(String)? onSubmitted;
  final TextInputAction? textInputAction;
  final bool isEmail;
  final bool isPassword;

  // Customization options
  final Color? fillColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final Color? textColor;
  final Color? iconColor;
  final Color? hintTextColor;
  final double? height; // This now only affects the input field height, not the entire widget
  final double iconSize;
  final BorderRadius? radius;

  const TextFieldWidget({
    super.key,
    this.hintText,
    this.subTitle,
    this.prefixIcon,
    this.prefixSvgPath,
    this.obscureText = false,
    this.suffixIcon,
    this.suffixIconData,
    this.suffixSvgPath,
    this.onSuffixIconPressed,
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
    this.onSubmitted,
    this.textInputAction,
    this.isEmail = false,
    this.isPassword = false,
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.textColor,
    this.iconColor,
    this.hintTextColor,
    this.height = 54,
    this.iconSize = 18.0,
    this.radius,
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool _obscureText = true;

  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword || widget.obscureText;
  }

  String? _defaultEmailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return widget.isRequired ? 'emailRequired'.tr() : null;
    }

    if (!_emailRegex.hasMatch(value)) {
      return 'emailInvalid'.tr();
    }
    return null;
  }

  Color _getFillColor(bool isDark) {
    if (widget.fillColor != null) return widget.fillColor!;
    return isDark
        ? JAppColors.backGroundDarkCard.withOpacity(0.4)
        : Colors.transparent;
  }

  Color _getBorderColor(bool isDark) {
    if (widget.borderColor != null) return widget.borderColor!;
    return isDark
        ? JAppColors.lightGray600.withOpacity(0.4)
        : JAppColors.lightGray300;
  }

  Color _getFocusedBorderColor(bool isDark) {
    if (widget.focusedBorderColor != null) return widget.focusedBorderColor!;
    return JAppColors.primary;
  }

  Color _getErrorBorderColor() {
    if (widget.errorBorderColor != null) return widget.errorBorderColor!;
    return JAppColors.error600;
  }

  Color _getTextColor(bool isDark) {
    if (widget.textColor != null) return widget.textColor!;
    return isDark ? Colors.white : JAppColors.darkGray800;
  }

  Color _getIconColor(bool isDark) {
    if (widget.iconColor != null) return widget.iconColor!;
    return isDark ? JAppColors.darkGray100 : JAppColors.darkGray500;
  }

  Color _getHintTextColor(bool isDark) {
    if (widget.hintTextColor != null) return widget.hintTextColor!;
    return isDark
        ? JAppColors.darkGray100.withOpacity(0.5)
        : JAppColors.darkGray800.withOpacity(0.5);
  }

  Widget? _buildPrefixIcon(bool isDark) {
    if (widget.isEmail) {
      return Container(
        width: 48,
        height: 48,
        alignment: Alignment.center,
        child: Icon(
          Icons.email_outlined,
          color: _getIconColor(isDark),
          size: widget.iconSize,
        ),
      );
    } else if (widget.prefixSvgPath != null) {
      return Container(
        width: 48,
        height: 48,
        alignment: Alignment.center,
        child: SizedBox(
          width: widget.iconSize,
          height: widget.iconSize,
          child: SvgPicture.asset(
            widget.prefixSvgPath!,
            width: widget.iconSize,
            height: widget.iconSize,
            fit: BoxFit.contain,
            colorFilter: ColorFilter.mode(
              _getIconColor(isDark),
              BlendMode.srcIn,
            ),
          ),
        ),
      );
    } else if (widget.prefixIcon != null) {
      return Container(
        width: 48,
        height: 48,
        alignment: Alignment.center,
        child: Icon(
          widget.prefixIcon,
          color: _getIconColor(isDark),
          size: widget.iconSize,
        ),
      );
    }
    return null;
  }

  Widget? _buildSuffixIcon(bool isDark) {
    if (widget.isPassword) {
      return IconButton(
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
        icon: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
          color: _getIconColor(isDark),
          size: widget.iconSize,
        ),
        splashRadius: 20,
      );
    } else if (widget.suffixSvgPath != null) {
      return IconButton(
        onPressed: widget.onSuffixIconPressed,
        icon: SizedBox(
          width: widget.iconSize,
          height: widget.iconSize,
          child: SvgPicture.asset(
            widget.suffixSvgPath!,
            width: widget.iconSize,
            height: widget.iconSize,
            fit: BoxFit.contain,
            colorFilter: ColorFilter.mode(
              _getIconColor(isDark),
              BlendMode.srcIn,
            ),
          ),
        ),
        splashRadius: 20,
      );
    } else if (widget.suffixIconData != null) {
      return IconButton(
        onPressed: widget.onSuffixIconPressed,
        icon: Icon(
          widget.suffixIconData,
          color: _getIconColor(isDark),
          size: widget.iconSize,
        ),
        splashRadius: 20,
      );
    } else if (widget.suffixIcon != null) {
      return widget.suffixIcon;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = JDeviceUtils.isDarkMode(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.subTitle != null) ...[
          RichText(
            text: TextSpan(
              text: widget.subTitle!.tr(),
              style: AppTextStyle.dmSans(
                color: widget.subtitleColor ??
                    (isDark ? JAppColors.lightGray100 : JAppColors.darkGray700),
                fontSize: JSizes.fontSizeSm,
                weight: FontWeight.w600,
              ),
              children: widget.isRequired
                  ? [
                TextSpan(
                  text: ' *',
                  style: AppTextStyle.dmSans(
                    color: JAppColors.error600,
                    fontSize: JSizes.fontSizeSm,
                    weight: FontWeight.w600,
                  ),
                ),
              ]
                  : [],
            ),
          ),
          const SizedBox(height: JSizes.inputFieldRadius - 4),
        ],
        // Removed the fixed height SizedBox wrapper to allow error text to display
        TextFormField(
          controller: widget.textEditingController,
          focusNode: widget.focusNode,
          maxLines: widget.maxLines,
          obscureText: _obscureText,
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          keyboardType: widget.isEmail
              ? TextInputType.emailAddress
              : widget.keyboardType,
          textInputAction: widget.textInputAction ??
              (widget.isEmail ? TextInputAction.done : TextInputAction.next),
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          validator: widget.isEmail
              ? (widget.validator ?? _defaultEmailValidator)
              : widget.validator,
          style: AppTextStyle.dmSans(
            color: _getTextColor(isDark),
            fontSize: 14.0,
            weight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: _getFillColor(isDark),
            hintText: widget.hintText?.tr(),
            hintStyle: AppTextStyle.dmSans(
              color: _getHintTextColor(isDark),
              fontSize: JSizes.fontSizeMd,
              weight: FontWeight.w400,
            ),
            prefixIcon: _buildPrefixIcon(isDark),
            suffixIcon: _buildSuffixIcon(isDark),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: widget.height != null
                  ? (widget.height! - 24) / 2  // Calculate vertical padding to match desired height
                  : 16,
            ),
            // Error style customization
            errorStyle: AppTextStyle.dmSans(
              color: JAppColors.error600,
              fontSize: 12.0,
              weight: FontWeight.w400,
            ),
            errorMaxLines: 2,
            border: OutlineInputBorder(
              borderRadius: widget.radius ?? BorderRadius.circular(8),
              borderSide: BorderSide(
                color: _getBorderColor(isDark),
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: widget.radius ?? BorderRadius.circular(8),
              borderSide: BorderSide(
                color: _getBorderColor(isDark),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: widget.radius ?? BorderRadius.circular(8),
              borderSide: BorderSide(
                color: _getFocusedBorderColor(isDark),
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: widget.radius ?? BorderRadius.circular(8),
              borderSide: BorderSide(
                color: _getErrorBorderColor(),
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: widget.radius ?? BorderRadius.circular(8),
              borderSide: BorderSide(
                color: _getErrorBorderColor(),
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
