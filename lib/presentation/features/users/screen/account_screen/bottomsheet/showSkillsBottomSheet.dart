import 'package:flutter/material.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';

import '../../../../../../utils/common_widgets/text_field_widget.dart';
import '../../../../../../utils/constants/app_text_style.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';
import 'JBottomSheet.dart';

void showSkillsBottomSheet(BuildContext context ,bool isDark) {
  final searchController = TextEditingController();
  // Example selected skills
  final List<String> selectedSkills = ['Surface Repair', 'Ceiling', 'Plaster', 'mudding', 'Acoustic', 'Sanding'];

  JBottomSheet.show(
    context: context,
    title: JText.addSkill,
    subtitle: JText.addSkillDesc,
    content: Column(
      children: [
        // Search field
        TextFieldWidget(
          hintText: 'Electrician',
          prefixIcon: Icons.lock_outline,
          subTitle: JText.password,
          subtitleColor:
          isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
          titleColor:
          isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
        ),

        const SizedBox(height: 24),

        // Skills chips
        Wrap(
          spacing: 8,
          runSpacing: 12,
          children: selectedSkills.map((skill) {
            return Chip(
              label: Text(skill ,
                style: AppTextStyle.dmSans(
                  color:
                  isDark ? JAppColors.darkGray100 : JAppColors.lightGray500,
                  fontSize: JSizes.fontSizeSmx,
                  weight: FontWeight.w400,
                ),
              ),
              deleteIcon: const Icon(Icons.close, size: 16),
              onDeleted: () {
                // Handle skill deletion
              },
              backgroundColor:  isDark ? JAppColors.darkGray700 : JAppColors.lightGray200,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            );
          }).toList(),
        ),
      ],
    ),
    onSave: () {
      // Save skills
      Navigator.pop(context);
    },
  );
}