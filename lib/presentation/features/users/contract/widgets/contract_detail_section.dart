// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../../../../../../utils/constants/app_text_style.dart';
// import '../../../../../../utils/constants/colors.dart';
// import 'conractor_profile.dart';
//
// class ContractDetailsSection extends StatelessWidget {
//   final bool isDark;
//
//   const ContractDetailsSection({super.key, required this.isDark});
//
//   @override
//   Widget build(BuildContext context) {
//     final containerColor = isDark ? JAppColors.backGroundDarkCard : JAppColors.lightGray100;
//     final textColor = isDark ? JAppColors.lightGray300 : JAppColors.lightGray900;
//     final accentColor = isDark ? JAppColors.lightest : JAppColors.primary;
//     final iconColor = isDark ? JAppColors.lightGray100 : JAppColors.primary;
//
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: containerColor,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: isDark ? null : [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Salary with styled presentation
//           Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                 decoration: BoxDecoration(
//                   color: isDark ? Colors.green.withOpacity(0.2) : Colors.green.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(
//                       Icons.attach_money,
//                       size: 16,
//                       color: isDark ? Colors.green[300] : Colors.green[700],
//                     ),
//                     const SizedBox(width: 4),
//                     Text(
//                       "20,000 - 25,000",
//                       style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w600,
//                         color: isDark ? Colors.green[300] : Colors.green[700],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Spacer(),
//               IconButton(
//                 icon: Icon(
//                   Icons.more_vert,
//                   color: isDark ? JAppColors.darkGray100 : Colors.black,
//                 ),
//                 onPressed: () {},
//                 padding: EdgeInsets.zero,
//                 constraints: const BoxConstraints(),
//               ),
//             ],
//           ),
//
//           const SizedBox(height: 16),
//
//           // Job details with icon containers
//           SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Row(
//               children: [
//                 _buildIconDetail(Icons.category_outlined, "Electrician", iconColor, textColor, isDark),
//                 const SizedBox(width: 12),
//                 _buildIconDetail(Icons.work_outline, "Onsite", iconColor, textColor, isDark),
//                 const SizedBox(width: 12),
//                 _buildIconDetail(Icons.access_time, "1 Month", iconColor, textColor, isDark),
//               ],
//             ),
//           ),
//
//           const SizedBox(height: 16),
//
//           // Divider
//           Divider(
//             color: isDark ? Colors.white.withOpacity(0.1) : Colors.grey.withOpacity(0.2),
//             thickness: 1,
//           ),
//
//           const SizedBox(height: 16),
//
//           // Contractor Profile
//           ContractorProfile(isDark: isDark),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildIconDetail(IconData icon, String value, Color iconColor, Color textColor, bool isDark) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       decoration: BoxDecoration(
//         color: isDark ? Colors.white.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Row(
//         children: [
//           Icon(
//             icon,
//             size: 16,
//             color: iconColor,
//           ),
//           const SizedBox(width: 6),
//           Text(
//             value,
//             style: AppTextStyle.dmSans(
//               fontSize: 12.0,
//               color: isDark ? Colors.white : JAppColors.lightGray900,
//               weight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import 'conractor_profile.dart';

class ContractDetailsSection extends StatelessWidget {
  final bool isDark;

  const ContractDetailsSection({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final containerColor = isDark ? JAppColors.backGroundDarkCard : JAppColors.lightGray100;
    final textColor = isDark ? JAppColors.lightGray300 : JAppColors.lightGray900;
    final accentColor = isDark ? JAppColors.lightest : JAppColors.primary;
    final iconColor = isDark ? JAppColors.lightGray100 : JAppColors.primary;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
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
          // Salary with styled presentation
          Row(
            children: [
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
                      "20,000 - 25,000",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.green[300] : Colors.green[700],
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              IconButton(
                icon: Icon(
                  Icons.more_vert,
                  color: isDark ? JAppColors.darkGray100 : Colors.black,
                ),
                onPressed: () {},
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Job details with icon containers
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildIconDetail(Icons.category_outlined, "Electrician", iconColor, textColor, isDark),
                const SizedBox(width: 12),
                _buildIconDetail(Icons.work_outline, "Onsite", iconColor, textColor, isDark),
                const SizedBox(width: 12),
                _buildIconDetail(Icons.access_time, "1 Month", iconColor, textColor, isDark),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Divider
          Divider(
            color: isDark ? Colors.white.withOpacity(0.1) : Colors.grey.withOpacity(0.2),
            thickness: 1,
          ),

          const SizedBox(height: 16),

          // Contractor Profile
          ContractorProfile(isDark: isDark),
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
              fontSize: 12.0,
              color: isDark ? Colors.white : JAppColors.lightGray900,
              weight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}