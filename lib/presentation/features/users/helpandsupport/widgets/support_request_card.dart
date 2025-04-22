import 'package:flutter/material.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';

class SupportRequestCard extends StatelessWidget {
  final Map<String, dynamic> request;
  final bool isDark;
  final bool isLastItem;
  final VoidCallback? onTap;

  const SupportRequestCard({
    super.key,
    required this.request,
    required this.isDark,
    this.isLastItem = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: isLastItem ? 0 : 12),
      decoration: BoxDecoration(
        color: isDark ? JAppColors.backGroundDarkCard : JAppColors.lightGray100,
        borderRadius: BorderRadius.circular(12), // Always rounded for all cards
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12), // Matching borderRadius for Material
        child: InkWell(
          borderRadius: BorderRadius.circular(12), // Matching borderRadius for InkWell
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ID and Status row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: isDark ? JAppColors.darkGray700 : Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'ID: ${request['id']}',
                        style: AppTextStyle.dmSans(
                          color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray700,
                          fontSize: 13.0,
                          weight: FontWeight.w600,
                        ),
                      ),
                    ),
                    _buildStatusBadge(request['status']),
                  ],
                ),
                const SizedBox(height: 12),
                // Subject
                Text(
                  request['subject'],
                  style: AppTextStyle.dmSans(
                    color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                    fontSize: 16.0,
                    weight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                // Created and Last Activity row
                Row(
                  children: [
                    _buildInfoItem(
                      Icons.calendar_today_outlined,
                      'Created',
                      request['created'],
                    ),
                    const SizedBox(width: 24),
                    _buildInfoItem(
                      Icons.update_outlined,
                      'Last Activity',
                      request['lastActivity'],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: status == 'Solved'
            ? (isDark ? Colors.deepPurple[900]!.withOpacity(0.3) : Colors.deepPurple[50])
            : (isDark ? Colors.orange[900]!.withOpacity(0.3) : Colors.orange[50]),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        status,
        style: AppTextStyle.dmSans(
          color: status == 'Solved'
              ? (isDark ? Colors.deepPurple[100]! : Colors.deepPurple)
              : (isDark ? Colors.orange[100]! : Colors.orange[700]!),
          fontSize: 13.0,
          weight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildInfoItem(
      IconData icon,
      String label,
      String value,
      ) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14,
          color: isDark ? JAppColors.darkGray300 : JAppColors.lightGray500,
        ),
        const SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: AppTextStyle.dmSans(
                color: isDark ? JAppColors.darkGray300 : JAppColors.lightGray500,
                fontSize: 12.0,
                weight: FontWeight.w500,
              ),
            ),
            Text(
              value,
              style: AppTextStyle.dmSans(
                color: isDark ? JAppColors.darkGray200 : JAppColors.lightGray700,
                fontSize: 12.0,
                weight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}