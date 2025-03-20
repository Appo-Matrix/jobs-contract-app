import 'package:flutter/material.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';
import 'package:job_contracts/utils/device/device_utility.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/common_widgets/text_field_widget.dart'; // Import your TextFieldWidget

import 'JBottomSheet.dart';

void showEducationBottomSheet(BuildContext context) {
  // Form controllers
  final universityController = TextEditingController();
  final degreeController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final graduationDateController = TextEditingController();

  final bool isDark = JDeviceUtils.isDarkMode(context);

  JBottomSheet.show(
    context: context,
    title: JText.education,
    subtitle: JText.educationSubtitle,
    isDark: isDark,
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFieldWidget(
          subTitle: JText.universityName,
          hintText:  JText.universityName,
          prefixIcon: Icons.school,
          subtitleColor: isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
          titleColor: isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
        ),

        const SizedBox(height: 16),
        TextFieldWidget(
          subTitle: JText.degree,
          hintText: JText.exBBA,
          prefixIcon: Icons.card_membership,
          subtitleColor: isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
          titleColor: isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
        ),

        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextFieldWidget(
                subTitle: JText.startDate,
                hintText: '',
                prefixIcon: Icons.calendar_today,
                subtitleColor: isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
                titleColor: isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFieldWidget(
                subTitle: JText.endDate,
                hintText: '',
                prefixIcon: Icons.calendar_today,
                subtitleColor: isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
                titleColor: isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),
        TextFieldWidget(
          subTitle: JText.graduationDate,
          hintText: JText.selectDate,
          prefixIcon: Icons.school_outlined,
          subtitleColor: isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
          titleColor: isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
          suffixIcon: Icon(Icons.calendar_today),
        ),
      ],
    ),
    onSave: () {
      // Save education data
      Navigator.pop(context);
    },
  );
}