//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:job_contracts/presentation/routes/app_routes.dart';
// import 'package:job_contracts/utils/constants/image_string.dart';
// import 'package:job_contracts/utils/device/device_utility.dart';
//
// import '../../../../../utils/constants/app_text_style.dart';
// import '../../../../../utils/constants/colors.dart';
// import '../../../../../utils/constants/sizes.dart';
// import '../../../../../utils/constants/text_strings.dart';
// import '../bottom_sheet/FilterSelectionBottomSheet.dart';
// import '../widget/job_posting_card.dart';
//
// class RecentJobsPage extends StatefulWidget {
//   const RecentJobsPage({Key? key}) : super(key: key);
//
//   @override
//   State<RecentJobsPage> createState() => _RecentJobsPageState();
// }
//
// class _RecentJobsPageState extends State<RecentJobsPage> {
//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//
//     final width =  MediaQuery.of(context).size.height ;
//     Map<String, List<String>> selectedFilters = {};
//
//     void updateFilters(Map<String, List<String>> newFilters) {
//       setState(() {
//         selectedFilters = newFilters;
//       });
//       // Here you would typically trigger a search or filter operation
//       print('Applied filters: $selectedFilters');
//     }
//
//     void showFilterBottomSheet() async {
//       final result = await FilterSelectionBottomSheet.show(
//         context,
//         initialFilters: selectedFilters,
//       );
//
//       if (result != null) {
//         updateFilters(result);
//       }
//     }
//
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//
//           Container(
//             decoration: BoxDecoration(
//               color: isDark ? JAppColors.darkGray700 : Colors.grey[200],
//               borderRadius: BorderRadius.circular(10),
//             ),
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Row(
//               children: [
//                 SvgPicture.asset(
//                   JImages.search,
//                   width: 20,
//                   height: 20,
//                   colorFilter: ColorFilter.mode(
//                     isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
//                     BlendMode.srcIn,
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: TextField(
//                     decoration: InputDecoration(
//                       hintText: JText.searchJob,
//                       border: InputBorder.none,
//                       enabledBorder: InputBorder.none,
//                       focusedBorder: InputBorder.none,
//                       hintStyle: AppTextStyle.dmSans(
//                         fontSize: JSizes.fontSizeMd,
//                         weight: FontWeight.w400,
//                         color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray500,
//                       ),
//                     ),
//                     style: AppTextStyle.dmSans(
//                       fontSize: JSizes.fontSizeMd,
//                       weight: FontWeight.w400,
//                       color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: ()=>showFilterBottomSheet(),
//                   child: SvgPicture.asset(
//                     JImages.filters,
//                     width: 20,
//                     height: 20,
//                     colorFilter: ColorFilter.mode(
//                       isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
//                       BlendMode.srcIn,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 12,),
//
//           Text(
//             JText.recentPotJob,
//             style: AppTextStyle.dmSans(
//               fontSize: JSizes.fontSizeLg,
//               weight: FontWeight.bold,
//               color: isDark ? Colors.white : JAppColors.lightGray900,
//             ),
//           ),
//
//
//           SizedBox(height: 16,),
//
//           Expanded(
//             child: ListView.builder(
//               itemCount: 5,
//               itemBuilder: (context, index) {
//                 return JobPostingCard(
//                   jobTitle: "Plumbers Construction Specialists",
//                   description: "Hands-on Building Tasks. Hands-on Building Tasks. Hands-on Building Tasks.Hands-on Building Tasks.Hands-on Building TasksHands-on Building Tasks. Hands-on Building Tasks. Hands-on Building Tasks.Hands-on Building Tasks.Hands-on Building TasksHands-on Building Tasks. Hands-on Building Tasks. Hands-on Building Tasks.Hands-on Building Tasks.Hands-on Building Tasks.",
//                   salary: "\$20,000 - \$25,000",
//                   category: "Site Inspections",
//
//                   isVerified: true, isDark: isDark,
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:job_contracts/utils/constants/image_string.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../bottom_sheet/FilterSelectionBottomSheet.dart';
import '../widget/job_posting_card.dart';

class RecentJobsPage extends StatefulWidget {
  const RecentJobsPage({super.key});

  @override
  State<RecentJobsPage> createState() => _RecentJobsPageState();
}

class _RecentJobsPageState extends State<RecentJobsPage> {
  // Move these to class level to avoid recreation on each build
  Map<String, List<String>> selectedFilters = {};

  void updateFilters(Map<String, List<String>> newFilters) {
    setState(() {
      selectedFilters = newFilters;
    });
    // Here you would typically trigger a search or filter operation
    print('Applied filters: $selectedFilters');
  }

  void showFilterBottomSheet() async {
    final result = await FilterSelectionBottomSheet.show(
      context,
      initialFilters: selectedFilters,
    );

    if (result != null) {
      updateFilters(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final width = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: isDark ? JAppColors.darkGray700 : Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                SvgPicture.asset(
                  JImages.search,
                  width: 20,
                  height: 20,
                  colorFilter: ColorFilter.mode(
                    isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        hintText:  easy.tr('searchJob'),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintStyle: AppTextStyle.dmSans(
                        fontSize: JSizes.fontSizeMd,
                        weight: FontWeight.w400,
                        color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray500,
                      ),
                    ),
                    style: AppTextStyle.dmSans(
                      fontSize: JSizes.fontSizeMd,
                      weight: FontWeight.w400,
                      color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){showFilterBottomSheet();}, // Fixed: Direct reference to the method
                  child: SvgPicture.asset(
                    JImages.filters,
                    width: 20,
                    height: 20,
                    colorFilter: ColorFilter.mode(
                      isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          Text(
            'recentPotJob',
            style: AppTextStyle.dmSans(
              fontSize: JSizes.fontSizeLg,
              weight: FontWeight.bold,
              color: isDark ? Colors.white : JAppColors.lightGray900,
            ),
          ).tr(),

          const SizedBox(height: 16),


          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return JobPostingCard(
                  jobTitle: "Plumbers Construction Specialists",
                  description: "Hands-on Building Tasks. Hands-on Building Tasks. Hands-on Building Tasks.Hands-on Building Tasks.Hands-on Building TasksHands-on Building Tasks. Hands-on Building Tasks. Hands-on Building Tasks.Hands-on Building Tasks.Hands-on Building TasksHands-on Building Tasks. Hands-on Building Tasks. Hands-on Building Tasks.Hands-on Building Tasks.Hands-on Building Tasks.",
                  salary: "\$20,000 - \$25,000",
                  category: "Site Inspections",
                  isVerified: true,
                  isDark: isDark,employerImage: JImages.image,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}