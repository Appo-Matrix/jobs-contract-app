//
// import 'package:flutter/material.dart';
// import 'package:job_contracts/utils/constants/text_strings.dart';
// import '../../../../../utils/common_widgets/main_button.dart';
// import '../../../../../utils/constants/app_text_style.dart';
// import '../../../../../utils/constants/colors.dart';
// import '../../../../../utils/constants/sizes.dart';
// import '../../../../routes/app_routes.dart';
// import '../model/ad.dart';
//
// class AdCard extends StatelessWidget {
//   final Ad ad;
//   final VoidCallback onViewDetails;
//   final VoidCallback onEditAd;
//   final bool isDark;
//
//   const AdCard({
//     super.key,
//     required this.ad,
//     required this.onViewDetails,
//     required this.onEditAd, required this.isDark,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Container(
//       decoration: BoxDecoration(
//         color: isDark ? JAppColors.darkGray700 : JAppColors.lightGray100,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Ad Image
//           ClipRRect(
//             borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
//             child: Image.asset(
//               ad.imageUrl,
//               height: 180,
//               width: double.infinity,
//               fit: BoxFit.cover,
//             ),
//           ),
//
//           // Ad Details
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Title
//                 Text(
//                   ad.title,
//                   style: AppTextStyle.dmSans(
//                     fontSize: 16.0,
//                     weight: FontWeight.w500,
//                     color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
//                   ),
//                 ),
//
//                 const SizedBox(height: 12),
//
//                 // Price and Category
//                 Row(
//                   children: [
//                     // Price
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             JText.price,
//                             style: AppTextStyle.dmSans(
//                               fontSize: 16.0,
//                               weight: FontWeight.w500,
//                               color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
//                             ),
//                           ),
//                           const SizedBox(height: 2),
//                           Text(
//                             '${JText.currencySymbol}${ad.price.toInt()}',
//                             style: AppTextStyle.dmSans(
//                               fontSize: 16.0,
//                               weight: FontWeight.w500,
//                               color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     // Category
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             JText.category,
//                             style: AppTextStyle.dmSans(
//                               fontSize: 16.0,
//                               weight: FontWeight.w500,
//                               color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
//                             ),
//                           ),
//                           const SizedBox(height: 2),
//                           Text(
//                             ad.category,
//                             style: AppTextStyle.dmSans(
//                               fontSize: 16.0,
//                               weight: FontWeight.w500,
//                               color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 const SizedBox(height: 16),
//
//                 Row(
//                   children: [
//                     Expanded(
//                       child: MainButton(
//                         btn_title: 'viewDetails',
//                         btn_radius: 10,
//                         btn_color: JAppColors.main,
//                         btn_border_color: Color(0xff7030F1),
//                         title_color: Colors.white,
//                         text_fontweight: FontWeight.w600,
//                         image_value: false,
//                         onTap: () {
//                           AppRouter.router.push('/adDetailsScreen');
//                         },
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: MainButton(
//                         btn_title: 'editAd',
//                         btn_radius: 10,
//                         btn_color: Colors.transparent,
//                         btn_border_color: JAppColors.t,
//                         title_color: isDark
//                             ? JAppColors.darkGray100
//                             : JAppColors.lightGray800,
//                         text_fontweight: FontWeight.w600,
//                         image_value: false,
//                         onTap: () {},
//                         text_size: JSizes.fontSizeMd,
//                       ),
//                     ),
//                   ],
//                 ),
//
//
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';
import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../routes/app_routes.dart';
import '../model/ad.dart';

class AdCard extends StatelessWidget {
  final Ad ad;
  final VoidCallback onViewDetails;
  final VoidCallback onApply;
  final VoidCallback onSave;
  final bool isDark;
  final bool isActive;
  final String? location;
  final String? date;

  const AdCard({
    super.key,
    required this.ad,
    required this.onViewDetails,
    required this.onApply,
    required this.onSave,
    required this.isDark,
    this.isActive = true,
    this.location,
    this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? JAppColors.darkGray700 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ad Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              ad.imageUrl,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // Ad Details
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Active Badge
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        ad.title,
                        style: AppTextStyle.dmSans(
                          fontSize: 16.0,
                          weight: FontWeight.w600,
                          color: isDark
                              ? JAppColors.darkGray100
                              : JAppColors.darkGray800,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (isActive)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'Active',
                          style: AppTextStyle.dmSans(
                            fontSize: 11.0,
                            weight: FontWeight.w600,
                            color: const Color(0xFF4CAF50),
                          ),
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 6),

                // Subtitle/Description
                Text(
                  ad.category,
                  style: AppTextStyle.dmSans(
                    fontSize: 13.0,
                    weight: FontWeight.w400,
                    color: isDark
                        ? JAppColors.darkGray100.withOpacity(0.7)
                        : JAppColors.darkGray800.withOpacity(0.6),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 12),

                // Price
                Text(
                  '\$${ad.price.toStringAsFixed(2)}',
                  style: AppTextStyle.dmSans(
                    fontSize: 16.0,
                    weight: FontWeight.w700,
                    color: isDark
                        ? JAppColors.darkGray100
                        : JAppColors.darkGray800,
                  ),
                ),

                const SizedBox(height: 12),

                // Location
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 16,
                      color: isDark
                          ? JAppColors.darkGray100.withOpacity(0.6)
                          : JAppColors.darkGray800.withOpacity(0.6),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      location ?? 'Location set',
                      style: AppTextStyle.dmSans(
                        fontSize: 12.0,
                        weight: FontWeight.w400,
                        color: isDark
                            ? JAppColors.darkGray100.withOpacity(0.6)
                            : JAppColors.darkGray800.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Date
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 16,
                      color: isDark
                          ? JAppColors.darkGray100.withOpacity(0.6)
                          : JAppColors.darkGray800.withOpacity(0.6),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      date ?? 'Sep 15, 2025',
                      style: AppTextStyle.dmSans(
                        fontSize: 12.0,
                        weight: FontWeight.w400,
                        color: isDark
                            ? JAppColors.darkGray100.withOpacity(0.6)
                            : JAppColors.darkGray800.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Action Buttons
                Column(
                  children: [
                    // View Ad Button (Outlined)
                    MainButton(
                      btn_title: 'View Ad',
                      btn_radius: 10,
                      title_color: Colors.white,
                      buttonType: MainButtonType.outlined,
                      text_fontweight: FontWeight.w600,
                      image_value: false,
                      onTap: onViewDetails,
                      isDark: isDark,
                    ),

                    const SizedBox(height: 10),

                    // Apply Button (Filled)
                    MainButton(
                      btn_title: 'Apply',
                      btn_radius: 10,
                      btn_color: JAppColors.primary,
                      title_color: Colors.white,
                      text_fontweight: FontWeight.w600,
                      image_value: false,
                      onTap: onApply,
                      isDark: isDark,
                    ),

                    const SizedBox(height: 10),

                    // Save Ad Button (Outlined)
                    MainButton(
                      btn_title: 'Save Ad',
                      btn_radius: 10,
                      title_color: Colors.white,
                      buttonType: MainButtonType.outlined,
                      text_fontweight: FontWeight.w600,
                      image_value: false,
                      onTap: onSave,
                      isDark: isDark,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
