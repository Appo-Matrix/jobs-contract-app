import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../utils/constants/app_text_style.dart';
import '../../../../../../utils/constants/colors.dart';
import 'file_attachment.dart';

class ActivityLogSection extends StatelessWidget {
  final bool isDark;

  const ActivityLogSection({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final containerColor =
    isDark ? JAppColors.backGroundDarkCard : JAppColors.lightGray100;
    final textColor =
    isDark ? JAppColors.lightGray300 : JAppColors.lightGray900;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Activity Log',
            style: AppTextStyle.dmSans(
              color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
              fontSize: 18.0,
              weight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const SizedBox(height: 12),

          SizedBox(height: 200,
            child: Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return           FileAttachment(isDark: isDark);

                },
              ),
            ),
          ),

        ],
      ),
    );
  }
}
