// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:job_contracts/presentation/routes/app_routes.dart';
//
// import '../../../../../utils/common_widgets/main_button.dart';
// import '../../../../../utils/constants/app_text_style.dart';
// import '../../../../../utils/constants/colors.dart';
// import '../../../../../utils/constants/image_string.dart';
// import '../../../../../utils/constants/sizes.dart';
// import '../../../../../utils/device/device_utility.dart';
//
// class ContractCard extends StatelessWidget {
//   final String status;
//   final String name;
//   final String jobTitle;
//   final String dateRange;
//   final String salary;
//   final String category;
//   final String jobType;
//   final String duration;
//   final bool showActions;
//
//   const ContractCard({
//     super.key,
//     required this.status,
//     required this.name,
//     required this.jobTitle,
//     required this.dateRange,
//     required this.salary,
//     required this.category,
//     required this.jobType,
//     required this.duration,
//     required this.showActions,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final isDark = JDeviceUtils.isDarkMode(context);
//     final statusColor = _getStatusColor(status);
//     final containerColor =
//         isDark ? JAppColors.backGroundDarkCard
//             : JAppColors.lightGray100;
//     final textColor =
//         isDark ? JAppColors.lightGray300 : JAppColors.lightGray900;
//
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       decoration: BoxDecoration(
//         color: containerColor,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Contractor info
//             Row(
//               children: [
//                 CircleAvatar(backgroundImage: AssetImage(JImages.image)),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Text(
//                             name,
//                             style: AppTextStyle.dmSans(
//                               color: isDark
//                                   ? Colors.white
//                                   : JAppColors.lightGray900,
//                               fontSize: 16.0,
//                               weight: FontWeight.w500,
//                             ),
//                           ),
//                           SizedBox(width: 5),
//                           Image(
//                               image: AssetImage(JImages.verify),
//                               height: 16,
//                               width: 16)
//                         ],
//                       ),
//                       SizedBox(
//                         height: 8,
//                       ),
//                       Row(
//                         children: [
//                           SvgPicture.asset(
//                             JImages.locationSvg,
//                             height: 20,
//                             width: 20,
//                             colorFilter: ColorFilter.mode(
//                               isDark
//                                   ? JAppColors.lightGray100
//                                   : JAppColors.primary,
//                               BlendMode.srcIn,
//                             ),
//                           ),
//                           const SizedBox(width: 4),
//                           Text(
//                             'United States',
//                             style: AppTextStyle.dmSans(
//                               color: isDark
//                                   ? Colors.white
//                                   : JAppColors.lightGray700,
//                               fontSize: 14.0,
//                               weight: FontWeight.w400,
//                             ),
//                           ),
//                           Spacer(),
//                           Text(
//                             dateRange,
//                             style: AppTextStyle.dmSans(
//                               color: isDark
//                                   ? Colors.white
//                                   : JAppColors.lightGray700,
//                               fontSize: 14.0,
//                               weight: FontWeight.w400,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//
//             const SizedBox(height: 18),
//
//             // Job title
//             Text(
//               jobTitle,
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//               style: AppTextStyle.dmSans(
//                 color: isDark ? Colors.white : JAppColors.lightGray900,
//                 fontSize: 16.0,
//                 weight: FontWeight.w500,
//               ),
//             ),
//
//             const SizedBox(height: 12),
//
//             // Status and salary
//             Row(
//               children: [
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                   decoration: BoxDecoration(
//                     color: statusColor.withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                   child: Text(
//                     status,
//                     style: AppTextStyle.dmSans(
//                       color: statusColor,
//                       fontSize: 14.0,
//                       weight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 Text(
//                   'Salary: $salary',
//                   style: AppTextStyle.dmSans(
//                     color: isDark ? Colors.white : JAppColors.lightGray800,
//                     fontSize: 13.0,
//                     weight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//
//             const SizedBox(height: 16),
//
//             // Category
//             Row(
//               children: [
//                 Text(
//                   'Category: ',
//                   style: AppTextStyle.dmSans(
//                     color: textColor,
//                     fontSize: 12.0,
//                     weight: FontWeight.w500,
//                   ),
//                 ),
//                 Text(
//                   category,
//                   style: AppTextStyle.dmSans(
//                     color: isDark ? JAppColors.lightest : JAppColors.primary,
//                     fontSize: 14.0,
//                     weight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//
//             const SizedBox(height: 12),
//
//             // Job type
//             Row(
//               children: [
//                 Text(
//                   'Job Type: ',
//                   style: AppTextStyle.dmSans(
//                     color: textColor,
//                     fontSize: 12.0,
//                     weight: FontWeight.w500,
//                   ),
//                 ),
//                 Text(
//                   jobType,
//                   style: AppTextStyle.dmSans(
//                     color: isDark ? JAppColors.lightest : JAppColors.primary,
//                     fontSize: 12.0,
//                     weight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//
//             const SizedBox(height: 12),
//
//             // Duration
//             Row(
//               children: [
//                 Text(
//                   'Job Duration: ',
//                   style: AppTextStyle.dmSans(
//                     color: textColor,
//                     fontSize: 12.0,
//                     weight: FontWeight.w400,
//                   ),
//                 ),
//                 Text(
//                   duration,
//                   style: AppTextStyle.dmSans(
//                     color: isDark ? JAppColors.lightest : JAppColors.primary,
//                     fontSize: 12.0,
//                     weight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//
//             const SizedBox(height: 16),
//
//             // Action buttons - Only show for Active contracts or if explicitly requested
//             if (showActions)
//               Row(
//                 children: [
//                   Expanded(
//                     child:
//                     MainButton(
//                       btn_title: "Submit Work",
//                       btn_radius: 10,
//                       btn_color: JAppColors.main,
//                       btn_boarder_color: Color(0xff7030F1),
//                       title_color: Colors.white,
//                       text_fontweight: FontWeight.w600,
//                       image_value: false,
//                       onTap: () {
//                         AppRouter.router.push('/contractDetailScreen');
//                       },
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: MainButton(
//                       btn_title: "Send Message",
//                       btn_radius: 10,
//                       btn_color: Colors.transparent,
//                       btn_boarder_color: JAppColors.t,
//                       title_color: isDark
//                           ? JAppColors.darkGray100
//                           : JAppColors.lightGray800,
//                       text_fontweight: FontWeight.w600,
//                       image_value: false,
//                       onTap: () {},
//                       text_size: JSizes.fontSizeMd,
//                     ),
//                   ),
//                 ],
//               ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Color _getStatusColor(String status) {
//     switch (status) {
//       case 'Active':
//         return Colors.green;
//       case 'Completed':
//         return Colors.blue;
//       case 'Paused':
//         return Colors.orange;
//       case 'Cancelled':
//         return Colors.red;
//       case 'Pending':
//         return Colors.amber;
//       case 'Under Review':
//         return Colors.purple;
//       default:
//         return Colors.grey;
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:job_contracts/presentation/routes/app_routes.dart';

import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_string.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';

class ContractCard extends StatefulWidget {
  final String status;
  final String name;
  final String jobTitle;
  final String dateRange;
  final String salary;
  final String category;
  final String jobType;
  final String duration;
  final bool showActions;
  final bool isVerified;
  final String? contractorImage;

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
    this.isVerified = true,
    this.contractorImage,
  });

  @override
  State<ContractCard> createState() => _ContractCardState();
}

class _ContractCardState extends State<ContractCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    final statusColor = _getStatusColor(widget.status);
    final textColor = isDark ? JAppColors.lightGray300 : JAppColors.lightGray900;
    final accentColor = isDark ? JAppColors.lightest : JAppColors.primary;
    final containerColor = isDark ? JAppColors.backGroundDarkCard : JAppColors.lightGray100;
    final iconColor = isDark ? JAppColors.lightGray100 : JAppColors.primary;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: isDark ? null : [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row - Status Badge & Salary
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Status Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  widget.status,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),

              // Salary with styled presentation
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isDark ? Colors.green.withOpacity(0.2) : Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.attach_money,
                      size: 16,
                      color: isDark ? Colors.green[300] : Colors.green[700],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      widget.salary.replaceAll("\$", ""),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.green[300] : Colors.green[700],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Job Title
          Text(
            widget.jobTitle,
            style: AppTextStyle.dmSans(
              fontSize: 20.0,
              weight: FontWeight.w700,
              color: isDark ? Colors.white : JAppColors.lightGray900,
            ),
          ),
          const SizedBox(height: 16),

          // Job Details with Icons - Wrap in SingleChildScrollView to prevent overflow
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildIconDetail(Icons.category_outlined, widget.category, iconColor, textColor, isDark),
                const SizedBox(width: 16),
                _buildIconDetail(Icons.access_time, widget.duration, iconColor, textColor, isDark),
                const SizedBox(width: 16),
                _buildIconDetail(Icons.work_outline, widget.jobType, iconColor, textColor, isDark),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Date Range
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isDark ? Colors.white.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.date_range,
                  size: 16,
                  color: iconColor,
                ),
                const SizedBox(width: 6),
                Text(
                  widget.dateRange,
                  style: AppTextStyle.dmSans(
                    fontSize: JSizes.fontSizeSm,
                    color: isDark ? Colors.white : JAppColors.lightGray900,
                    weight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Description Section (optional - you can add more details about the contract here)
          AnimatedCrossFade(
            firstChild: Container(),
            secondChild: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Contract Details",
                    style: AppTextStyle.dmSans(
                      fontSize: 16.0,
                      weight: FontWeight.w600,
                      color: isDark ? Colors.white : JAppColors.lightGray900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "This contract covers the agreed scope of work for the ${widget.category} project. The work is to be completed within ${widget.duration} from the start date. All deliverables must meet the specified requirements.",
                    style: AppTextStyle.dmSans(
                      fontSize: JSizes.fontSizeEaSm,
                      color: textColor.withValues(alpha: 0.9),
                      height: 1.5,
                      weight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),

          // See More/Less Button (if you want to include expandable content)
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _isExpanded ? "See Less" : "See Details",
                    style: AppTextStyle.dmSans(
                      fontSize: 14.0,
                      weight: FontWeight.w600,
                      color: accentColor,
                    ),
                  ),
                  Icon(
                    _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    size: 16,
                    color: accentColor,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Divider
          Divider(
            color: isDark ? Colors.white.withOpacity(0.1) : Colors.grey.withOpacity(0.2),
            thickness: 1,
          ),

          const SizedBox(height: 16),

          // Contractor section with improved layout
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Contractor Avatar with verification badge
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: widget.contractorImage != null
                        ? Image(
                      image: AssetImage(widget.contractorImage!),
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    )
                        : Container(
                      width: 50,
                      height: 50,
                      color: isDark ? Colors.grey[700] : Colors.grey[300],
                      child: Icon(
                        Icons.person,
                        size: 36,
                        color: isDark ? Colors.grey[500] : Colors.grey,
                      ),
                    ),
                  ),
                  if (widget.isVerified)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: isDark ? JAppColors.backGroundDarkCard : Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isDark ? JAppColors.backGroundDarkCard : Colors.white,
                            width: 2,
                          ),
                        ),
                        child: Image(
                          height: 16,
                          width: 16,
                          image: AssetImage(JImages.verify),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 16),

              // Contractor Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Contractor Name
                    Text(
                      widget.name,
                      style: AppTextStyle.dmSans(
                        fontSize: 16.0,
                        weight: FontWeight.w600,
                        color: isDark ? Colors.white : JAppColors.lightGray900,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),

                    // Location - Fixed to prevent overflow
                    Row(
                      children: [
                        SvgPicture.asset(
                          JImages.locationSvg,
                          width: 16,
                          height: 16,
                          colorFilter: ColorFilter.mode(
                            iconColor,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            'United States',
                            style: AppTextStyle.dmSans(
                              fontSize: 12.0,
                              color: textColor.withValues(alpha: 0.8),
                              weight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Action buttons - Only show for Active contracts or if explicitly requested
          if (widget.showActions) ...[
            const SizedBox(height: 20),
            // Use Wrap to handle button overflow for small screens
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                SizedBox(
                  width: (MediaQuery.of(context).size.width - 76) / 2, // Calculate width to fit properly
                  child: MainButton(
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
                SizedBox(
                  width: (MediaQuery.of(context).size.width - 76) / 2, // Calculate width to fit properly
                  child: MainButton(
                    btn_title: "Send Message",
                    btn_radius: 10,
                    btn_color: Colors.transparent,
                    btn_boarder_color: JAppColors.t,
                    title_color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                    text_fontweight: FontWeight.w600,
                    image_value: false,
                    onTap: () {},
                    text_size: JSizes.fontSizeMd,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildIconDetail(IconData icon, String value, Color iconColor, Color textColor, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: iconColor,
          ),
          const SizedBox(width: 6),
          Text(
            value,
            style: AppTextStyle.dmSans(
              fontSize: JSizes.fontSizeSm,
              color: isDark ? Colors.white : JAppColors.lightGray900,
              weight: FontWeight.w500,
            ),
          ),
        ],
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