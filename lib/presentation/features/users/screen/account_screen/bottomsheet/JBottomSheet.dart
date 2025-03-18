import 'package:flutter/material.dart';
import 'package:job_contracts/utils/constants/colors.dart';

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
    Key? key,
    required this.title,
    required this.subtitle,
    required this.content,
    required this.onSave,
    this.borderRadius = 16.0,
    required this.saveButtonColor,
    required this.backgroundColor,
    required this.isDark,
    this.saveButtonText = 'Save',
  }) : super(key: key);

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
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),

                      // Subtitle
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 24.0),
                        child: Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 14,
                            color: subtitleColor,
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

            // Save button (fixed at bottom)
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: onSave,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: saveButtonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    saveButtonText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
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