import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_string.dart';
import '../../../../../utils/constants/sizes.dart';

class JobPostingCard extends StatefulWidget {
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
  State<JobPostingCard> createState() => _JobPostingCardState();
}

class _JobPostingCardState extends State<JobPostingCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final textColor = widget.isDark ? JAppColors.lightGray300 : JAppColors.lightGray900;
    final accentColor = widget.isDark ? JAppColors.lightest : JAppColors.primary;
    final containerColor = widget.isDark ? JAppColors.darkGray700 : JAppColors.lightGray100;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(9.0),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),

          // Job Title
          Text(
            widget.jobTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle.dmSans(
              fontSize: 18.0,
              weight: FontWeight.w600,
              color: widget.isDark ? Colors.white : JAppColors.lightGray900,
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
                widget.salary,
                style: AppTextStyle.dmSans(
                  fontSize: JSizes.fontSizeSm,
                  weight: FontWeight.w600,
                  color: widget.isDark ? Colors.white : JAppColors.lightGray900,
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
              _buildJobDetail("Category", widget.category, textColor, accentColor),
              _buildJobDetail("Job Type", widget.jobType, textColor, accentColor),
              _buildJobDetail("Job Duration", widget.duration, textColor, accentColor),
            ],
          ),
          const SizedBox(height: 20),

          // Job Description
          Text(
            "Job Description",
            style: AppTextStyle.dmSans(
              fontSize: JSizes.fontSizeSm,
              weight: FontWeight.w600,
              color: widget.isDark ? Colors.white : JAppColors.lightGray900,
            ),
          ),
          const SizedBox(height: 12),

          // Description Text with AnimatedCrossFade for smooth transition
          AnimatedCrossFade(
            firstChild: Text(
              widget.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle.dmSans(
                fontSize: JSizes.fontSizeEaSm,
                color: textColor.withValues(alpha: 0.9),
                height: 1.5,
                weight: FontWeight.w500,
              ),
            ),
            secondChild: Text(
              widget.description,
              style: AppTextStyle.dmSans(
                fontSize: JSizes.fontSizeEaSm,
                color: textColor.withValues(alpha: 0.9),
                height: 1.5,
                weight: FontWeight.w500,
              ),
            ),
            crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
          const SizedBox(height: 6),

          // See More Button with animated text transition
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: GestureDetector(
              key: ValueKey<bool>(_isExpanded),
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Text(
                _isExpanded ? "See Less" : "See More...",
                style: AppTextStyle.dmSans(
                  fontSize: JSizes.fontSizeEaSm,
                  weight: FontWeight.w500,
                  color: accentColor,
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Employer section
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Employer Avatar
              ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: widget.employerImage != null
                    ? Image(
                  image: widget.employerImage!,
                  width: 53,
                  height: 53,
                  fit: BoxFit.cover,
                )
                    : Container(
                  width: 53,
                  height: 53,
                  color: widget.isDark ? Colors.grey[700] : Colors.grey[300],
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: widget.isDark ? Colors.grey[500] : Colors.grey,
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
                          widget.employerName,
                          style: AppTextStyle.dmSans(
                            fontSize: 16.0,
                            weight: FontWeight.w500,
                            color: widget.isDark ? Colors.white : JAppColors.lightGray900,
                          ),
                        ),
                        if (widget.isVerified) ...[
                          const SizedBox(width: 8),
                          Image(
                            height: 24,
                            width: 24,
                            image: AssetImage(JImages.verify),
                          ),
                        ],
                      ],
                    ),

                    SizedBox(width: 12,),


                    // Location
                    Row(
                      children: [
                        SvgPicture.asset(
                          JImages.locationSvg,
                          width: 20,
                          height: 20,
                          colorFilter: ColorFilter.mode(
                            widget.isDark ? JAppColors.lightGray100 :JAppColors.darkGray800,
                            BlendMode.srcIn,

                          ),
                        ),

                        SizedBox(width: 5,),

                        Text(
                          widget.location,
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
            "Posted ${widget.postedTime}",
            style: AppTextStyle.dmSans(
              fontSize: 16.0,
              weight: FontWeight.w500,
              color: textColor.withValues(alpha: 0.8),
            ),
          ),

          const SizedBox(height: 12),
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
            color: textColor,
            weight: FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: AppTextStyle.dmSans(
            fontSize: JSizes.fontSizeSm,
            color: accentColor,
            weight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}