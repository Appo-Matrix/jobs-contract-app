import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';

import '../../../../../../utils/constants/app_text_style.dart';
import '../../../../../../utils/constants/colors.dart';
import 'JBottomSheet.dart';

void showResumeBottomSheet(BuildContext context ,bool isDark) {
  JBottomSheet.show(
    context: context,
    title: JText.addResume,
    subtitle: JText.addResumeDes,
    content: Column(
      children: [
        // Upload container
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 32),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300, width: 1, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              const Icon(Icons.upload_file, size: 32),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  // Implement file picker
                },
                child: const Text(JText.uploadCV),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Help text
        Text(
          JText.uploadCVDesc,
          style: AppTextStyle.dmSans(
            color: isDark
                ? JAppColors.darkGray100
                : JAppColors.lightGray900.withValues(alpha: 0.4),
            fontSize: 14.0,
            weight: FontWeight.w400,
          ),
        ),
      ],
    ),
    onSave: () {
      // Save resume
      Navigator.pop(context);
    }, backgroundColor: null,
  );
}