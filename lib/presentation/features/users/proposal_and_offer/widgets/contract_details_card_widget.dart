import 'package:flutter/material.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import 'contract_detail_row_widget.dart';

class ContractDetailsCardWidget extends StatelessWidget {
  final bool isDark;
  final List<Map<String, String>> contractDetails;
  final String projectDescription;

  const ContractDetailsCardWidget({
    super.key,
    required this.isDark,
    required this.contractDetails,
    required this.projectDescription,
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
          // Contract Details
          ...contractDetails.map((detail) {
            return Column(
              children: [
                ContractDetailRowWidget(
                  isDark: isDark,
                  label: detail['label']!,
                  value: detail['value']!,
                ),
                const SizedBox(height: 12),
              ],
            );
          }).toList(),

          // Divider
          Divider(
            color: isDark ? JAppColors.darkGray700 : Colors.grey[300],
          ),
          const SizedBox(height: 16),

          // Project Description
          Text(
            'Project Description',
            style: AppTextStyle.dmSans(
              fontSize: 14.0,
              weight: FontWeight.w600,
              color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            projectDescription,
            style: AppTextStyle.dmSans(
              fontSize: 13.0,
              weight: FontWeight.w400,
              color: isDark
                  ? JAppColors.darkGray100.withOpacity(0.8)
                  : JAppColors.darkGray800.withOpacity(0.8),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
