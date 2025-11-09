import 'package:flutter/material.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import 'info_row_widget.dart';

class JobCardWidget extends StatelessWidget {
  final bool isDark;
  final String title;
  final String postedTime;
  final String location;
  final String workType;
  final String salary;
  final String category;
  final String duration;
  final String experience;
  final List<String> skills;

  const JobCardWidget({
    super.key,
    required this.isDark,
    required this.title,
    required this.postedTime,
    required this.location,
    required this.workType,
    required this.salary,
    required this.category,
    required this.duration,
    required this.experience,
    required this.skills,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? JAppColors.darkGray700 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? JAppColors.darkGray700 : Colors.grey[300]!,
          width: 1,
        ),
        boxShadow: isDark
            ? []
            : [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Job Title
          Text(
            title,
            style: AppTextStyle.dmSans(
              fontSize: 18.0,
              weight: FontWeight.w700,
              color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray800,
            ),
          ),

          const SizedBox(height: 4),

          // Posted Time
          Text(
            postedTime,
            style: AppTextStyle.dmSans(
              fontSize: 12.0,
              weight: FontWeight.w400,
              color: isDark
                  ? JAppColors.darkGray100.withOpacity(0.6)
                  : JAppColors.darkGray800.withOpacity(0.6),
            ),
          ),

          const SizedBox(height: 16),

          // Info Rows
          InfoRowWidget(
            isDark: isDark,
            icon: Icons.location_on_outlined,
            label: 'Location',
            value: location,
          ),
          const SizedBox(height: 12),
          InfoRowWidget(
            isDark: isDark,
            icon: Icons.work_outline,
            label: 'Work Type',
            value: workType,
          ),
          const SizedBox(height: 12),
          InfoRowWidget(
            isDark: isDark,
            icon: Icons.attach_money,
            label: 'Salary',
            value: salary,
          ),
          const SizedBox(height: 12),
          InfoRowWidget(
            isDark: isDark,
            icon: Icons.category_outlined,
            label: 'Category',
            value: category,
          ),
          const SizedBox(height: 12),
          InfoRowWidget(
            isDark: isDark,
            icon: Icons.schedule_outlined,
            label: 'Duration',
            value: duration,
          ),
          const SizedBox(height: 12),
          InfoRowWidget(
            isDark: isDark,
            icon: Icons.psychology_outlined,
            label: 'Experience',
            value: experience,
          ),

          const SizedBox(height: 16),

          // Skills
          Text(
            'Required Skills',
            style: AppTextStyle.dmSans(
              fontSize: 14.0,
              weight: FontWeight.w600,
              color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray800,
            ),
          ),

          const SizedBox(height: 8),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: skills.map((skill) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: JAppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: JAppColors.primary.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Text(
                  skill,
                  style: AppTextStyle.dmSans(
                    fontSize: 12.0,
                    weight: FontWeight.w500,
                    color: JAppColors.primary,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
