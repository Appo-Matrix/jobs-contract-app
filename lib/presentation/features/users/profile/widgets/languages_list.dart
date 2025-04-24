import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // Added for FontWeight

import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';

class LanguagesList extends StatelessWidget {
  final bool isDark;

  const LanguagesList({
    super.key,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final languages = [
      {'language': 'Urdu', 'level': 'Basic'},
      {'language': 'English', 'level': 'Native'},
      {'language': 'Spanish', 'level': 'Fluent'},
      {'language': 'German', 'level': 'Basic'},
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 12,
      alignment: WrapAlignment.start,
      children: languages.map((lang) {
        return LanguageItem(
          language: lang['language']!,
          level: lang['level']!,
          isDark: isDark,
        );
      }).toList(),
    );
  }
}

class LanguageItem extends StatelessWidget {
  final String language;
  final String level;
  final bool isDark;

  const LanguageItem({
    super.key,
    required this.language,
    required this.level,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      decoration: BoxDecoration(
        color: isDark ? JAppColors.darkGray700 : JAppColors.lightGray200,
        borderRadius: BorderRadius.circular(6),
      ),
      constraints: BoxConstraints(), // Remove any default minimum constraints
      child: IntrinsicWidth( // Use IntrinsicWidth to ensure the container fits its content
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              language,
              style: AppTextStyle.dmSans(
                weight: FontWeight.normal,
                color: isDark ? JAppColors.darkGray300 : JAppColors.lightGray600, fontSize: 12.0,
              ),
            ),
            SizedBox(width: 4),
            Text(
              "• $level",
              style: AppTextStyle.dmSans(
                weight: FontWeight.normal,
                color: isDark ? JAppColors.darkGray300 : JAppColors.lightGray600, fontSize: 12.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
