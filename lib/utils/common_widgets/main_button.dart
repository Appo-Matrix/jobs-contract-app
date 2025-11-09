  //
  // import 'package:easy_localization/easy_localization.dart';
  // import 'package:flutter/material.dart';
  // import 'package:flutter_svg/flutter_svg.dart';
  // import '../constants/app_text_style.dart';
  // import '../constants/colors.dart';
  //
  // enum MainButtonType {
  //   primary,
  //   secondary,
  //   outlined,
  //   text,
  //   social
  // }
  //
  // class MainButton extends StatelessWidget {
  //   final String btn_title;
  //   final String? btn_image;
  //   final bool isSvg; // New: To distinguish between SVG and regular image
  //   final double btn_radius;
  //   final Color? btn_color;
  //   final Color? title_color;
  //   final Color? btn_border_color;
  //   final double? text_size;
  //   final FontWeight? text_fontweight;
  //   final bool image_value;
  //   final VoidCallback? onTap;
  //   final bool? isDark;
  //   final double? height;
  //   final double? width;
  //   final MainButtonType buttonType; // New: Button type
  //   final bool isLoading; // New: Loading state
  //   final bool isRequired; // New: Required state (red border)
  //   final bool isFocused; // New: Focused state (teal border)
  //   final EdgeInsetsGeometry? padding;
  //   final double? imageWidth;
  //   final double? imageHeight;
  //   final bool enableShadow; // New: Enable/disable shadow
  //
  //   const MainButton({
  //     super.key,
  //     required this.btn_title,
  //     this.btn_radius = 10.0,
  //     this.btn_color,
  //     this.btn_border_color,
  //     this.title_color,
  //     this.text_size = 16.0,
  //     this.text_fontweight = FontWeight.w600,
  //     this.btn_image,
  //     this.isSvg = false, // Default to regular image
  //     this.image_value = false,
  //     this.onTap,
  //     this.isDark,
  //     this.height = 52.0,
  //     this.width,
  //     this.buttonType = MainButtonType.primary,
  //     this.isLoading = false,
  //     this.isRequired = false,
  //     this.isFocused = false,
  //     this.padding,
  //     this.imageWidth = 24.0,
  //     this.imageHeight = 24.0,
  //     this.enableShadow = true,
  //   });
  //
  //   // Check if button is disabled
  //   bool get isDisabled => onTap == null && !isLoading;
  //
  //   @override
  //   Widget build(BuildContext context) {
  //     return GestureDetector(
  //       onTap: (isLoading || isDisabled) ? null : onTap,
  //       child: AnimatedContainer(
  //         duration: const Duration(milliseconds: 200),
  //         width: width ?? MediaQuery.of(context).size.width,
  //         height: height,
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(btn_radius),
  //           color: _getBackgroundColor(),
  //           border: _shouldShowBorder()
  //               ? Border.all(
  //             color: _getBorderColor(),
  //             width: _getBorderWidth(),
  //           )
  //               : null,
  //           boxShadow: _shouldShowShadow()
  //               ? [
  //             BoxShadow(
  //               color: _getBackgroundColor().withOpacity(0.15),
  //               blurRadius: 8,
  //               offset: const Offset(0, 4),
  //               spreadRadius: 0,
  //             ),
  //           ]
  //               : null,
  //         ),
  //         child: Padding(
  //           padding: padding ??
  //               const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  //           child: _buildButtonContent(context),
  //         ),
  //       ),
  //     );
  //   }
  //
  //   Widget _buildButtonContent(BuildContext context) {
  //     if (isLoading) {
  //       return Center(
  //         child: SizedBox(
  //           height: 20,
  //           width: 20,
  //           child: CircularProgressIndicator(
  //             strokeWidth: 2,
  //             valueColor: AlwaysStoppedAnimation<Color>(
  //               _getTextColor(),
  //             ),
  //           ),
  //         ),
  //       );
  //     }
  //
  //     return Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       mainAxisSize: MainAxisSize.min,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         if (image_value && btn_image != null)
  //           Padding(
  //             padding: const EdgeInsets.only(right: 8.0),
  //             child: AnimatedOpacity(
  //               duration: const Duration(milliseconds: 200),
  //               opacity: isDisabled ? 0.5 : 1.0,
  //               child: _buildImage(),
  //             ),
  //           ),
  //         Flexible(
  //           child: AnimatedDefaultTextStyle(
  //             duration: const Duration(milliseconds: 200),
  //             style: AppTextStyle.dmSans(
  //               color: _getTextColor(),
  //               fontSize: text_size!,
  //               weight: text_fontweight!,
  //             ),
  //             child: Text(
  //               btn_title,
  //               textAlign: TextAlign.center,
  //               style: AppTextStyle.dmSans(
  //                 color: _getTextColor(),
  //                 fontSize: text_size!,
  //                 weight: text_fontweight!,
  //               ),
  //             ).tr(),
  //           ),
  //         ),
  //       ],
  //     );
  //   }
  //
  //   Widget _buildImage() {
  //     if (isSvg) {
  //       return SvgPicture.asset(
  //         btn_image!,
  //         width: imageWidth,
  //         height: imageHeight,
  //         colorFilter: isDisabled
  //             ? ColorFilter.mode(
  //           Colors.grey.withOpacity(0.5),
  //           BlendMode.srcIn,
  //         )
  //             : null,
  //       );
  //     } else {
  //       return Image.asset(
  //         btn_image!,
  //         width: imageWidth,
  //         height: imageHeight,
  //         color: isDisabled ? Colors.grey.withOpacity(0.5) : null,
  //       );
  //     }
  //   }
  //
  //   // Determine if border should be shown
  //   bool _shouldShowBorder() {
  //     return buttonType == MainButtonType.outlined ||
  //         buttonType == MainButtonType.social ||
  //         isRequired ||
  //         isFocused ||
  //         btn_border_color != null;
  //   }
  //
  //   // Determine if shadow should be shown
  //   bool _shouldShowShadow() {
  //     return enableShadow &&
  //         !isDisabled &&
  //         (buttonType == MainButtonType.primary ||
  //             buttonType == MainButtonType.secondary);
  //   }
  //
  //   // Get border width
  //   double _getBorderWidth() {
  //     if (isRequired || isFocused) {
  //       return 2.0; // Thicker border for required/focused states
  //     }
  //     return buttonType == MainButtonType.outlined ? 1.5 : 1.0;
  //   }
  //
  //   // Get border color based on state
  //   Color _getBorderColor() {
  //     // Priority 1: Custom border color
  //     if (btn_border_color != null) {
  //       return btn_border_color!;
  //     }
  //
  //     // Priority 2: Required state (red border)
  //     if (isRequired && !isFocused) {
  //       return Colors.red.shade400;
  //     }
  //
  //     // Priority 3: Focused state (teal border)
  //     if (isFocused) {
  //       return const Color(0xFF1DB584);
  //     }
  //
  //     // Priority 4: Disabled state
  //     if (isDisabled) {
  //       return isDark == true ? JAppColors.darkGray600 : JAppColors.lightGray400;
  //     }
  //
  //     // Default border colors
  //     switch (buttonType) {
  //       case MainButtonType.outlined:
  //         return JAppColors.primary;
  //       case MainButtonType.social:
  //         return isDark == true
  //             ? JAppColors.darkGray600
  //             : JAppColors.lightGray300;
  //       default:
  //         return JAppColors.primary;
  //     }
  //   }
  //
  //   // Get background color based on button type and state
  //   Color _getBackgroundColor() {
  //     // Priority 1: Custom background color
  //     if (btn_color != null) {
  //       return btn_color!;
  //     }
  //
  //     // Priority 2: Disabled state
  //     if (isDisabled) {
  //       return isDark == true
  //           ? JAppColors.darkGray700
  //           : JAppColors.lightGray300;
  //     }
  //
  //     // Default colors based on type
  //     switch (buttonType) {
  //       case MainButtonType.primary:
  //         return JAppColors.primary;
  //       case MainButtonType.secondary:
  //         return isDark == true
  //             ? JAppColors.darkGray700
  //             : JAppColors.lightGray200;
  //       case MainButtonType.outlined:
  //       case MainButtonType.text:
  //         return Colors.transparent;
  //       case MainButtonType.social:
  //         return isDark == true
  //             ? JAppColors.darkBackground
  //             : Colors.white;
  //     }
  //   }
  //
  //   // Get text color based on button type and state
  //   Color _getTextColor() {
  //     // Priority 1: Custom text color
  //     if (title_color != null) {
  //       return title_color!;
  //     }
  //
  //     // Priority 2: Handle primary and secondary button text colors
  //     if (buttonType == MainButtonType.primary ||
  //         buttonType == MainButtonType.secondary) {
  //       if (isDark == true) {
  //         // Dark mode: active = black text, inactive = white text
  //         return isDisabled ? Colors.white : Colors.black;
  //       } else {
  //         // Light mode: always white text
  //         return Colors.white;
  //       }
  //     }
  //
  //     // Priority 3: Disabled state for other button types
  //     if (isDisabled) {
  //       return isDark == true
  //           ? JAppColors.darkGray400
  //           : JAppColors.lightGray500;
  //     }
  //
  //     // Default text colors
  //     switch (buttonType) {
  //       case MainButtonType.outlined:
  //       case MainButtonType.text:
  //         return JAppColors.primary;
  //       case MainButtonType.social:
  //         return isDark == true ? Colors.white : JAppColors.darkGray800;
  //       default:
  //         return Colors.white;
  //     }
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
    final bool isSvg;
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
    final MainButtonType buttonType;
    final bool isLoading;
    final bool isRequired;
    final bool isFocused;
    final EdgeInsetsGeometry? padding;
    final double? imageWidth;
    final double? imageHeight;
    final bool enableShadow;

    // NEW: Icon support
    final IconData? prefixIcon;
    final IconData? suffixIcon;
    final double? prefixIconSize;
    final double? suffixIconSize;
    final Color? prefixIconColor;
    final Color? suffixIconColor;
    final double iconSpacing;

    const MainButton({
      super.key,
      required this.btn_title,
      this.btn_radius = 4.0,
      this.btn_color,
      this.btn_border_color,
      this.title_color,
      this.text_size = 16.0,
      this.text_fontweight = FontWeight.w600,
      this.btn_image,
      this.isSvg = false,
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

      // NEW: Icon parameters
      this.prefixIcon,
      this.suffixIcon,
      this.prefixIconSize = 24.0,
      this.suffixIconSize = 24.0,
      this.prefixIconColor,
      this.suffixIconColor,
      this.iconSpacing = 8.0,
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
          // PREFIX: Image or Icon
          if (_hasPrefixContent())
            Padding(
              padding: EdgeInsets.only(right: iconSpacing),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: isDisabled ? 0.5 : 1.0,
                child: _buildPrefixContent(),
              ),
            ),

          // TEXT
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
              ).tr(),
            ),
          ),

          // SUFFIX: Icon only (images not supported for suffix to keep it simple)
          if (suffixIcon != null)
            Padding(
              padding: EdgeInsets.only(left: iconSpacing),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: isDisabled ? 0.5 : 1.0,
                child: Icon(
                  suffixIcon,
                  size: suffixIconSize,
                  color: _getSuffixIconColor(),
                ),
              ),
            ),
        ],
      );
    }

    // Check if we have prefix content (image or icon)
    bool _hasPrefixContent() {
      return (image_value && btn_image != null) || prefixIcon != null;
    }

    // Build prefix content (image or icon)
    Widget _buildPrefixContent() {
      // Priority: Image over icon if both are provided
      if (image_value && btn_image != null) {
        return _buildImage();
      } else if (prefixIcon != null) {
        return Icon(
          prefixIcon,
          size: prefixIconSize,
          color: _getPrefixIconColor(),
        );
      }

      // Fallback
      return const SizedBox.shrink();
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
              : (_getImageColor() != null
              ? ColorFilter.mode(_getImageColor()!, BlendMode.srcIn)
              : null),
        );
      } else {
        return Image.asset(
          btn_image!,
          width: imageWidth,
          height: imageHeight,
          color: isDisabled
              ? Colors.grey.withOpacity(0.5)
              : _getImageColor(),
        );
      }
    }

    // Get prefix icon color
    Color _getPrefixIconColor() {
      if (prefixIconColor != null) return prefixIconColor!;
      return _getDefaultIconColor();
    }

    // Get suffix icon color
    Color _getSuffixIconColor() {
      if (suffixIconColor != null) return suffixIconColor!;
      return _getDefaultIconColor();
    }

    // Get image color (for SVG and PNG)
    Color? _getImageColor() {
      // For SVG, we can apply color filter
      if (isSvg) {
        return prefixIconColor ?? _getDefaultIconColor();
      }
      // For PNG, only apply color if explicitly provided or in disabled state
      return prefixIconColor;
    }

    // Get default icon color based on button type and state
    Color _getDefaultIconColor() {
      // Use similar logic as text color
      return _getTextColor();
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
        return 1.0;
      }
      return buttonType == MainButtonType.outlined ? 1 : 1.0;
    }

    // Get border color based on state
    Color _getBorderColor() {
      if (btn_border_color != null) {
        return btn_border_color!;
      }

      if (isRequired && !isFocused) {
        return Colors.red.shade400;
      }

      if (isFocused) {
        return const Color(0xFF1DB584);
      }

      if (isDisabled) {
        return isDark == true ? JAppColors.darkGray600 : JAppColors.lightGray400;
      }

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
      if (btn_color != null) {
        return btn_color!;
      }

      if (isDisabled) {
        return isDark == true
            ? JAppColors.darkGray700
            : JAppColors.lightGray300;
      }

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
      if (title_color != null) {
        return title_color!;
      }

      if (buttonType == MainButtonType.primary ||
          buttonType == MainButtonType.secondary) {
        if (isDark == true) {
          return isDisabled ? Colors.white : Colors.black;
        } else {
          return Colors.white;
        }
      }

      if (isDisabled) {
        return isDark == true
            ? JAppColors.darkGray400
            : JAppColors.lightGray500;
      }

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