// import 'package:flutter/material.dart';
//
// import '../../../../../utils/common_widgets/appbar.dart';
// import '../../../../../utils/common_widgets/back_circle.dart';
// import '../../../../../utils/common_widgets/main_button.dart';
// import '../../../../../utils/constants/app_text_style.dart';
// import '../../../../../utils/constants/colors.dart';
// import '../../../../../utils/constants/sizes.dart';
// import '../../../../../utils/constants/text_strings.dart';
// import '../../../../../utils/device/device_utility.dart';
// import '../../../../routes/app_routes.dart';
//
// class ContractDetailScreen extends StatelessWidget {
//   const ContractDetailScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final isDark = JDeviceUtils.isDarkMode(context);
//
//     return Scaffold(
//       backgroundColor: isDark ? JAppColors.darkGray800 : Colors.white,
//       appBar: JAppbar(
//
//         title: Text(
//           JText.appBarTitle,
//           style: AppTextStyle.dmSans(
//             color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
//             fontSize: 20.0,
//             weight: FontWeight.w600,
//           ),
//         ),
//         leadingIcon: Padding(
//           padding: const EdgeInsets.all(3.0),
//           child: BackCircle(
//             isDark: isDark,
//             onTap: (){
//               Navigator.pop(context);
//             },
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Architects Construction Specialist',
//                 style: AppTextStyle.dmSans(
//                   color: isDark
//                       ? Colors.white
//                       : JAppColors.lightGray900,
//                   fontSize: 16.0,
//                   weight: FontWeight.w500,
//                 ),
//               ),
//
//               const SizedBox(height: 16),
//                Text(
//                 'Contract Description',
//                 style: AppTextStyle.dmSans(
//                   color: isDark
//                       ? Colors.white
//                       : JAppColors.lightGray900,
//                   fontSize: 16.0,
//                   weight: FontWeight.w500,
//                 ),
//               ),
//               const SizedBox(height: 8),
//                Text(
//
//
//                 'We are seeking a highly motivated and skilled Architects & Construction Specialist to join our dynamic team. The ideal candidate will be responsible for providing expertise in architectural planning, construction project',
//                  style: AppTextStyle.dmSans(
//                    color: isDark
//                        ? Colors.white
//                        : JAppColors.lightGray900,
//                    fontSize: 14.0,
//                    weight: FontWeight.w400,
//                  ),
//
//               ),
//               TextButton(
//                 onPressed: () {},
//                 child:  Text(
//                   'See More...',
//                   style: AppTextStyle.dmSans(
//                     color: isDark
//                         ? Colors.white
//                         : JAppColors.lightGray900,
//                     fontSize: 16.0,
//                     weight: FontWeight.w500,
//                   ),
//                 ),
//                 style: TextButton.styleFrom(
//                   padding: EdgeInsets.zero,
//                   alignment: Alignment.centerLeft,
//                   minimumSize: Size.zero,
//                   tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                 ),
//               ),
//               const SizedBox(height: 16),
//               _buildSectionContainer(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'Activity Log',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: const [
//                         Text(
//                           'You Send a File.',
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                             color: Colors.black87,
//                           ),
//                         ),
//                         Text(
//                           '12:00 Pm',
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.black54,
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 12),
//                     _buildFileAttachment(),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 16),
//               _buildSectionContainer(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text(
//                           'Salary: \$20,000 - \$25,000',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black,
//                           ),
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.more_vert),
//                           onPressed: () {},
//                           padding: EdgeInsets.zero,
//                           constraints: const BoxConstraints(),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     Row(
//                       children: const [
//                         Text(
//                           'Category: ',
//                           style: TextStyle(fontSize: 14, color: Colors.black87),
//                         ),
//                         Text(
//                           'Electrician',
//                           style: TextStyle(fontSize: 14, color: Colors.purple),
//                         ),
//                         SizedBox(width: 20),
//                         Text(
//                           'Job Type: ',
//                           style: TextStyle(fontSize: 14, color: Colors.black87),
//                         ),
//                         Text(
//                           'Onsite',
//                           style: TextStyle(fontSize: 14, color: Colors.purple),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     Row(
//                       children: const [
//                         Text(
//                           'Job Duration: ',
//                           style: TextStyle(fontSize: 14, color: Colors.black87),
//                         ),
//                         Text(
//                           '1 Month',
//                           style: TextStyle(fontSize: 14, color: Colors.purple),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 16),
//                     Row(
//                       children: [
//                         const CircleAvatar(
//                           radius: 20,
//                           backgroundImage: NetworkImage(
//                             'https://www.dmarge.com/wp-content/uploads/2021/01/dwayne-the-rock-.jpg',
//                           ),
//                         ),
//                         const SizedBox(width: 12),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: const [
//                                 Text(
//                                   'Amélie Laurent',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                                 SizedBox(width: 4),
//                                 Icon(
//                                   Icons.verified,
//                                   color: Colors.amber,
//                                   size: 16,
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               children: const [
//                                 Icon(
//                                   Icons.location_on,
//                                   color: Colors.purple,
//                                   size: 16,
//                                 ),
//                                 SizedBox(width: 4),
//                                 Text(
//                                   'United States',
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     color: Colors.black54,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 24),
//
//               Row(
//                 children: [
//                   Expanded(
//                     child: MainButton(
//                       btn_title: JText.submitWork,
//                       btn_radius: 10,
//                       btn_color: JAppColors.main,
//                       btn_boarder_color: Color(0xff7030F1),
//                       title_color: Colors.white,
//                       text_fontweight: FontWeight.w600,
//                       image_value: false,
//                       onTap: () {
//
//                         AppRouter.router.push('/contractDetailScreen');
//
//                       },
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: MainButton(
//                       btn_title: JText.sendMessage,
//                       btn_radius: 10,
//                       btn_color: Colors.transparent,
//                       btn_boarder_color: isDark
//                           ? JAppColors.darkGray100
//                           : JAppColors.primary,
//                       title_color: isDark
//                           ? JAppColors.darkGray100
//                           : JAppColors.primary,
//                       text_fontweight: FontWeight.w600,
//                       image_value: false,
//                       onTap: () {},
//                       text_size: JSizes.fontSizeMd,
//                     ),
//                   ),
//                 ],
//               ),
//
//
//               const SizedBox(height: 20),
//               Center(
//                 child: Container(
//                   width: 60,
//                   height: 4,
//                   decoration: BoxDecoration(
//                     color: Colors.black,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSectionContainer({required Widget child}) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade50,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: child,
//     );
//   }
//
//   Widget _buildFileAttachment() {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: isDark
//             ? JAppColors.darkGray100
//             : JAppColors.primary,,
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: Colors.grey.shade200),
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//             decoration: BoxDecoration(
//               color: Colors.purple,
//               borderRadius: BorderRadius.circular(4),
//             ),
//             child: const Text(
//               'PNG',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 12,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: const [
//                 Text(
//                   'Design.png',
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 Text(
//                   '200 KB',
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Colors.black54,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           IconButton(
//             icon: const Icon(Icons.download, color: Colors.black),
//             onPressed: () {},
//             padding: EdgeInsets.zero,
//             constraints: const BoxConstraints(),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/features/users/contract/contract_detail/widgets/activity_log_section.dart';
import 'package:job_contracts/presentation/features/users/contract/contract_detail/widgets/conractor_profile.dart';
import 'package:job_contracts/presentation/features/users/contract/contract_detail/widgets/contract_description_section.dart';
import 'package:job_contracts/presentation/features/users/contract/contract_detail/widgets/contract_detail_section.dart';
import 'package:job_contracts/presentation/features/users/contract/contract_detail/widgets/file_attachment.dart';

import '../../../../../utils/common_widgets/appbar.dart';
import '../../../../../utils/common_widgets/back_circle.dart';
import '../../../../../utils/common_widgets/bottom_indicator.dart';
import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../routes/app_routes.dart';

class ContractDetailScreen extends StatelessWidget {
  const ContractDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      backgroundColor: isDark ? JAppColors.darkGray800 : Colors.white,

      bottomNavigationBar:               Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: SizedBox(
          height: 50,
          child: Row(
            children: [
              Expanded(
                child: MainButton(
                  btn_title: JText.submitWork,
                  btn_radius: 10,
                  btn_color: JAppColors.main,
                  btn_boarder_color: const Color(0xff7030F1),
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
                  btn_title: JText.sendMessage,
                  btn_radius: 10,
                  btn_color: Colors.transparent,
                  btn_boarder_color: isDark
                      ? JAppColors.darkGray100
                      : JAppColors.primary,
                  title_color: isDark
                      ? JAppColors.darkGray100
                      : JAppColors.primary,
                  text_fontweight: FontWeight.w600,
                  image_value: false,
                  onTap: () {},
                  text_size: JSizes.fontSizeMd,
                ),
              ),
            ],
          ),
        ),
      ),

      appBar: JAppbar(
        title: Text(
          JText.appBarTitle,
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
            fontSize: 20.0,
            weight: FontWeight.w600,
          ),
        ),
        leadingIcon: BackCircle(
          isDark: isDark,
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Contract description section


              const SizedBox(height: 12),

              ContractDescription(isDark: isDark),

              const SizedBox(height: 16),

              // Activity log section
            ActivityLogSection(isDark: isDark),


              const SizedBox(height: 16),

              // Contract details section with salary and contractor info

              ContractDetailsSection(isDark: isDark),

              const SizedBox(height: 24),



              // Bottom indicator
            ],
          ),
        ),
      ),
    );
  }
}

// Separate widgets moved to contract_detail_widgets.dart






