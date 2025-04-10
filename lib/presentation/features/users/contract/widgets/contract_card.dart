import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:job_contracts/presentation/routes/app_routes.dart';

import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_string.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';

class ContractCard extends StatelessWidget {
  final String status;
  final String name;
  final String jobTitle;
  final String dateRange;
  final String salary;
  final String category;
  final String jobType;
  final String duration;
  final bool showActions;

  const ContractCard({
    super.key,
    required this.status,
    required this.name,
    required this.jobTitle,
    required this.dateRange,
    required this.salary,
    required this.category,
    required this.jobType,
    required this.duration,
    required this.showActions,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    final statusColor = _getStatusColor(status);
    final containerColor =
        isDark ? JAppColors.darkGray700 : JAppColors.lightGray100;
    final textColor =
        isDark ? JAppColors.lightGray300 : JAppColors.lightGray900;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Contractor info
            Row(
              children: [
                CircleAvatar(backgroundImage: AssetImage(JImages.image)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            name,
                            style: AppTextStyle.dmSans(
                              color: isDark
                                  ? Colors.white
                                  : JAppColors.lightGray900,
                              fontSize: 16.0,
                              weight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 5),
                          Image(
                              image: AssetImage(JImages.verify),
                              height: 16,
                              width: 16)
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            JImages.locationSvg,
                            height: 20,
                            width: 20,
                            colorFilter: ColorFilter.mode(
                              isDark
                                  ? JAppColors.lightGray100
                                  : JAppColors.primary,
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'United States',
                            style: AppTextStyle.dmSans(
                              color: isDark
                                  ? Colors.white
                                  : JAppColors.lightGray700,
                              fontSize: 14.0,
                              weight: FontWeight.w400,
                            ),
                          ),
                          Spacer(),
                          Text(
                            dateRange,
                            style: AppTextStyle.dmSans(
                              color: isDark
                                  ? Colors.white
                                  : JAppColors.lightGray700,
                              fontSize: 14.0,
                              weight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // Job title
            Text(
              jobTitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle.dmSans(
                color: isDark ? Colors.white : JAppColors.lightGray900,
                fontSize: 16.0,
                weight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 12),

            // Status and salary
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    status,
                    style: AppTextStyle.dmSans(
                      color: statusColor,
                      fontSize: 14.0,
                      weight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  'Salary: $salary',
                  style: AppTextStyle.dmSans(
                    color: isDark ? Colors.white : JAppColors.lightGray800,
                    fontSize: 13.0,
                    weight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Category
            Row(
              children: [
                Text(
                  'Category: ',
                  style: AppTextStyle.dmSans(
                    color: textColor,
                    fontSize: 12.0,
                    weight: FontWeight.w500,
                  ),
                ),
                Text(
                  category,
                  style: AppTextStyle.dmSans(
                    color: isDark ? JAppColors.lightest : JAppColors.primary,
                    fontSize: 14.0,
                    weight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Job type
            Row(
              children: [
                Text(
                  'Job Type: ',
                  style: AppTextStyle.dmSans(
                    color: textColor,
                    fontSize: 12.0,
                    weight: FontWeight.w500,
                  ),
                ),
                Text(
                  jobType,
                  style: AppTextStyle.dmSans(
                    color: isDark ? JAppColors.lightest : JAppColors.primary,
                    fontSize: 12.0,
                    weight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Duration
            Row(
              children: [
                Text(
                  'Job Duration: ',
                  style: AppTextStyle.dmSans(
                    color: textColor,
                    fontSize: 12.0,
                    weight: FontWeight.w400,
                  ),
                ),
                Text(
                  duration,
                  style: AppTextStyle.dmSans(
                    color: isDark ? JAppColors.lightest : JAppColors.primary,
                    fontSize: 12.0,
                    weight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Action buttons - Only show for Active contracts or if explicitly requested
            if (showActions)
              Row(
                children: [
                  Expanded(
                    child:
                    MainButton(
                      btn_title: "Submit Work",
                      btn_radius: 10,
                      btn_color: JAppColors.main,
                      btn_boarder_color: Color(0xff7030F1),
                      title_color: Colors.white,
                      text_fontweight: FontWeight.w600,
                      image_value: false,
                      onTap: () {
                        AppRouter.router.push('/contractDetailScreen');
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: MainButton(
                      btn_title: "Send Message",
                      btn_radius: 10,
                      btn_color: Colors.transparent,
                      btn_boarder_color: JAppColors.t,
                      title_color: isDark
                          ? JAppColors.darkGray100
                          : JAppColors.lightGray800,
                      text_fontweight: FontWeight.w600,
                      image_value: false,
                      onTap: () {},
                      text_size: JSizes.fontSizeMd,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Active':
        return Colors.green;
      case 'Completed':
        return Colors.blue;
      case 'Paused':
        return Colors.orange;
      case 'Cancelled':
        return Colors.red;
      case 'Pending':
        return Colors.amber;
      case 'Under Review':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}
