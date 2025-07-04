import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../utils/common_widgets/EmployerProfileWidget.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_string.dart';
import '../../../../../utils/constants/sizes.dart';

class ProposalCard extends StatefulWidget {
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
  final VoidCallback? onProposalTap; // NEW

  const ProposalCard({
    super.key,
    this.jobTitle = "Architects Construction",
    this.salary = "\$20,000 - \$25,000",
    this.category = "Electrician",
    this.jobType = "Onsite",
    this.duration = "1 Month",
    this.description = "We are seeking a highly motivated and skilled Architects & Construction Specialist skilled Architects & Construction Specialist",
    this.employerName = "Amélie Laurent",
    this.location = "United States",
    this.postedTime = "1 hr ago",
    this.isVerified = false,
    this.employerImage,
    required this.isDark,
    this.onProposalTap,
  });

  @override
  State<ProposalCard> createState() => _ProposalCardState();
}

class _ProposalCardState extends State<ProposalCard> {
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
      padding: const EdgeInsets.all(14.0),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: widget.isDark
            ? null
            : [
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

          // Top Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTag(widget.jobType, accentColor),
              _buildSalaryTag(widget.salary, widget.isDark),
            ],
          ),
          const SizedBox(height: 16),

          // Job title + bookmark
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
                ),
              ),
              IconButton(
                onPressed: () => setState(() => _isSaved = !_isSaved),
                icon: Icon(
                  _isSaved ? Icons.bookmark : Icons.bookmark_border,
                  color: _isSaved ? accentColor : textColor,
                  size: 24,
                ),
              )
            ],
          ),
          const SizedBox(height: 12),

          // Icon Detail Row
          Row(
            children: [
              _buildIconDetail(Icons.category_outlined, widget.category, iconColor, textColor, widget.isDark),
              const SizedBox(width: 16),
              _buildIconDetail(Icons.access_time, widget.duration, iconColor, textColor, widget.isDark),
            ],
          ),
          const SizedBox(height: 16),

          // Description
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

          GestureDetector(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
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
                )
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Divider
          Divider(color: widget.isDark ? Colors.white12 : Colors.grey.shade300),

          const SizedBox(height: 12),
          EmployerProfileWidget(
            employerName: 'Tech Solutions Inc.',
            location: 'San Francisco, CA',
            employerImage: JImages.image, // or 'assets/images/employer1.png'
            isVerified: true,
            isDark: false,
          ),
          const SizedBox(height: 10),

          Align(
            alignment: Alignment.bottomRight,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'posted',
                  style: AppTextStyle.dmSans(
                    fontSize: 12.0,
                    color: textColor.withValues(alpha: 0.8),
                    weight: FontWeight.w500,
                  ),
                ).tr(),
                Text(
                  ' ${widget.postedTime}',

                  style: AppTextStyle.dmSans(
                    fontSize: 12.0,
                    color: textColor.withValues(alpha: 0.8),
                    weight: FontWeight.w500,
                  ),
                ).tr(),
              ],
            ),
          ),

          // Employer Info
          // Row(
          //   children: [
          //     _buildEmployerImage(),
          //     const SizedBox(width: 16),
          //     _buildEmployerDetails(iconColor, textColor),
          //   ],
          // ),

          const SizedBox(height: 10),

          // 💡 Bottom Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: widget.onProposalTap ?? () {}, // Default empty
              style: ElevatedButton.styleFrom(
                backgroundColor: JAppColors.primary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: Text(
               'viewProposal',
                style: AppTextStyle.dmSans(
                  color: Colors.white,
                  fontSize: 14.0,
                  weight: FontWeight.w600,
                ),
              ).tr(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: AppTextStyle.dmSans(
          color: color,
          fontSize: 12.0,
          weight: FontWeight.w500,
        ),

      ),
    );
  }

  Widget _buildSalaryTag(String salary, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isDark ? Colors.green.withValues(alpha: 0.2) : Colors.green.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(Icons.attach_money, size: 16, color: isDark ? Colors.green[300] : Colors.green[700]),
          const SizedBox(width: 4),

          Text(
            salary.replaceAll("\$", ""),
            style: AppTextStyle.dmSans(
              color: isDark ? (Colors.green[300] ?? Colors.green) : (Colors.green[700] ?? Colors.green),
              fontSize: 12.0,
              weight: FontWeight.w500,
            ),
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
          Icon(icon, size: 16, color: iconColor),
          const SizedBox(width: 6),
          Text(
            value,
            style: AppTextStyle.dmSans(
              fontSize: JSizes.fontSizeSm,
              color: textColor,
              weight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

}
