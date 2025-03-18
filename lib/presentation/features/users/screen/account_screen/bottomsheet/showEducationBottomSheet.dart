import 'package:flutter/material.dart';
import 'package:job_contracts/utils/device/device_utility.dart';
import 'package:job_contracts/utils/constants/colors.dart';

import 'JBottomSheet.dart';

void showEducationBottomSheet(BuildContext context) {
  // Form controllers
  final universityController = TextEditingController();
  final degreeController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final graduationDateController = TextEditingController();

  final bool isDark = JDeviceUtils.isDarkMode(context);

  // Define colors based on dark/light mode
  final textColor = isDark ? JAppColors.darkGray100 : JAppColors.lightGray900;
  final labelColor = isDark ? JAppColors.darkGray200 : JAppColors.lightGray600;

  // Input decoration for text fields
  final inputDecoration = (String hintText, {Widget? suffixIcon}) => InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(color: isDark ? JAppColors.darkGray400 : JAppColors.lightGray500),
    filled: true,
    fillColor: isDark ? JAppColors.darkGray700 : Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: isDark ? JAppColors.darkGray600 : JAppColors.lightGray300),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: isDark ? JAppColors.darkGray600 : JAppColors.lightGray300),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: JAppColors.primary),
    ),
    suffixIcon: suffixIcon != null
        ? IconTheme(
      data: IconThemeData(color: isDark ? JAppColors.darkGray200 : JAppColors.lightGray600),
      child: suffixIcon,
    )
        : null,
  );

  // Text style for labels
  final labelStyle = TextStyle(
    color: labelColor,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  JBottomSheet.show(
    context: context,
    title: 'Education',
    subtitle: 'Select Your Education Level & Degree',
    isDark: isDark,
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('University Name', style: labelStyle),
        const SizedBox(height: 8),
        TextField(
          controller: universityController,
          style: TextStyle(color: textColor),
          decoration: inputDecoration('University Name'),
        ),

        const SizedBox(height: 16),
        Text('Degree', style: labelStyle),
        const SizedBox(height: 8),
        TextField(
          controller: degreeController,
          style: TextStyle(color: textColor),
          decoration: inputDecoration('Ex: BBA'),
        ),

        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Start date', style: labelStyle),
                  const SizedBox(height: 8),
                  TextField(
                    controller: startDateController,
                    style: TextStyle(color: textColor),
                    decoration: inputDecoration(''),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('End date', style: labelStyle),
                  const SizedBox(height: 8),
                  TextField(
                    controller: endDateController,
                    style: TextStyle(color: textColor),
                    decoration: inputDecoration(''),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),
        Text('Graduation Date', style: labelStyle),
        const SizedBox(height: 8),
        TextField(
          controller: graduationDateController,
          style: TextStyle(color: textColor),
          decoration: inputDecoration(
            'Select Date',
            suffixIcon: Icon(Icons.calendar_today),
          ),
        ),
      ],
    ),
    onSave: () {
      // Save education data
      Navigator.pop(context);
    },
  );
}