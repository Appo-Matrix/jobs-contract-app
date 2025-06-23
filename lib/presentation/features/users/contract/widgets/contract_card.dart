
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:job_contracts/presentation/routes/app_routes.dart';

import '../../../../../../utils/common_widgets/main_button.dart';
import '../../../../../../utils/constants/app_text_style.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/image_string.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/device/device_utility.dart';
import '../../../../../utils/common_widgets/EmployerProfileWidget.dart';

class ContractCard extends StatefulWidget {
  final String status;
  final String name;
  final String jobTitle;
  final String dateRange;
  final String salary;
  final String category;
  final String jobType;
  final String duration;
  final bool showActions;
  final bool isVerified;
  final String? contractorImage;
  final VoidCallback? onSubmitWorkPressed;
  final VoidCallback? onSendMessagePressed;

  const ContractCard({
    super.key,
    required this.status,
    required this.name,
    required this.jobTitle,
    required this.dateRange,
    required this.salary,
    required this.category,
    required this.jobType,
    required this.duration,
    required this.showActions,
    this.isVerified = true,
    this.contractorImage,
    this.onSubmitWorkPressed,
    this.onSendMessagePressed,
  });

  @override
  State<ContractCard> createState() => _ContractCardState();
}

class _ContractCardState extends State<ContractCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    final statusColor = _getStatusColor(widget.status);
    final textColor = isDark ? JAppColors.lightGray300 : JAppColors.lightGray900;
    final accentColor = isDark ? JAppColors.lightest : JAppColors.primary;
    final containerColor = isDark ? JAppColors.backGroundDarkCard : JAppColors.lightGray100;
    final iconColor = isDark ? JAppColors.lightGray100 : JAppColors.primary;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: isDark ? null : [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row - Status Badge & Salary
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Status Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  widget.status,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),

              // Salary with styled presentation
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isDark ? Colors.green.withOpacity(0.2) : Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.attach_money,
                      size: 16,
                      color: isDark ? Colors.green[300] : Colors.green[700],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      widget.salary.replaceAll("\$", ""),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.green[300] : Colors.green[700],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Job Title
          Text(
            widget.jobTitle,
            style: AppTextStyle.dmSans(
              fontSize: 20.0,
              weight: FontWeight.w700,
              color: isDark ? Colors.white : JAppColors.lightGray900,
            ),
          ),
          const SizedBox(height: 16),

          // Job Details with Icons - Wrap in SingleChildScrollView to prevent overflow
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildIconDetail(Icons.category_outlined, widget.category, iconColor, textColor, isDark),
                const SizedBox(width: 16),
                _buildIconDetail(Icons.access_time, widget.duration, iconColor, textColor, isDark),
                const SizedBox(width: 16),
                _buildIconDetail(Icons.work_outline, widget.jobType, iconColor, textColor, isDark),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Date Range
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isDark ? Colors.white.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.date_range,
                  size: 16,
                  color: iconColor,
                ),
                const SizedBox(width: 6),
                Text(
                  widget.dateRange,
                  style: AppTextStyle.dmSans(
                    fontSize: JSizes.fontSizeSm,
                    color: isDark ? Colors.white : JAppColors.lightGray900,
                    weight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Description Section (optional - you can add more details about the contract here)
          AnimatedCrossFade(
            firstChild: Container(),
            secondChild: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Contract Details",
                    style: AppTextStyle.dmSans(
                      fontSize: 16.0,
                      weight: FontWeight.w600,
                      color: isDark ? Colors.white : JAppColors.lightGray900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "This contract covers the agreed scope of work for the ${widget.category} project. The work is to be completed within ${widget.duration} from the start date. All deliverables must meet the specified requirements.",
                    style: AppTextStyle.dmSans(
                      fontSize: JSizes.fontSizeEaSm,
                      color: textColor.withValues(alpha: 0.9),
                      height: 1.5,
                      weight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),

          // See More/Less Button (if you want to include expandable content)
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _isExpanded ? "See Less" : "See Details",
                    style: AppTextStyle.dmSans(
                      fontSize: 14.0,
                      weight: FontWeight.w600,
                      color: accentColor,
                    ),
                  ),
                  Icon(
                    _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    size: 16,
                    color: accentColor,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Divider
          Divider(
            color: isDark ? Colors.white.withOpacity(0.1) : Colors.grey.withOpacity(0.2),
            thickness: 1,
          ),

          const SizedBox(height: 16),

          // Contractor section with improved layout
          EmployerProfileWidget(
            employerName: 'Tech Solutions Inc.',
            location: 'San Francisco, CA',
            employerImage: JImages.image, // or 'assets/images/employer1.png'
            isVerified: true,
            isDark: false,
          ),


          // Action buttons - Only show for Active contracts or if explicitly requested
          if (widget.showActions) ...[
            const SizedBox(height: 20),
            // Use Wrap to handle button overflow for small screens
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                SizedBox(
                  width: (MediaQuery.of(context).size.width - 76) / 2, // Calculate width to fit properly
                  child: MainButton(
                    btn_title: "Submit Work",
                    btn_radius: 10,
                    btn_color: JAppColors.main,
                    btn_boarder_color: Color(0xff7030F1),
                    title_color: Colors.white,
                    text_fontweight: FontWeight.w600,
                    image_value: false,
                    onTap: () {
                      if (widget.onSubmitWorkPressed != null) {
                        widget.onSubmitWorkPressed!();
                      } else {
                        // Default behavior if no custom handler provided
                        AppRouter.router.push('/contractDetailScreen');
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width - 76) / 2, // Calculate width to fit properly
                  child: MainButton(
                    btn_title: "Send Message",
                    btn_radius: 10,
                    btn_color: Colors.transparent,
                    btn_boarder_color: JAppColors.t,
                    title_color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                    text_fontweight: FontWeight.w600,
                    image_value: false,
                    onTap: () {
                      if (widget.onSendMessagePressed != null) {
                        widget.onSendMessagePressed!();
                      } else {
                        // Default behavior if no custom handler provided
                        print("Send Message pressed for ${widget.name}");
                        // You can add a default action here if needed
                      }
                    },
                    text_size: JSizes.fontSizeMd,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildIconDetail(IconData icon, String value, Color iconColor, Color textColor, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
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

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Active':
        return Colors.green;
      case 'Completed':
        return Colors.blue;
      case 'Paused':
        return Colors.orange;
      case 'Cancelled':
        return Colors.red;
      case 'Pending':
        return Colors.amber;
      case 'Under Review':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}