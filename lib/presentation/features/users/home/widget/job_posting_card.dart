import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_string.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../routes/app_routes.dart';

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
