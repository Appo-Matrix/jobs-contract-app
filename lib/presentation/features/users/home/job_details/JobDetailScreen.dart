// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:job_contracts/presentation/routes/app_routes.dart';
// import 'package:job_contracts/utils/common_widgets/EmployerProfileWidget.dart';
// import 'package:job_contracts/utils/constants/image_string.dart';
// import '../../../../../utils/common_widgets/appbar.dart';
// import '../../../../../utils/common_widgets/back_circle.dart';
// import '../../../../../utils/common_widgets/main_button.dart';
// import '../../../../../utils/constants/app_text_style.dart';
// import '../../../../../utils/constants/colors.dart';
// import '../../../../../utils/constants/sizes.dart';
// import '../../../../../utils/constants/text_strings.dart';
// import '../../../../../utils/device/device_utility.dart';
//
// class JobDetailScreen extends StatelessWidget {
//   const JobDetailScreen({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final isDark = JDeviceUtils.isDarkMode(context);
//     return Scaffold(
//       appBar: JAppbar(
//         leadingIcon: Icon(Icons.arrow_back),
//         leadingOnPressed: (){
//           Navigator.pop(context);
//         },
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//
//               // Job Title
//               Text(
//                 "Architects Construction",
//                 maxLines: 3,
//                 overflow: TextOverflow.ellipsis,
//                 style: AppTextStyle.onest(
//                   color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
//                   fontSize: 18.0,
//                   weight: FontWeight.w500,
//                 ),
//               ),
//
//               const SizedBox(height: 20),
//
//               // Employer Profile
//               EmployerProfileWidget(
//                 employerName: 'Amélie Laurent',
//                 location: 'United States',
//                 employerImage: JImages.image,
//                 isVerified: true,
//                 isDark: isDark,
//               ),
//
//               const SizedBox(height: 16),
//
//               // Salary and Report section
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     children: [
//                       Text(
//                         "Salary: ",
//                         style: AppTextStyle.onest(
//                           fontSize: 14.0,
//                           weight: FontWeight.w400,
//                           color: isDark ? Colors.white : JAppColors.lightGray900,
//                         ),
//                       ),
//                       Text(
//                         "\$20,000 - \$25,000",
//                         style: AppTextStyle.onest(
//                           fontSize: 14.0,
//                           weight: FontWeight.w400,
//                           color: isDark ? Colors.white : JAppColors.lightGray900,
//                         ),
//                       ),
//                     ],
//                   ),
//
//
//                   TextButton(
//                     style: TextButton.styleFrom(
//                       side: const BorderSide(
//                         color: JAppColors.error500, // Border color
//                         width: 1.5,                 // Border width
//                       ),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8), // Optional: rounded corners
//                       ),
//                     ),
//                     onPressed: () {
//                       AppRouter.router.push('/reportJobScreen');
//                     },
//                     child: Text(
//                       "reportJob",
//                       style: AppTextStyle.onest(
//                         fontSize: 14.0,
//                         weight: FontWeight.w400,
//                         color: JAppColors.error500,
//                       ),
//                     ).tr(),
//                   )
//                 ],
//               ),
//
//               const SizedBox(height: 24),
//
//               // Job Description Header and Apply Button
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text(
//                     "jobDescription",
//                     style: AppTextStyle.onest(
//                       fontSize: 16.0,
//                       weight: FontWeight.w500,
//                       color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
//                     ),
//                   ).tr(),
//                   GestureDetector(
//                     onTap: () {
//                       AppRouter.router.push('/jobDetailsPage');
//                     },
//                     child: Container(
//                       width: MediaQuery.of(context).size.width * 0.4 - 20,
//                       height: 36,
//                       decoration: BoxDecoration(
//                         borderRadius: const BorderRadius.all(Radius.circular(12)),
//                         color: JAppColors.primary,
//                         border: Border.all(color: Colors.transparent),
//                       ),
//                       child: Center(
//                         child: Text(
//                           'applyJob',
//                           style: AppTextStyle.dmSans(
//                             color: Colors.white,
//                             fontSize: 14.0,
//                             weight: FontWeight.w500,
//                           ),
//                         ).tr(),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//
//               const SizedBox(height: 16),
//
//               // Job Description Text
//               Text(
//                 "We are seeking a highly motivated and skilled Architects & Construction Specialist to join our dynamic team. The ideal candidate will be responsible for providing expertise in architectural planning, construction project coordination, and ensuring high-quality project execution. This role involves working closely with contractors, engineers, and clients to ensure compliance with industry standards and best practices while delivering outstanding results.\n\nThe successful candidate will have extensive experience in construction management, architectural design principles, and project coordination. They should possess strong communication skills, attention to detail, and the ability to work effectively in a fast-paced environment. This position offers excellent opportunities for professional growth and development within a collaborative team setting.\n\nWe offer competitive compensation, comprehensive benefits, and the opportunity to work on exciting projects that make a real impact in the construction industry. Join our team and contribute to building exceptional structures while advancing your career in architecture and construction.",
//                 style: AppTextStyle.onest(
//                   fontSize: 14.0,
//                   height: 1.5,
//                   weight: FontWeight.w400,
//                   color: isDark ? Colors.white : JAppColors.lightGray900,
//                 ),
//               ),
//
//               const SizedBox(height: 24),
//
//               // Location Section
//               Text(
//                 "Location",
//                 style: AppTextStyle.onest(
//                   fontSize: 16.0,
//                   weight: FontWeight.w600,
//                   color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
//                 ),
//               ),
//
//               const SizedBox(height: 12),
//
//               // Map Section
//               Container(
//                 width: double.infinity,
//                 height: 200,
//                 decoration: BoxDecoration(
//                   color: isDark ? JAppColors.darkGray700 : Colors.grey.shade100,
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(
//                     color: isDark ? Colors.white.withOpacity(0.1) : Colors.grey.withOpacity(0.3),
//                     width: 1,
//                   ),
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(12),
//                   child: Stack(
//                     children: [
//                       // Placeholder for map - you can replace this with actual map widget
//                       Container(
//                         width: double.infinity,
//                         height: double.infinity,
//                         color: isDark ? JAppColors.darkGray600 : Colors.grey.shade200,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(
//                               Icons.location_on,
//                               size: 48,
//                               color: JAppColors.primary,
//                             ),
//                             const SizedBox(height: 8),
//                             Text(
//                               "United States",
//                               style: AppTextStyle.onest(
//                                 fontSize: 16.0,
//                                 weight: FontWeight.w500,
//                                 color: isDark ? Colors.white : JAppColors.lightGray900,
//                               ),
//                             ),
//                             const SizedBox(height: 4),
//                             Text(
//                               "San Francisco, CA",
//                               style: AppTextStyle.onest(
//                                 fontSize: 14.0,
//                                 weight: FontWeight.w400,
//                                 color: isDark ? JAppColors.lightGray300 : JAppColors.lightGray600,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//
//                       // Map overlay for interactivity
//                       // Positioned(
//                       //   top: 12,
//                       //   right: 12,
//                       //   child: Container(
//                       //     padding: const EdgeInsets.all(8),
//                       //     decoration: BoxDecoration(
//                       //       color: Colors.white,
//                       //       borderRadius: BorderRadius.circular(8),
//                       //       boxShadow: [
//                       //         BoxShadow(
//                       //           color: Colors.black.withOpacity(0.1),
//                       //           blurRadius: 4,
//                       //           offset: const Offset(0, 2),
//                       //         ),
//                       //       ],
//                       //     ),
//                       //     child: Icon(
//                       //       Icons.open_in_new,
//                       //       size: 16,
//                       //       color: JAppColors.primary,
//                       //     ),
//                       //   ),
//                       // ),
//                     ],
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 32),
//
//
//           MainButton(
//             onTap: (){
//               AppRouter.router.push('/jobDetailsPage');
//
//
//             },
//             btn_title: 'applyJob',
//             btn_radius: 10,
//             btn_color: JAppColors.main,
//             btn_border_color: const Color(0xff7030F1),
//             title_color: Colors.white,
//             text_fontweight: FontWeight.w600,
//             image_value: false,
//           ),
//
//               // Apply Button
//
//               const SizedBox(height: 32),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/routes/app_routes.dart';
import 'package:job_contracts/utils/constants/image_string.dart';
import '../../../../../utils/common_widgets/appbar.dart';
import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';

import '../../../../../utils/device/device_utility.dart';
import '../widget/client_history_card_widget.dart';
import '../widget/job_details_row_ridget.dart';

class JobDetailScreen extends StatelessWidget {
  const JobDetailScreen({
    super.key,
  });

  Widget _buildResponsibilityItem(String text, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Container(
              width: 4,
              height: 4,
              decoration: BoxDecoration(
                color:
                    isDark ? JAppColors.lightGray300 : JAppColors.lightGray600,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: AppTextStyle.onest(
                fontSize: 12.0,
                height: 1.5,
                weight: FontWeight.w400,
                color:
                    isDark ? JAppColors.lightGray300 : JAppColors.lightGray600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    return Scaffold(
      appBar: JAppbar(
        leadingIcon: Icon(Icons.arrow_back),
        leadingOnPressed: () {
          Navigator.pop(context);
        },
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: JAppColors.error500,
              borderRadius: BorderRadius.circular(8),
            ),
            child: GestureDetector(
              onTap: () {
                AppRouter.router.push('/reportJobScreen');
              },
              child: Text(
                'Report',
                style: AppTextStyle.dmSans(
                  fontSize: 12.0,
                  weight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 16,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Job Title
              Text(
                "Architects Construction motivated and skilled Architects & Construction Specialist ",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.onest(
                  color:
                      isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                  fontSize: 18.0,
                  weight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 16),

              // Job Description Text
              Text(
                "We are seeking a highly motivated and skilled Architects & Construction Specialist to join our dynamic team. The ideal candidate will be responsible for providing expertise in architectural planning, construction project coordination, and ensuring high-quality project execution. This role involves working closely with contractors, engineers, and clients to ensure compliance with industry standards and best practices while delivering outstanding results.",
                style: AppTextStyle.onest(
                  fontSize: 12.0,
                  height: 1.5,
                  weight: FontWeight.w400,
                  color: isDark
                      ? JAppColors.lightGray300
                      : JAppColors.lightGray600,
                ),
              ),

              const SizedBox(height: 20),

              // Responsibilities Section
              Text(
                "Responsibilities:",
                style: AppTextStyle.onest(
                  fontSize: 14.0,
                  weight: FontWeight.w600,
                  color:
                      isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                ),
              ),

              const SizedBox(height: 12),

              // Responsibilities List
              _buildResponsibilityItem(
                "Provide technical guidance on architectural designs, construction materials, and project execution.",
                isDark,
              ),
              _buildResponsibilityItem(
                "Collaborate with construction teams, engineers, and contractors to ensure project specifications are met.",
                isDark,
              ),
              _buildResponsibilityItem(
                "Review and troubleshoot construction challenges and provide effective solutions.",
                isDark,
              ),
              _buildResponsibilityItem(
                "Assist clients in project planning, design selection, and material recommendations.",
                isDark,
              ),
              _buildResponsibilityItem(
                "Ensure compliance with building codes...",
                isDark,
              ),

              const SizedBox(height: 24),

              // Map Location Section
              Text(
                "Map Location",
                style: AppTextStyle.onest(
                  fontSize: 16.0,
                  weight: FontWeight.w600,
                  color:
                      isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                ),
              ),

              const SizedBox(height: 12),

              // Map Section
              Container(
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                  color: isDark ? JAppColors.darkGray700 : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDark
                        ? Colors.white.withOpacity(0.1)
                        : Colors.grey.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    children: [
                      // Placeholder for map
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: isDark
                            ? JAppColors.darkGray600
                            : Colors.grey.shade200,
                        child: Center(
                          child: Text(
                            "Melbourne",
                            style: AppTextStyle.onest(
                              fontSize: 14.0,
                              weight: FontWeight.w500,
                              color: isDark
                                  ? Colors.white
                                  : JAppColors.lightGray900,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Client History Section
              Text(
                "Client History",
                style: AppTextStyle.onest(
                  fontSize: 16.0,
                  weight: FontWeight.w600,
                  color:
                      isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                ),
              ),

              const SizedBox(height: 16),

              // Client History Cards
              // _buildClientHistoryCard(isDark),
              ClientHistoryCardWidget(
                isDark: isDark,
                companyName: "General Construction Firms",
                minBudget: 20000,
                maxBudget: 25000,
                description:
                    "Id lacus, tincidunt libero, gravida ex dignissim. Vestibulum Sed faucibus in vitae",
                clientName: "Caitlyn King",
                clientImage: JImages.image,
                rating: 1,
              ),

              const SizedBox(height: 24),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  JobDetailsRowWidget(
                      label: "Category", value: "Residential", isDark: isDark),
                  const SizedBox(height: 12),
                  JobDetailsRowWidget(
                      label: "Job Duration", value: "2 weeks", isDark: isDark),
                  const SizedBox(height: 12),
                  JobDetailsRowWidget(
                      label: "Experience", value: "2+ Year", isDark: isDark),
                  const SizedBox(height: 12),
                  JobDetailsRowWidget(
                      label: "Salary", value: "\$3000", isDark: isDark),
                  const SizedBox(height: 12),
                  JobDetailsRowWidget(
                      label: "Work Type", value: "Hybrid", isDark: isDark),
                ],
              ),
              const SizedBox(height: 32),

              // Apply Now Button
              MainButton(
                onTap: () {
                  AppRouter.router.push('/jobDetailsPage');
                },
                btn_title: 'Apply Now',
                btn_radius: 10,
                btn_color: JAppColors.primary,
                btn_border_color: JAppColors.primary,
                title_color: Colors.white,
                text_fontweight: FontWeight.w600,
                image_value: false,
              ),

              const SizedBox(height: 16),

              // Save Button
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: JAppColors.primary, width: 1.5),
                  color: Colors.transparent,
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Save",
                        style: AppTextStyle.onest(
                          fontSize: 16.0,
                          weight: FontWeight.w600,
                          color: JAppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.favorite_border,
                        color: JAppColors.primary,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
