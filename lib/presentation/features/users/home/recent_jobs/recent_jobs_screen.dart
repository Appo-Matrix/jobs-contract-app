
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/routes/app_routes.dart';
import 'package:job_contracts/utils/constants/image_string.dart';
import 'package:job_contracts/utils/device/device_utility.dart';

import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class RecentJobsPage extends StatelessWidget {
  const RecentJobsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final width =  MediaQuery.of(context).size.height ;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 12),
          child: Text(
            'Recently Posted Jobs',
            style: AppTextStyle.dmSans(
              fontSize: JSizes.fontSizeLg,
              weight: FontWeight.bold,
              color: isDark ? Colors.white : JAppColors.lightGray900,
            ),
          ),
        ),


        Expanded(
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return JobPostingCard(
                jobTitle: "Plumbers Construction Specialists",
                description: "Hands-on Building Tasks. Hands-on Building Tasks. Hands-on Building Tasks.Hands-on Building Tasks.Hands-on Building Tasks.",
                salary: "\$20,000 - \$25,000",
                category: "Site Inspections",

                isVerified: true, isDark: isDark,
              );
            },
          ),
        ),
      ],
    );
  }
}
class JobPostingCard extends StatelessWidget {
  final String jobTitle;
  final String salary;
  final String category;
  final String jobType;
  final String duration;
  final String description;
  final String employerName;
  final String location;
  final String postedTime;
  final bool isVerified;
  final bool isDark;
  final ImageProvider? employerImage;

