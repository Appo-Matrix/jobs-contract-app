// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import '../constants/app_text_style.dart';
// import '../constants/colors.dart';
//
// class MainButton extends StatelessWidget {
//   final String btn_title;
//   final String? btn_image;
//   final double btn_radius;
//   final double height;
//   final Color? btn_color;
//   final Color title_color;
//   final Color btn_boarder_color;
//   final double? text_size;
//   final FontWeight? text_fontweight;
//   final bool image_value;
//   final VoidCallback? onTap;
//   final bool? isDark;
//
//   const MainButton({
//     super.key,
//     required this.btn_title,
//     required this.btn_radius,
//     this.btn_color,
//     required this.btn_boarder_color,
//     required this.title_color,
//     this.text_size = 16,
//     this.text_fontweight = FontWeight.w600,
//     this.btn_image = '',
//     required this.image_value,
//     this.onTap,
//     this.isDark,  this.height =48,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         width: MediaQuery.of(context).size.width,
//         height: height,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(btn_radius),
//           color: btn_color ?? (isDark == true
//               ? JAppColors.backGroundDark
//               : JAppColors.primary),
//           border: Border.all(color: btn_boarder_color),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//           child: Center(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 if (image_value)
//                   Row(
//                     children: [
//                       Image.asset(
//                         btn_image!,
//                         width: 24,
//                         height: 24,
//                       ),
//                       const SizedBox(width: 10),
//                     ],
//                   ),
//                 Text(
//                   btn_title,
//                   style: AppTextStyle.dmSans(
//                     color: title_color,
//                     fontSize: text_size!,
//                     weight: text_fontweight!,
//                   ),
//                 ).tr(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//
// }


