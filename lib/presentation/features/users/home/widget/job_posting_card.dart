import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../utils/common_widgets/EmployerProfileWidget.dart';
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
                  style: AppTextStyle.dmSans(
                    fontSize: 12.0,
                    weight: FontWeight.w500,
                    color: widget.isDark ? Colors.white : JAppColors.lightGray900,
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
          const SizedBox(height: 8),

          // Job Title Row with Save Button
          Row(
            children: [
              Expanded(
                child: Text(
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  widget.jobTitle,
                  style: AppTextStyle.dmSans(
                    fontSize: 16.0,
                    weight: FontWeight.w500,
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
                  size: 18,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              InkWell(
                onTap: () {
                  // Share functionality
                },
                child: Icon(
                  Icons.share_outlined,
                  size: 18,
                  color: accentColor,
                ),
              ),

              SizedBox(width: 9,)

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
                    maxLines: 3,
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
                          fontSize: 14.0,
                          weight: FontWeight.w400,
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
          EmployerProfileWidget(
            employerName: 'Tech Solutions Inc.',
            location: 'San Francisco, CA',
            postedTime: '2 hours ago',
            employerImage: JImages.image, // or 'assets/images/employer1.png'
            isVerified: true,
            isDark: false,
          ),
          const SizedBox(height: 10),

          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              "Posted ${widget.postedTime}",
              style: AppTextStyle.dmSans(
                fontSize: 12.0,
                color: textColor.withValues(alpha: 0.8),
                weight: FontWeight.w500,
              ),
            ).tr(),
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