  const JobPostingCard({
    Key? key,
    this.jobTitle = "Architects Construction",
    this.salary = "\$20,000 - \$25,000",
    this.category = "Electrician",
    this.jobType = "Onsite",
    this.duration = "1 Month",
    this.description = "We are seeking a highly motivated and skilled Architects & Construction Specialis skilled Architects & Construction Specialis",
    this.employerName = "Amélie Laurent",
    this.location = "United States",
    this.postedTime = "1 hr ago",
    this.isVerified = false,
    this.employerImage,
    required this.isDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define colors based on dark mode
    final textColor = isDark ? JAppColors.lightGray300 : JAppColors.lightGray900;
    final subtitleColor = isDark ? JAppColors.darkGray200 : JAppColors.lightGray700;
    final accentColor = isDark ? JAppColors.lightest  : JAppColors.primary; // Keep accent color consistent

    final dividerColor = isDark ? Colors.grey.shade700.withOpacity(0.2) : Colors.grey.shade300.withOpacity(0.2);
    final containerColor = isDark ? JAppColors.darkGray700 : JAppColors.lightGray100;

    final width = JDeviceUtils.getScreenWidth(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(9.0),
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          SizedBox(height: 12,),
          // Job Title
          Text(
            jobTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle.dmSans(
              fontSize: 18.0,
              weight: FontWeight.w600,
              color: isDark ? Colors.white : JAppColors.lightGray900,
            ),
          ),
          const SizedBox(height: 16),

          // Salary
          Row(
            children: [
              Text(
                "Salary: ",
                style: AppTextStyle.dmSans(
                  fontSize: JSizes.fontSizeSm,
                  weight: FontWeight.w600,
                  color: textColor,
                ),
              ),
              Text(
                salary,
                style: AppTextStyle.dmSans(
                  fontSize: JSizes.fontSizeSm,
                  weight: FontWeight.w600,
                  color: isDark ? Colors.white : JAppColors.lightGray900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Job Details
          Wrap(
            spacing: 20,
            runSpacing: 12,
            children: [
              _buildJobDetail("Category", category, textColor, accentColor),
              _buildJobDetail("Job Type", jobType, textColor, accentColor),
              _buildJobDetail("Job Duration", duration, textColor, accentColor),
            ],
          ),
          const SizedBox(height: 20),

          // Job Description
          Text(
            "Job Description",
            style: AppTextStyle.dmSans(
              fontSize: JSizes.fontSizeSm,
              weight: FontWeight.w600,
              color: isDark ? Colors.white : JAppColors.lightGray900,
            ),
          ),
          const SizedBox(height: 12),

          // Description Text
          Text(
            description,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: AppTextStyle.dmSans(
              fontSize: JSizes.fontSizeEaSm,
              color: textColor.withValues(alpha: 0.9),
              height: 1.5, weight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),

          // See More
          GestureDetector(
            onTap: () {
              // Implement your "See More" action here

              AppRouter.router.push('/jobDetailScreen');
            },
            child: Text(
              "See More...",
              style: AppTextStyle.dmSans(
                fontSize: JSizes.fontSizeEaSm,
                weight: FontWeight.w500,
                color: accentColor,
              ),
            ),
          ),


          SizedBox(height: 12)
,          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Employer Avatar
              ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: employerImage != null
                    ? Image(
                  image: employerImage!,
                  width: 53,
                  height: 53,
                  fit: BoxFit.cover,
                )
                    : Container(
                  width: 53,
                  height: 53,
                  color: isDark ? Colors.grey[700] : Colors.grey[300],
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: isDark ? Colors.grey[500] : Colors.grey,
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Employer Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Employer Name with Verified Badge
                    Row(
                      children: [
                        Text(
                          employerName,
                          style: AppTextStyle.dmSans(
                            fontSize: 16.0,
                            weight: FontWeight.w500,
                            color: isDark ? Colors.white : JAppColors.lightGray900,
                          ),
                        ),

                        SizedBox(height: 12,),
                        if (isVerified) ...[
                          const SizedBox(width: 8),
                          Image(
                              height: 24,
                              width: 24,
                              image: AssetImage(JImages.verify)),
                        ],
                      ],
                    ),

                    // Location
                    Row(

                      children: [
                        Icon(
                          Icons.location_on,
                          color: accentColor,
                          size: 20,
                        ),
                        Text(
                          location,
                          style: AppTextStyle.dmSans(
                            fontSize: 12.0,
                            color: textColor.withValues(alpha: 0.8),

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

          // Posted Time
          Text(
            "Posted $postedTime",
            style: AppTextStyle.dmSans(
              fontSize: 16.0,
              weight: FontWeight.w500,
              color: textColor.withValues(alpha: 0.8),

            ),
          ),

          SizedBox(height: 12,),

        ],
      ),
    );
  }

  Widget _buildJobDetail(String label, String value, Color textColor, Color accentColor) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "$label: ",
          style: AppTextStyle.dmSans(
            fontSize: JSizes.fontSizeSm,
            color: textColor, weight: FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: AppTextStyle.dmSans(
            fontSize: JSizes.fontSizeSm,
            color: accentColor, weight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

// class JobPostingCard extends StatelessWidget {
//   final String jobTitle;
//   final String salary;
//   final String category;
//   final String jobType;
//   final String duration;
//   final String description;
//   final String employerName;
//   final String location;
//   final String postedTime;
//   final bool isVerified;
//   final bool isDark;
//   final ImageProvider? employerImage;
//
//   const JobPostingCard({
//     Key? key,
//     this.jobTitle = "Architects Construction",
//     this.salary = "\$20,000 - \$25,000",
//     this.category = "Electrician",
//     this.jobType = "Onsite",
//     this.duration = "1 Month",
//     this.description = "We are seeking a highly motivated and skilled Architects & Construction Specialis",
//     this.employerName = "Amélie Laurent",
//     this.location = "United States",
//     this.postedTime = "1 hr ago",
//     this.isVerified = true,
//     this.employerImage, required this.isDark,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(9.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Job Title
//           Text(
//             jobTitle,
//             style: AppTextStyle.dmSans(
//               fontSize: JSizes.fontSizeMd,
//               weight: FontWeight.w600,
//               color:isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
//             ),
//           ),
//           const SizedBox(height: 16),
//
//           // Salary
//           Text(
//             "Salary: $salary",
//             style: const TextStyle(
//               fontSize: 26,
//               fontWeight: FontWeight.w600,
//               color: Color(0xFF24292F),
//             ),
//           ),
//           const SizedBox(height: 20),
//
//           // Job Details
//           Wrap(
//             spacing: 20,
//             runSpacing: 12,
//             children: [
//               _buildJobDetail("Category", category),
//               _buildJobDetail("Job Type", jobType),
//               _buildJobDetail("Job Duration", duration),
//             ],
//           ),
//           const SizedBox(height: 30),
//
//           // Job Description
//           const Text(
//             "Job Description",
//             style: TextStyle(
//               fontSize: 26,
//               fontWeight: FontWeight.w600,
//               color: Color(0xFF24292F),
//             ),
//           ),
//           const SizedBox(height: 12),
//
//           // Description Text
//           Text(
//             description,
//             style: const TextStyle(
//               fontSize: 18,
//               color: Color(0xFF24292F),
//               height: 1.5,
//             ),
//           ),
//           const SizedBox(height: 6),
//
//           // See More
//           GestureDetector(
//             onTap: () {
//               // Implement your "See More" action here
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(
//                   content: Text('See more details clicked'),
//                   duration: Duration(seconds: 1),
//                 ),
//               );
//             },
//             child: const Text(
//               "See More...",
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w500,
//                 color: Color(0xFF8957FF),
//               ),
//             ),
//           ),
//
//           // Divider
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 24),
//             child: Divider(
//               color: Colors.grey.withOpacity(0.2),
//               thickness: 1,
//             ),
//           ),
//
//           // Employer Info
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Employer Avatar
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(40),
//                 child: employerImage != null
//                     ? Image(
//                   image: employerImage!,
//                   width: 80,
//                   height: 80,
//                   fit: BoxFit.cover,
//                 )
//                     : Container(
//                   width: 80,
//                   height: 80,
//                   color: Colors.grey[300],
//                   child: const Icon(
//                     Icons.person,
//                     size: 40,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 16),
//
//               // Employer Details
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Employer Name with Verified Badge
//                     Row(
//                       children: [
//                         Text(
//                           employerName,
//                           style: const TextStyle(
//                             fontSize: 22,
//                             fontWeight: FontWeight.w600,
//                             color: Color(0xFF24292F),
//                           ),
//                         ),
//                         if (isVerified) ...[
//                           const SizedBox(width: 8),
//                           Container(
//                             padding: const EdgeInsets.all(2),
//                             decoration: const BoxDecoration(
//                               color: Color(0xFFF5A623),
//                               shape: BoxShape.circle,
//                             ),
//                             child: const Icon(
//                               Icons.check,
//                               color: Colors.white,
//                               size: 18,
//                             ),
//                           ),
//                         ],
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//
//                     // Location
//                     Row(
//                       children: [
//                         const Icon(
//                           Icons.location_on,
//                           color: Color(0xFF8957FF),
//                           size: 20,
//                         ),
//                         const SizedBox(width: 6),
//                         Text(
//                           location,
//                           style: const TextStyle(
//                             fontSize: 16,
//                             color: Color(0xFF24292F),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 18),
//
//           // Posted Time
//           Text(
//             "Posted $postedTime",
//             style: const TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w500,
//               color: Color(0xFF24292F),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildJobDetail(String label, String value) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Text(
//           "$label: ",
//           style: const TextStyle(
//             fontSize: 18,
//             color: Color(0xFF24292F),
//           ),
//         ),
//         Text(
//           value,
//           style: const TextStyle(
//             fontSize: 18,
//             color: Color(0xFF8957FF),
//           ),
//         ),
//       ],
//     );
//   }
// }

