import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/app_text_style.dart';
import '../constants/colors.dart';
import '../constants/image_string.dart';

class JobCard extends StatelessWidget {
  final bool isDark;
  final String title;
  final String location;
  final String workType;
  final String salary;
  final String category;
  final String duration;
  final List<String> skills;
  final String experience;
  final String postedAgo;
  final VoidCallback onViewDetails;

  const JobCard({
    super.key,
    required this.isDark,
    required this.title,
    required this.location,
    required this.workType,
    required this.salary,
    required this.category,
    required this.duration,
    required this.skills,
    required this.experience,
    required this.postedAgo,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.transparent : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? JAppColors.darkGray600 : Colors.grey[300]!,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            title,
            style: AppTextStyle.dmSans(
              fontSize: 16.0,
              weight: FontWeight.w600,
              color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray800,
            ),
          ),
          const SizedBox(height: 8),

          // Location
          Row(
            children: [
              SvgPicture.asset(
                JImages.locationSvg,
                width: 16,
                height: 16,
                colorFilter: ColorFilter.mode(
                  isDark ? JAppColors.lightGray100 : JAppColors.primary,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                location,
                style: AppTextStyle.dmSans(
                  fontSize: 12.0,
                  color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray800,
                  weight: FontWeight.w400,
                ),
              ),
            ],
          ),


          const SizedBox(height: 12),

          // Tags
          Row(
            children: [
              _buildTag(workType, JAppColors.primary, Colors.white),
              const SizedBox(width: 8),
              _buildTag('Salary: $salary', Colors.green[100]!, Colors.green[800]!),
            ],
          ),
          const SizedBox(height: 12),

          // Project details
          Row(
            children: [
              Icon(Icons.business_outlined, size: 14, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(
                category,
                style: AppTextStyle.dmSans(
                  fontSize: 12.0,
                  weight: FontWeight.w400,
                  color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray800,
                ),
              ),
              const SizedBox(width: 16),
              Icon(Icons.access_time, size: 14, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(
                duration,
                style: AppTextStyle.dmSans(
                  fontSize: 12.0,
                  weight: FontWeight.w400,
                  color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Skills
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: skills.map((skill) => _buildSkillChip(skill, isDark)).toList(),
          ),
          const SizedBox(height: 12),

          // Footer
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$experience • Posted $postedAgo',
                style: AppTextStyle.dmSans(
                  fontSize: 11.0,
                  weight: FontWeight.w400,
                  color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray800,
                ),
              ),
              GestureDetector(
                onTap: onViewDetails,
                child: Text(
                  'View Details',
                  style: AppTextStyle.dmSans(
                    fontSize: 12.0,
                    weight: FontWeight.w600,
                    color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray800,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String label, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: AppTextStyle.dmSans(
          fontSize: 10.0,
          weight: FontWeight.w500,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildSkillChip(String label, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isDark ? JAppColors.darkGray600 : Colors.grey[200],
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: AppTextStyle.dmSans(
          fontSize: 11.0,
          weight: FontWeight.w500,
          color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray800,
        ),
      ),
    );
  }
}
