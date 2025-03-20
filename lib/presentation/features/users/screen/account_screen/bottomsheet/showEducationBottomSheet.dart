import 'package:flutter/material.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';
import 'package:job_contracts/utils/device/device_utility.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/common_widgets/text_field_widget.dart'; // Import your TextFieldWidget

import '../../../../../../utils/constants/app_text_style.dart';
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    JText.startDate,
                    style: AppTextStyle.dmSans(
                      fontSize: 16.0,
                      weight: FontWeight.w600,
                      color: isDark ? Colors.white : JAppColors.lightGray700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: startDateController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      suffixIcon: Icon(
                        Icons.calendar_today,
                        color: isDark ? Colors.white70 : JAppColors.lightGray500,
                      ),
                    ),
                    readOnly: true, // Makes the text field clickable but not editable
                    onTap: () {
                      // Show date picker when tapped
                      _selectDate(context, startDateController);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    JText.endDate,
                    style: AppTextStyle.dmSans(
                      fontSize: 16.0,
                      weight: FontWeight.w600,
                      color: isDark ? Colors.white : JAppColors.lightGray700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: endDateController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      suffixIcon: Icon(
                        Icons.calendar_today,
                        color: isDark ? Colors.white70 : JAppColors.lightGray500,
                      ),
                    ),
                    readOnly: true, // Makes the text field clickable but not editable
                    onTap: () {
                      // Show date picker when tapped
                      _selectDate(context, endDateController);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

      ],
    ),
    onSave: () {
      // Save education data
      Navigator.pop(context);
    },
  );
}

Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
  );
  if (picked != null) {
    // Format the date as needed
    controller.text = "${picked.day}/${picked.month}/${picked.year}";
  }
}
