import 'package:flutter/material.dart';
import 'package:job_contracts/utils/constants/colors.dart';

import '../../../../../../utils/common_widgets/main_button.dart';
import '../../../../../../utils/constants/app_text_style.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/constants/text_strings.dart';

class JBottomSheet extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget content;
  final VoidCallback onSave;
  final double borderRadius;
  final Color saveButtonColor;
  final Color backgroundColor;
  final bool isDark;
  final String saveButtonText;

  const JBottomSheet({
    super.key,
    required this.title,
    required this.subtitle,
    required this.content,
    required this.onSave,
    this.borderRadius = 16.0,
    required this.saveButtonColor,
    required this.backgroundColor,
    required this.isDark,
    this.saveButtonText = 'Save',
  });

  @override
  Widget build(BuildContext context) {
    final textColor = isDark ? JAppColors.darkGray100 : JAppColors.lightGray900;
    final subtitleColor = isDark ? JAppColors.darkGray300 : JAppColors.lightGray600;
    final dividerColor = isDark ? JAppColors.darkGray600 : JAppColors.lightGray300;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
        ),
      ),
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header line indicator
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: dividerColor,
                borderRadius: BorderRadius.circular(2),
              ),
              margin: const EdgeInsets.only(top: 12, bottom: 20),
            ),

            // Main content in a scrollable container
            Flexible(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Title
                      Text(
                        title,
                        style: AppTextStyle.dmSans(
                          fontSize: 18.0,
                          weight: FontWeight.w600,
                          color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                        ),
                      ),

                      // Subtitle
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 24.0),
                        child: Text(
                          subtitle,
                          style: AppTextStyle.dmSans(
                            fontSize: 12.0,
                            weight: FontWeight.w400,
                            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      // Content
                      content,

                      // Add some space at the bottom
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),


            Padding(
              padding: EdgeInsets.symmetric(vertical: 16,horizontal: 16),
              child: MainButton(
                btn_title: JText.save,
                btn_radius: 10,
                btn_color: JAppColors.main,
                btn_boarder_color: Color(0xff7030F1),
                title_color: Colors.white,
                text_fontweight: FontWeight.w600,
                image_value: false,onTap: onSave
              ),
            ),


            SizedBox(height: JSizes.spaceBtwSections,)

          ],
        ),
      ),
    );
  }

  // Static method to show the bottom sheet
  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required String subtitle,
    required Widget content,
    required VoidCallback onSave,
    bool isDismissible = true,
    bool enableDrag = true,
    Color? backgroundColor,
    Color? saveButtonColor,
    String saveButtonText = 'Save',
    bool? isDark,
  }) {
    final bool actualIsDark = isDark ?? Theme.of(context).brightness == Brightness.dark;

    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: Colors.transparent,
      builder: (context) => JBottomSheet(
        title: title,
        subtitle: subtitle,
        content: content,
        onSave: onSave,
        backgroundColor: backgroundColor ?? (actualIsDark ? JAppColors.darkGray800 : Colors.white),
        saveButtonColor: saveButtonColor ?? JAppColors.primary,
        isDark: actualIsDark,
        saveButtonText: saveButtonText,
      ),
    );
  }
}