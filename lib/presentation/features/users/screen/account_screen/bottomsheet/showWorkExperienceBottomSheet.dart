import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';

import '../../../../../../utils/constants/app_text_style.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';
import 'JBottomSheet.dart';

void showWorkExperienceBottomSheet(BuildContext context, bool isDark) {
  // Form controllers
  final jobTitleController = TextEditingController();
  final companyController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final descriptionController = TextEditingController();

  JBottomSheet.show(
    context: context,
    title: JText.addWorkExperience,
    subtitle: JText.addWorkExperienceDesc,
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          JText.jobTitle,
          style: AppTextStyle.dmSans(
            fontSize: 16.0,
            weight: FontWeight.w600,
            color: isDark ? Colors.white : JAppColors.lightGray700,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: jobTitleController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          JText.company,
          style: AppTextStyle.dmSans(
            fontSize: 16.0,
            weight: FontWeight.w600,
            color: isDark ? Colors.white : JAppColors.lightGray700,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: companyController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            suffixIcon: const Icon(Icons.calendar_today),
          ),
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
                    ),
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
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          JText.description,
          style: AppTextStyle.dmSans(
            fontSize: 16.0,
            weight: FontWeight.w600,
            color: isDark ? Colors.white : JAppColors.lightGray700,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: descriptionController,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: JText.writeInformationDetail,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    ),
    onSave: () {
      // Save work experience
      Navigator.pop(context);
    },
  );
}
