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
import 'job_detail_page.dart';

class JobDetailScreen extends StatefulWidget {
  final String? jobId;
  final Map<String, dynamic>? jobData;

  const JobDetailScreen({
    super.key,
    this.jobId,
    this.jobData,
  });

  @override
  State<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetailScreen> {
  late bool _isSaved;

  @override
  void initState() {
    super.initState();
    _isSaved = widget.jobData?['isSaved'] ?? false;
  }

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

    // Extract data from jobData or use defaults with proper type safety
    final title = widget.jobData?['title']?.toString() ?? 'Job Title';
    final description =
        widget.jobData?['description']?.toString() ?? 'No description available';

    // Safely convert responsibilities to list
    List<dynamic> responsibilities = [];
    if (widget.jobData?['responsibilities'] != null) {
      final resp = widget.jobData?['responsibilities'];
      if (resp is List) {
        responsibilities = resp;
      } else if (resp is String) {
        responsibilities = resp.isNotEmpty ? [resp] : [];
      }
    }

    final category = widget.jobData?['category']?.toString() ?? 'N/A';
    final duration = widget.jobData?['duration']?.toString() ?? 'N/A';
    final experience = widget.jobData?['experience']?.toString() ?? 'N/A';
    final salary = widget.jobData?['salary']?.toString() ?? 'N/A';
    final workType = widget.jobData?['workType']?.toString() ?? 'N/A';
    final location = widget.jobData?['location']?.toString() ?? 'Melbourne';

    // Safely convert clientHistory to list
    List<dynamic> clientHistory = [];
    if (widget.jobData?['clientHistory'] != null) {
      final history = widget.jobData?['clientHistory'];
      if (history is List) {
        clientHistory = history;
      }
    }

    // Safely convert skillsRequired to list
    List<dynamic> skillsRequired = [];
    if (widget.jobData?['skillsRequired'] != null) {
      final skills = widget.jobData?['skillsRequired'];
      if (skills is List) {
        skillsRequired = skills;
      } else if (skills is String) {
        skillsRequired = skills.isNotEmpty ? [skills] : [];
      }
    }

    return Scaffold(
      appBar: JAppbar(
        leadingIcon: const Icon(Icons.arrow_back),
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
          const SizedBox(width: 16)
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
                title,
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
                description,
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
              if (responsibilities.isNotEmpty) ...[
                Text(
                  "Responsibilities:",
                  style: AppTextStyle.onest(
                    fontSize: 14.0,
                    weight: FontWeight.w600,
                    color: isDark
                        ? JAppColors.darkGray100
                        : JAppColors.lightGray900,
                  ),
                ),
                const SizedBox(height: 12),
                ...responsibilities.map((responsibility) =>
                    _buildResponsibilityItem(
                      responsibility.toString(),
                      isDark,
                    )),
                const SizedBox(height: 24),
              ],

              // Skills Required Section
              if (skillsRequired.isNotEmpty) ...[
                Text(
                  "Skills Required:",
                  style: AppTextStyle.onest(
                    fontSize: 14.0,
                    weight: FontWeight.w600,
                    color: isDark
                        ? JAppColors.darkGray100
                        : JAppColors.lightGray900,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: skillsRequired
                      .map((skill) => Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: JAppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: JAppColors.primary,
                        width: 0.5,
                      ),
                    ),
                    child: Text(
                      skill.toString(),
                      style: AppTextStyle.onest(
                        fontSize: 11.0,
                        weight: FontWeight.w500,
                        color: JAppColors.primary,
                      ),
                    ),
                  ))
                      .toList(),
                ),
                const SizedBox(height: 24),
              ],

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
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: isDark
                            ? JAppColors.darkGray600
                            : Colors.grey.shade200,
                        child: Center(
                          child: Text(
                            location,
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
              if (clientHistory.isNotEmpty) ...[
                Text(
                  "Client History",
                  style: AppTextStyle.onest(
                    fontSize: 16.0,
                    weight: FontWeight.w600,
                    color: isDark
                        ? JAppColors.darkGray100
                        : JAppColors.lightGray900,
                  ),
                ),
                const SizedBox(height: 16),
                ...clientHistory
                    .map((client) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: ClientHistoryCardWidget(
                    isDark: isDark,
                    companyName: client['companyName'] ?? 'Company',
                    minBudget: client['minBudget'] ?? 0,
                    maxBudget: client['maxBudget'] ?? 0,
                    description: client['description'] ?? '',
                    clientName: client['clientName'] ?? 'Client',
                    clientImage: client['clientImage'] ?? JImages.image,
                    rating: client['rating'] ?? 0,
                  ),
                ))
                    .toList(),
                const SizedBox(height: 24),
              ],

              // Job Details Row
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  JobDetailsRowWidget(
                      label: "Category", value: category, isDark: isDark),
                  const SizedBox(height: 12),
                  JobDetailsRowWidget(
                      label: "Job Duration", value: duration, isDark: isDark),
                  const SizedBox(height: 12),
                  JobDetailsRowWidget(
                      label: "Experience", value: experience, isDark: isDark),
                  const SizedBox(height: 12),
                  JobDetailsRowWidget(label: "Salary", value: salary, isDark: isDark),
                  const SizedBox(height: 12),
                  JobDetailsRowWidget(
                      label: "Work Type", value: workType, isDark: isDark),
                ],
              ),
              const SizedBox(height: 32),

