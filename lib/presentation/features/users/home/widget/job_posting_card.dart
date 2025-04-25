import 'package:easy_localization/easy_localization.dart';
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
  final String? employerImage;

  const JobPostingCard({
    super.key,
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
  });

  @override
  State<JobPostingCard> createState() => _JobPostingCardState();
}

class _JobPostingCardState extends State<JobPostingCard> {
  bool _isExpanded = false;
  bool _isSaved = false;

  @override
  Widget build(BuildContext context) {
    final textColor = widget.isDark ? JAppColors.lightGray300 : JAppColors.lightGray900;
    final accentColor = widget.isDark ? JAppColors.lightest : JAppColors.primary;
    final containerColor = widget.isDark ? JAppColors.backGroundDarkCard : JAppColors.lightGray100;
    final iconColor = widget.isDark ? JAppColors.lightGray100 : JAppColors.primary;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: widget.isDark ? null : [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row - Job Type Badge & Salary
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Job Type Badge (Hybrid, Remote, etc.)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: widget.isDark ? Colors.white.withValues(alpha: 0.1) : accentColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  widget.jobType,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: accentColor,
                  ),
                ).tr(),
              ),

              // Salary with styled presentation
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: widget.isDark ? Colors.green.withValues(alpha: 0.2) : Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.attach_money,
                      size: 16,
                      color: widget.isDark ? Colors.green[300] : Colors.green[700],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      widget.salary.replaceAll("\$", ""),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: widget.isDark ? Colors.green[300] : Colors.green[700],
                      ),
                    ).tr(),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Job Title Row with Save Button
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.jobTitle,
                  style: AppTextStyle.dmSans(
                    fontSize: 20.0,
                    weight: FontWeight.w700,
                    color: widget.isDark ? Colors.white : JAppColors.lightGray900,
                  ),
                ).tr(),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _isSaved = !_isSaved;
                  });
                },
                icon: Icon(
                  _isSaved ? Icons.bookmark : Icons.bookmark_border,
                  color: _isSaved ? accentColor : textColor,
                  size: 24,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              InkWell(
                onTap: () {
                  // Share functionality
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: widget.isDark ? Colors.white.withOpacity(0.1) : accentColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.share_outlined,
                    size: 20,
                    color: accentColor,
                  ),
                ),
              ),

            ],
          ),
          const SizedBox(height: 16),

          // Job Details with Icons
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildIconDetail(Icons.category_outlined, widget.category, iconColor, textColor, widget.isDark),
              const SizedBox(width: 16),
              _buildIconDetail(Icons.access_time, widget.duration, iconColor, textColor, widget.isDark),
              const SizedBox(width: 16),

            ],
          ),

          // Description Section with styled header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(height: 8),

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
                  ).tr(),
                  crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 300),
                ),
                const SizedBox(height: 6),

                // See More Button with animated text transition and better styling
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _isExpanded ? 'seeLess' : 'seeMore',
                        style: AppTextStyle.dmSans(
                          fontSize: 16.0,
                          weight: FontWeight.w600,
                          color: accentColor,
                        ),
                      ).tr(),
                      Icon(
                        _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                        size: 16,
                        color: accentColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Divider
          Divider(
            color: widget.isDark ? Colors.white.withValues(alpha: 0.1) : Colors.grey.withValues(alpha: 0.2),
            thickness: 1,
          ),

          const SizedBox(height: 16),

          // Employer section with improved layout
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Employer Avatar with verification badge
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: widget.employerImage != null
                        ? Image(
                      image: AssetImage(widget.employerImage!),
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    )
                        : Container(
                      width: 50,
                      height: 50,
                      color: widget.isDark ? Colors.grey[700] : Colors.grey[300],
                      child: Icon(
                        Icons.person,
                        size: 36,
                        color: widget.isDark ? Colors.grey[500] : Colors.grey,
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
                          color: widget.isDark ? JAppColors.backGroundDarkCard : Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: widget.isDark ? JAppColors.backGroundDarkCard : Colors.white,
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

              // Employer Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Employer Name
                    Text(
                      widget.employerName,
                      style: AppTextStyle.dmSans(
                        fontSize: 16.0,
                        weight: FontWeight.w600,
                        color: widget.isDark ? Colors.white : JAppColors.lightGray900,
                      ),
                    ).tr(),
                    const SizedBox(height: 4),

                    // Location and Posted Time
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
                        Text(
                          widget.location,
                          style: AppTextStyle.dmSans(
                            fontSize: 12.0,
                            color: textColor.withValues(alpha: 0.8),
                            weight: FontWeight.w500,
                          ),
                        ).tr(),
                        const SizedBox(width: 16),
                        Icon(
                          Icons.access_time_filled,
                          size: 14,
                          color: textColor.withValues(alpha: 0.8),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "Posted ${widget.postedTime}",
                          style: AppTextStyle.dmSans(
                            fontSize: 12.0,
                            color: textColor.withValues(alpha: 0.8),
                            weight: FontWeight.w500,
                          ),
                        ).tr(),

                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),


        ],
      ),
    );
  }

  Widget _buildIconDetail(IconData icon, String value, Color iconColor, Color textColor, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.1) : Colors.grey.withValues(alpha: 0.1),
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
}