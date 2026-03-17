import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';


class BlogCardWidget extends StatelessWidget {
  final String title;
  final String createdBy;
  final String createdDate;
  final String publishedDate;
  final List<String> tags;
  final bool isDark;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const BlogCardWidget({
    Key? key,
    required this.title,
    required this.createdBy,
    required this.createdDate,
    required this.publishedDate,
    required this.tags,
    required this.isDark,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  Widget _buildTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: JAppColors.primary.withOpacity(0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: AppTextStyle.dmSans(
          fontSize: 12.0,
          weight: FontWeight.w500,
          color: JAppColors.primary,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? JAppColors.darkGray800 : JAppColors.lightGray100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? JAppColors.darkGray700 : JAppColors.lightGray300,
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
              color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray900,
            ),
          ).tr(),
          const SizedBox(height: 12),

          // Created and Published info
          Row(
            children: [
              Text(
                '$createdBy ',
                style: AppTextStyle.dmSans(
                  fontSize: 12.0,
                  weight: FontWeight.w400,
                  color: isDark ? JAppColors.darkGray400 : JAppColors.darkGray600,
                ),
              ).tr(),
              Text(
                createdDate,
                style: AppTextStyle.dmSans(
                  fontSize: 12.0,
                  weight: FontWeight.w500,
                  color: isDark ? JAppColors.darkGray300 : JAppColors.darkGray700,
                ),
              ),
              const SizedBox(width: 24),
              Text(
                'published ',
                style: AppTextStyle.dmSans(
                  fontSize: 12.0,
                  weight: FontWeight.w400,
                  color: isDark ? JAppColors.darkGray400 : JAppColors.darkGray600,
                ),
              ).tr(),
              Text(
                publishedDate,
                style: AppTextStyle.dmSans(
                  fontSize: 12.0,
                  weight: FontWeight.w500,
                  color: isDark ? JAppColors.darkGray300 : JAppColors.darkGray700,
                ),
              ).tr(),
            ],
          ),
          const SizedBox(height: 12),

          // Tags
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: tags.map((tag) => _buildTag(tag)).toList(),
          ),
          const SizedBox(height: 16),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: MainButton(
                  btn_title: "edit_button",
                  btn_radius: 8,
                  height: 44,
                  buttonType: MainButtonType.outlined,
                  title_color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray900,
                  text_fontweight: FontWeight.w500,
                  image_value: false,
                  onTap: onEdit,
                  text_size: 15,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: MainButton(
                  btn_title: "delete",
                  btn_radius: 8,
                  height: 44,
                  buttonType: MainButtonType.primary,
                  btn_color: JAppColors.error500,
                  title_color: Colors.white,
                  text_fontweight: FontWeight.w500,
                  image_value: false,
                  onTap: onDelete,
                  text_size: 15,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