// // // import 'package:flutter/material.dart';
// // // import '../constants/app_text_style.dart';
// // // import '../constants/colors.dart';
// // //
// // // class MainButton extends StatelessWidget {
// // //   final String btn_title;
// // //   final String? btn_image;
// // //   final double btn_radius;
// // //   final Color btn_color;
// // //   final Color title_color;
// // //   final Color btn_boarder_color;
// // //   final double? text_size;
// // //   final FontWeight? text_fontweight;
// // //   final bool image_value;
// // //   final VoidCallback? onTap;
// // //   final bool? isDark;
// // //
// // //   const MainButton({
// // //     super.key,
// // //     required this.btn_title,
// // //     required this.btn_radius,
// // //     required this.btn_color,
// // //     required this.btn_boarder_color,
// // //     required this.title_color,
// // //     this.text_size = 16,
// // //     this.text_fontweight = FontWeight.w600,
// // //     this.btn_image = '',
// // //     required this.image_value,
// // //     this.onTap,  this.isDark,
// // //
// // //   });
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return InkWell(
// // //       onTap: onTap,
// // //       child:
// // //       Container(
// // //         width: MediaQuery.of(context).size.width,
// // //         height: 50,
// // //         decoration: BoxDecoration(
// // //             borderRadius: BorderRadius.all(Radius.circular(btn_radius)),
// // //             color: isDark ? JAppColors.darkPrimary :JAppColors.primary, //Color(0xff7030F1),
// // //             border: Border.all(color: btn_boarder_color)),
// // //         child: Padding(
// // //           padding:
// // //               const EdgeInsets.only(left: 10.0, right: 10, top: 10, bottom: 10),
// // //           child: Center(
// // //               child: Row(
// // //             mainAxisAlignment: MainAxisAlignment.center,
// // //             children: [
// // //               if (image_value == true)
// // //                 Row(
// // //                   children: [
// // //                     Image.asset(
// // //                       btn_image!,
// // //                       width: 24,
// // //                       height: 24,
// // //                     ),
// // //                     SizedBox(width: 10),
// // //                   ],
// // //                 ),
// // //               Text(
// // //                 btn_title,
// // //                 style: AppTextStyle.dmSans(
// // //                     color: title_color,
// // //                     fontSize: 16.0,
// // //                     weight: text_fontweight!),
// // //               ),
// // //             ],
// // //           )),
// // //         ),
// // //       ),
// // //     );
// // //     ;
// // //   }
// // // }
// // import 'package:flutter/material.dart';
// // import '../constants/app_text_style.dart';
// // import '../constants/colors.dart';
// //
// // class MainButton extends StatelessWidget {
// //   final String btn_title;
// //   final String? btn_image;
// //   final double btn_radius;
// //   final Color? btn_color;
// //   final Color title_color;
// //   final Color btn_boarder_color;
// //   final double? text_size;
// //   final FontWeight? text_fontweight;
// //   final bool image_value;
// //   final VoidCallback? onTap;
// //   final bool? isDark;
// //
// //   const MainButton({
// //     super.key,
// //     required this.btn_title,
// //     required this.btn_radius,
// //     this.btn_color,
// //     required this.btn_boarder_color,
// //     required this.title_color,
// //     this.text_size = 16,
// //     this.text_fontweight = FontWeight.w600,
// //     this.btn_image = '',
// //     required this.image_value,
// //     this.onTap,
// //     this.isDark,
// //   });
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return InkWell(
// //       onTap: onTap,
// //       child: Container(
// //         width: MediaQuery.of(context).size.width,
// //         height: 48,
// //         decoration: BoxDecoration(
// //           borderRadius: BorderRadius.circular(btn_radius),
// //           color: btn_color ?? (isDark == true
// //               ? JAppColors.darkPrimary
// //               : JAppColors.primary),
// //           border: Border.all(color: btn_boarder_color),
// //         ),
// //         child: Padding(
// //           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
// //           child: Center(
// //             child: Row(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 if (image_value)
// //                   Row(
// //                     children: [
// //                       Image.asset(
// //                         btn_image!,
// //                         width: 24,
// //                         height: 24,
// //                       ),
// //                       const SizedBox(width: 10),
// //                     ],
// //                   ),
// //                 Text(
// //                   btn_title,
// //                   style: AppTextStyle.dmSans(
// //                     color: title_color,
// //                     fontSize: text_size!,
// //                     weight: text_fontweight!,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import '../constants/app_text_style.dart';
// import '../constants/colors.dart';
//
// class MainButton extends StatelessWidget {
//   final String btn_title;
//   final String? btn_image;
//   final double btn_radius;
//   final Color? btn_color;
//   final Color title_color;
//   final Color btn_boarder_color;
//   final double? text_size;
//   final FontWeight? text_fontweight;
//   final bool image_value;
//   final VoidCallback? onTap;
//   final bool? isDark;
//   final double? height;
//
//   const MainButton({
//     super.key,
//     required this.btn_title,
//     required this.btn_radius,
//     this.btn_color,
//     required this.btn_boarder_color,
//     required this.title_color,
//     this.text_size = 16,
//     this.text_fontweight = FontWeight.w600,
//     this.btn_image = '',
//     required this.image_value,
//     this.onTap,
//     this.isDark, this.height = 48,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         width: MediaQuery.of(context).size.width,
//         height: height,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(btn_radius),
//           color: btn_color ?? (isDark == true
//               ? JAppColors.darkBackground
//               : JAppColors.primary),
//           border: Border.all(color: btn_boarder_color),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//           child: Center(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 if (image_value)
//                   Row(
//                     children: [
//                       Image.asset(
//                         btn_image!,
//                         width: 24,
//                         height: 24,
//                       ),
//                       const SizedBox(width: 10),
//                     ],
//                   ),
//                 Text(
//                   btn_title,
//                   style: AppTextStyle.dmSans(
//                     color: title_color,
//                     fontSize: text_size!,
//                     weight: text_fontweight!,
//                   ),
//                 ).tr(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/app_text_style.dart';
import '../constants/colors.dart';

enum MainButtonType {
  primary,
  secondary,
  outlined,
  text,
  social
}

class MainButton extends StatelessWidget {
  final String btn_title;
  final String? btn_image;
  final bool isSvg; // New: To distinguish between SVG and regular image
  final double btn_radius;
  final Color? btn_color;
  final Color? title_color;
  final Color? btn_border_color;
  final double? text_size;
  final FontWeight? text_fontweight;
  final bool image_value;
  final VoidCallback? onTap;
  final bool? isDark;
  final double? height;
  final double? width;
  final MainButtonType buttonType; // New: Button type
  final bool isLoading; // New: Loading state
  final bool isRequired; // New: Required state (red border)
  final bool isFocused; // New: Focused state (teal border)
  final EdgeInsetsGeometry? padding;
  final double? imageWidth;
  final double? imageHeight;
  final bool enableShadow; // New: Enable/disable shadow

  const MainButton({
    super.key,
    required this.btn_title,
    this.btn_radius = 10.0,
    this.btn_color,
    this.btn_border_color,
    this.title_color,
    this.text_size = 16.0,
    this.text_fontweight = FontWeight.w600,
    this.btn_image,
    this.isSvg = false, // Default to regular image
    this.image_value = false,
    this.onTap,
    this.isDark,
    this.height = 52.0,
    this.width,
    this.buttonType = MainButtonType.primary,
    this.isLoading = false,
    this.isRequired = false,
    this.isFocused = false,
    this.padding,
    this.imageWidth = 24.0,
    this.imageHeight = 24.0,
    this.enableShadow = true,
  });

  // Check if button is disabled
  bool get isDisabled => onTap == null && !isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (isLoading || isDisabled) ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: width ?? MediaQuery.of(context).size.width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(btn_radius),
          color: _getBackgroundColor(),
          border: _shouldShowBorder()
              ? Border.all(
            color: _getBorderColor(),
            width: _getBorderWidth(),
          )
              : null,
          boxShadow: _shouldShowShadow()
              ? [
            BoxShadow(
              color: _getBackgroundColor().withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            ),
          ]
              : null,
        ),
        child: Padding(
          padding: padding ??
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: _buildButtonContent(context),
        ),
      ),
    );
  }

  Widget _buildButtonContent(BuildContext context) {
    if (isLoading) {
      return Center(
        child: SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(
              _getTextColor(),
            ),
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (image_value && btn_image != null)
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: isDisabled ? 0.5 : 1.0,
              child: _buildImage(),
            ),
          ),
        Flexible(
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: AppTextStyle.dmSans(
              color: _getTextColor(),
              fontSize: text_size!,
              weight: text_fontweight!,
            ),
            child: Text(
              btn_title,
              textAlign: TextAlign.center,
              style: AppTextStyle.dmSans(
                color: _getTextColor(),
                fontSize: text_size!,
                weight: text_fontweight!,
              ),
            ).tr(),
          ),
        ),
      ],
    );
  }

  Widget _buildImage() {
    if (isSvg) {
      return SvgPicture.asset(
        btn_image!,
        width: imageWidth,
        height: imageHeight,
        colorFilter: isDisabled
            ? ColorFilter.mode(
          Colors.grey.withOpacity(0.5),
          BlendMode.srcIn,
        )
            : null,
      );
    } else {
      return Image.asset(
        btn_image!,
        width: imageWidth,
        height: imageHeight,
        color: isDisabled ? Colors.grey.withOpacity(0.5) : null,
      );
    }
  }

  // Determine if border should be shown
  bool _shouldShowBorder() {
    return buttonType == MainButtonType.outlined ||
        buttonType == MainButtonType.social ||
        isRequired ||
        isFocused ||
        btn_border_color != null;
  }

  // Determine if shadow should be shown
  bool _shouldShowShadow() {
    return enableShadow &&
        !isDisabled &&
        (buttonType == MainButtonType.primary ||
            buttonType == MainButtonType.secondary);
  }

  // Get border width
  double _getBorderWidth() {
    if (isRequired || isFocused) {
      return 2.0; // Thicker border for required/focused states
    }
    return buttonType == MainButtonType.outlined ? 1.5 : 1.0;
  }

  // Get border color based on state
  Color _getBorderColor() {
    // Priority 1: Custom border color
    if (btn_border_color != null) {
      return btn_border_color!;
    }

    // Priority 2: Required state (red border)
    if (isRequired && !isFocused) {
      return Colors.red.shade400;
    }

    // Priority 3: Focused state (teal border)
    if (isFocused) {
      return const Color(0xFF1DB584);
    }

    // Priority 4: Disabled state
    if (isDisabled) {
      return isDark == true ? JAppColors.darkGray600 : JAppColors.lightGray400;
    }

    // Default border colors
    switch (buttonType) {
      case MainButtonType.outlined:
        return JAppColors.primary;
      case MainButtonType.social:
        return isDark == true
            ? JAppColors.darkGray600
            : JAppColors.lightGray300;
      default:
        return JAppColors.primary;
    }
  }

  // Get background color based on button type and state
  Color _getBackgroundColor() {
    // Priority 1: Custom background color
    if (btn_color != null) {
      return btn_color!;
    }

    // Priority 2: Disabled state
    if (isDisabled) {
      return isDark == true
          ? JAppColors.darkGray700
          : JAppColors.lightGray300;
    }

    // Default colors based on type
    switch (buttonType) {
      case MainButtonType.primary:
        return JAppColors.primary;
      case MainButtonType.secondary:
        return isDark == true
            ? JAppColors.darkGray700
            : JAppColors.lightGray200;
      case MainButtonType.outlined:
      case MainButtonType.text:
        return Colors.transparent;
      case MainButtonType.social:
        return isDark == true
            ? JAppColors.darkBackground
            : Colors.white;
    }
  }

  // Get text color based on button type and state
  Color _getTextColor() {
    // Priority 1: Custom text color
    if (title_color != null) {
      return title_color!;
    }

    // Priority 2: Handle primary and secondary button text colors
    if (buttonType == MainButtonType.primary ||
        buttonType == MainButtonType.secondary) {
      if (isDark == true) {
        // Dark mode: active = black text, inactive = white text
        return isDisabled ? Colors.white : Colors.black;
      } else {
        // Light mode: always white text
        return Colors.white;
      }
    }

    // Priority 3: Disabled state for other button types
    if (isDisabled) {
      return isDark == true
          ? JAppColors.darkGray400
          : JAppColors.lightGray500;
    }

    // Default text colors
    switch (buttonType) {
      case MainButtonType.outlined:
      case MainButtonType.text:
        return JAppColors.primary;
      case MainButtonType.social:
        return isDark == true ? Colors.white : JAppColors.darkGray800;
      default:
        return Colors.white;
    }
  }
}