              // Apply Now Button
              MainButton(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => JobDetailsPage(
                        jobId: widget.jobId,
                      ),
                    ),
                  );
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
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isSaved = !_isSaved;
                  });
                },
                child: Container(
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
                          _isSaved ? "Saved" : "Save",
                          style: AppTextStyle.onest(
                            fontSize: 16.0,
                            weight: FontWeight.w600,
                            color: JAppColors.primary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          _isSaved ? Icons.favorite : Icons.favorite_border,
                          color: JAppColors.primary,
                          size: 20,
                        ),
                      ],
                    ),
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


// import 'package:flutter/material.dart';
// import 'package:job_contracts/presentation/routes/app_routes.dart';
// import 'package:job_contracts/utils/constants/image_string.dart';
// import '../../../../../utils/common_widgets/appbar.dart';
// import '../../../../../utils/common_widgets/main_button.dart';
// import '../../../../../utils/constants/app_text_style.dart';
// import '../../../../../utils/constants/colors.dart';
//
// import '../../../../../utils/device/device_utility.dart';
// import '../widget/client_history_card_widget.dart';
// import '../widget/job_details_row_ridget.dart';
//
// class JobDetailScreen extends StatelessWidget {
//   const JobDetailScreen({
//     super.key,
//   });
//
//   Widget _buildResponsibilityItem(String text, bool isDark) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 6),
//             child: Container(
//               width: 4,
//               height: 4,
//               decoration: BoxDecoration(
//                 color:
//                     isDark ? JAppColors.lightGray300 : JAppColors.lightGray600,
//                 shape: BoxShape.circle,
//               ),
//             ),
//           ),
//           const SizedBox(width: 8),
//           Expanded(
//             child: Text(
//               text,
//               style: AppTextStyle.onest(
//                 fontSize: 12.0,
//                 height: 1.5,
//                 weight: FontWeight.w400,
//                 color:
//                     isDark ? JAppColors.lightGray300 : JAppColors.lightGray600,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final isDark = JDeviceUtils.isDarkMode(context);
//     return Scaffold(
//       appBar: JAppbar(
//         leadingIcon: Icon(Icons.arrow_back),
//         leadingOnPressed: () {
//           Navigator.pop(context);
//         },
//         actions: [
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             decoration: BoxDecoration(
//               color: JAppColors.error500,
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: GestureDetector(
//               onTap: () {
//                 AppRouter.router.push('/reportJobScreen');
//               },
//               child: Text(
//                 'Report',
//                 style: AppTextStyle.dmSans(
//                   fontSize: 12.0,
//                   weight: FontWeight.w600,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(
//             width: 16,
//           )
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Job Title
//               Text(
//                 "Architects Construction motivated and skilled Architects & Construction Specialist ",
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//                 style: AppTextStyle.onest(
//                   color:
//                       isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
//                   fontSize: 18.0,
//                   weight: FontWeight.w600,
//                 ),
//               ),
//
//               const SizedBox(height: 16),
//
//               // Job Description Text
//               Text(
//                 "We are seeking a highly motivated and skilled Architects & Construction Specialist to join our dynamic team. The ideal candidate will be responsible for providing expertise in architectural planning, construction project coordination, and ensuring high-quality project execution. This role involves working closely with contractors, engineers, and clients to ensure compliance with industry standards and best practices while delivering outstanding results.",
//                 style: AppTextStyle.onest(
//                   fontSize: 12.0,
//                   height: 1.5,
//                   weight: FontWeight.w400,
//                   color: isDark
//                       ? JAppColors.lightGray300
//                       : JAppColors.lightGray600,
//                 ),
//               ),
//
//               const SizedBox(height: 20),
//
//               // Responsibilities Section
//               Text(
//                 "Responsibilities:",
//                 style: AppTextStyle.onest(
//                   fontSize: 14.0,
//                   weight: FontWeight.w600,
//                   color:
//                       isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
//                 ),
//               ),
//
//               const SizedBox(height: 12),
//
//               // Responsibilities List
//               _buildResponsibilityItem(
//                 "Provide technical guidance on architectural designs, construction materials, and project execution.",
//                 isDark,
//               ),
//               _buildResponsibilityItem(
//                 "Collaborate with construction teams, engineers, and contractors to ensure project specifications are met.",
//                 isDark,
//               ),
//               _buildResponsibilityItem(
//                 "Review and troubleshoot construction challenges and provide effective solutions.",
//                 isDark,
//               ),
//               _buildResponsibilityItem(
//                 "Assist clients in project planning, design selection, and material recommendations.",
//                 isDark,
//               ),
//               _buildResponsibilityItem(
//                 "Ensure compliance with building codes...",
//                 isDark,
//               ),
//
//               const SizedBox(height: 24),
//
//               // Map Location Section
//               Text(
//                 "Map Location",
//                 style: AppTextStyle.onest(
//                   fontSize: 16.0,
//                   weight: FontWeight.w600,
//                   color:
//                       isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
//                 ),
//               ),
//
//               const SizedBox(height: 12),
//
//               // Map Section
//               Container(
//                 width: double.infinity,
//                 height: 180,
//                 decoration: BoxDecoration(
//                   color: isDark ? JAppColors.darkGray700 : Colors.grey.shade100,
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(
//                     color: isDark
//                         ? Colors.white.withOpacity(0.1)
//                         : Colors.grey.withOpacity(0.3),
//                     width: 1,
//                   ),
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(12),
//                   child: Stack(
//                     children: [
//                       // Placeholder for map
//                       Container(
//                         width: double.infinity,
//                         height: double.infinity,
//                         color: isDark
//                             ? JAppColors.darkGray600
//                             : Colors.grey.shade200,
//                         child: Center(
//                           child: Text(
//                             "Melbourne",
//                             style: AppTextStyle.onest(
//                               fontSize: 14.0,
//                               weight: FontWeight.w500,
//                               color: isDark
//                                   ? Colors.white
//                                   : JAppColors.lightGray900,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 24),
//
//               // Client History Section
//               Text(
//                 "Client History",
//                 style: AppTextStyle.onest(
//                   fontSize: 16.0,
//                   weight: FontWeight.w600,
//                   color:
//                       isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
//                 ),
//               ),
//
//               const SizedBox(height: 16),
//
//               // Client History Cards
//               // _buildClientHistoryCard(isDark),
//               ClientHistoryCardWidget(
//                 isDark: isDark,
//                 companyName: "General Construction Firms",
//                 minBudget: 20000,
//                 maxBudget: 25000,
//                 description:
//                     "Id lacus, tincidunt libero, gravida ex dignissim. Vestibulum Sed faucibus in vitae",
//                 clientName: "Caitlyn King",
//                 clientImage: JImages.image,
//                 rating: 1,
//               ),
//
//               const SizedBox(height: 24),
//
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   JobDetailsRowWidget(
//                       label: "Category", value: "Residential", isDark: isDark),
//                   const SizedBox(height: 12),
//                   JobDetailsRowWidget(
//                       label: "Job Duration", value: "2 weeks", isDark: isDark),
//                   const SizedBox(height: 12),
//                   JobDetailsRowWidget(
//                       label: "Experience", value: "2+ Year", isDark: isDark),
//                   const SizedBox(height: 12),
//                   JobDetailsRowWidget(
//                       label: "Salary", value: "\$3000", isDark: isDark),
//                   const SizedBox(height: 12),
//                   JobDetailsRowWidget(
//                       label: "Work Type", value: "Hybrid", isDark: isDark),
//                 ],
//               ),
//               const SizedBox(height: 32),
//
//               // Apply Now Button
//               MainButton(
//                 onTap: () {
//                   AppRouter.router.push('/jobDetailsPage');
//                 },
//                 btn_title: 'Apply Now',
//                 btn_radius: 10,
//                 btn_color: JAppColors.primary,
//                 btn_border_color: JAppColors.primary,
//                 title_color: Colors.white,
//                 text_fontweight: FontWeight.w600,
//                 image_value: false,
//               ),
//
//               const SizedBox(height: 16),
//
//               // Save Button
//               Container(
//                 width: double.infinity,
//                 height: 50,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   border: Border.all(color: JAppColors.primary, width: 1.5),
//                   color: Colors.transparent,
//                 ),
//                 child: Center(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Save",
//                         style: AppTextStyle.onest(
//                           fontSize: 16.0,
//                           weight: FontWeight.w600,
//                           color: JAppColors.primary,
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       Icon(
//                         Icons.favorite_border,
//                         color: JAppColors.primary,
//                         size: 20,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 32),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
