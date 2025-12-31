import 'package:flutter/material.dart';

import '../../../../../../utils/common_widgets/main_button.dart';
import '../../../../../../utils/constants/app_text_style.dart';
import '../../../../../../utils/constants/colors.dart';
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
  final String? description;
  final String? location;
  final VoidCallback? onSubmitWorkPressed;
  final VoidCallback? onSendMessagePressed;
  final VoidCallback? onCardTap;
  final VoidCallback? onResumePressed;
  final VoidCallback? onViewDetailsPressed;

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
    this.description,
    this.location,
    this.onSubmitWorkPressed,
    this.onSendMessagePressed,
    this.onCardTap,
    this.onResumePressed,
    this.onViewDetailsPressed,
  });

  @override
  State<ContractCard> createState() => _ContractCardState();
}

class _ContractCardState extends State<ContractCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    final containerColor = isDark ? JAppColors.darkGray800 : JAppColors.white;
    final borderColor = _getStatusBorderColor(widget.status);

    return GestureDetector(
      onTap: widget.onCardTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: borderColor ??
                (isDark ? JAppColors.darkGray700 : JAppColors.lightGray300),
            width: borderColor != null ? 2 : 1,
          ),
          boxShadow: isDark
              ? null
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Section - Profile, Name, Location, Status Button

            EmployerProfileWidget(
              employerName: widget.name,
              location: widget.location ?? 'United States',
              employerImage: widget.contractorImage,
            ),
            const SizedBox(height: 20),

            // Job Title
            Text(
              widget.jobTitle,
              style: AppTextStyle.dmSans(
                fontSize: 18.0,
                weight: FontWeight.w700,
                color:
                    isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
              ),
            ),
            const SizedBox(height: 12),

            // Description with "See More" functionality
            AnimatedCrossFade(
              firstChild: Text(
                widget.description ??
                    'We are seeking a highly motivated and skilled Architects & Construction Specialist to join our dynamic team. The ideal candidate will be...',
                style: AppTextStyle.dmSans(
                  fontSize: 14.0,
                  color:
                      isDark ? JAppColors.darkGray300 : JAppColors.lightGray700,
                  height: 1.5,
                  weight: FontWeight.w400,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              secondChild: Text(
                widget.description ??
                    'We are seeking a highly motivated and skilled Architects & Construction Specialist to join our dynamic team. The ideal candidate will be responsible for designing innovative architectural solutions, overseeing construction projects, and ensuring compliance with building codes and regulations.',
                style: AppTextStyle.dmSans(
                  fontSize: 14.0,
                  color:
                      isDark ? JAppColors.darkGray300 : JAppColors.lightGray700,
                  height: 1.5,
                  weight: FontWeight.w400,
                ),
              ),
              crossFadeState: _isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            ),

            // See More/Less Button
            GestureDetector(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  _isExpanded ? "See Less" : "See More",
                  style: AppTextStyle.dmSans(
                    fontSize: 14.0,
                    weight: FontWeight.w600,
                    color: JAppColors.primary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Job Type Badge and Salary
            Row(
              children: [
                // Job Type Badge (Hybrid)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: JAppColors.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    widget.jobType,
                    style: AppTextStyle.dmSans(
                      fontSize: 12.0,
                      weight: FontWeight.w600,
                      color: JAppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Salary
                Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: JAppColors.success600.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'Salary: ${widget.salary}',
                      style: AppTextStyle.dmSans(
                        fontSize: 13.0,
                        weight: FontWeight.w600,
                        color: JAppColors.success600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Bottom Row - Category and Job Duration
            Row(
              children: [
                // Category
                _buildIconChip(
                  Icons.business_center_outlined,
                  widget.category,
                  isDark,
                ),
                const SizedBox(width: 12),
                // Job Duration
                _buildIconChip(
                  Icons.schedule,
                  widget.duration,
                  isDark,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Date
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 14,
                  color:
                      isDark ? JAppColors.darkGray400 : JAppColors.lightGray600,
                ),
                const SizedBox(width: 6),
                Text(
                  widget.dateRange,
                  style: AppTextStyle.dmSans(
                    fontSize: 13.0,
                    color: isDark
                        ? JAppColors.darkGray400
                        : JAppColors.lightGray600,
                    weight: FontWeight.w400,
                  ),
                ),
              ],
            ),

            // Action buttons based on status
            _buildActionButtons(isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusButton(String status, bool isDark) {
    final statusInfo = _getStatusInfo(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: statusInfo['color'],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status,
        style: AppTextStyle.dmSans(
          fontSize: 12.0,
          weight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  Color? _getStatusBorderColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return null; // No special border for active
      case 'completed':
        return null; // No special border
      case 'paused':
        return Colors.orange.withValues(alpha: 0.5);
      case 'cancelled':
        return JAppColors.error500.withValues(alpha: 0.5);
      default:
        return null;
    }
  }

  Map<String, dynamic> _getStatusInfo(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return {'color': JAppColors.primary, 'label': 'Submit Work'};
      case 'completed':
        return {'color': JAppColors.success600, 'label': 'Completed with 5⭐'};
      case 'paused':
        return {'color': Colors.orange, 'label': 'Paused'};
      case 'cancelled':
        return {'color': JAppColors.error600, 'label': 'Cancelled'};
      case 'pending':
        return {'color': Colors.amber, 'label': 'Pending'};
      case 'under review':
        return {'color': Colors.purple, 'label': 'Under Review'};
      default:
        return {'color': JAppColors.lightGray600, 'label': status};
    }
  }

  Widget _buildActionButtons(bool isDark) {
    final status = widget.status.toLowerCase();

    // Active contracts - Show both "Submit Work" and "View Details" buttons
    if (status == 'active') {
      return Column(
        children: [
          const SizedBox(height: 16),
          // Primary Action - Submit Work
          MainButton(
            btn_title: 'Submit Work',
            onTap: widget.onSubmitWorkPressed,
            prefixIcon: Icons.upload_file,
            prefixIconSize: 18,
            buttonType: MainButtonType.primary,
            btn_color: JAppColors.primary,
            title_color: Colors.white,
            text_fontweight: FontWeight.w600,
            text_size: 14.0,
            height: 48,
            width: double.infinity,
            btn_radius: 4,
          ),
          const SizedBox(height: 8),
          // Secondary Action - View Details
          MainButton(
            btn_title: 'View Contract Details',
            onTap: widget.onViewDetailsPressed ?? widget.onCardTap,
            prefixIcon: Icons.visibility,
            prefixIconSize: 18,
            buttonType: MainButtonType.outlined,
            btn_border_color: JAppColors.primary,
            title_color: JAppColors.primary,
            text_fontweight: FontWeight.w600,
            text_size: 14.0,
            height: 48,
            width: double.infinity,
            btn_radius: 4,
          ),
        ],
      );
    }

    // Completed contracts - Show "View Completion Report" button
    if (status == 'completed') {
      return Column(
        children: [
          const SizedBox(height: 16),
          MainButton(
            btn_title: 'View Completion Report',
            onTap: widget.onViewDetailsPressed ?? widget.onCardTap,
            prefixIcon: Icons.check_circle_outline,
            prefixIconSize: 18,
            buttonType: MainButtonType.outlined,
            btn_border_color: JAppColors.success600,
            title_color: JAppColors.success600,
            text_fontweight: FontWeight.w600,
            text_size: 14.0,
            height: 48,
            width: double.infinity,
            btn_radius: 4,
          ),
        ],
      );
    }

    // Paused contracts - Show "View Details" button only (view-only)
    if (status == 'paused') {
      return Column(
        children: [
          const SizedBox(height: 16),
          MainButton(
            btn_title: 'View Paused Contract',
            onTap: widget.onViewDetailsPressed ?? widget.onCardTap,
            prefixIcon: Icons.visibility,
            prefixIconSize: 18,
            buttonType: MainButtonType.outlined,
            btn_border_color: Colors.orange,
            title_color: Colors.orange,
            text_fontweight: FontWeight.w600,
            text_size: 14.0,
            height: 48,
            width: double.infinity,
            btn_radius: 4,
          ),
        ],
      );
    }

    // Cancelled contracts - Show "View Cancellation Details" button
    if (status == 'cancelled') {
      return Column(
        children: [
          const SizedBox(height: 16),
          MainButton(
            btn_title: 'View Cancellation Details',
            onTap: widget.onViewDetailsPressed ?? widget.onCardTap,
            prefixIcon: Icons.cancel_outlined,
            prefixIconSize: 18,
            buttonType: MainButtonType.outlined,
            btn_border_color: JAppColors.error600,
            title_color: JAppColors.error600,
            text_fontweight: FontWeight.w600,
            text_size: 14.0,
            height: 48,
            width: double.infinity,
            btn_radius: 4,
          ),
        ],
      );
    }

    // Pending - Show "View Pending Contract" button
    if (status == 'pending') {
      return Column(
        children: [
          const SizedBox(height: 16),
          MainButton(
            btn_title: 'View Pending Contract',
            onTap: widget.onViewDetailsPressed ?? widget.onCardTap,
            prefixIcon: Icons.hourglass_empty,
            prefixIconSize: 18,
            buttonType: MainButtonType.outlined,
            btn_border_color: Colors.amber.shade700,
            title_color: Colors.amber.shade700,
            text_fontweight: FontWeight.w600,
            text_size: 14.0,
            height: 48,
            width: double.infinity,
            btn_radius: 10,
          ),
        ],
      );
    }

    // Under Review - Show "Check Review Status" button
    if (status == 'under review') {
      return Column(
        children: [
          const SizedBox(height: 16),
          MainButton(
            btn_title: 'Check Review Status',
            onTap: widget.onViewDetailsPressed ?? widget.onCardTap,
            prefixIcon: Icons.rate_review,
            prefixIconSize: 18,
            buttonType: MainButtonType.outlined,
            btn_border_color: Colors.purple,
            title_color: Colors.purple,
            text_fontweight: FontWeight.w600,
            text_size: 14.0,
            height: 48,
            width: double.infinity,
            btn_radius: 10,
          ),
        ],
      );
    }

    // Default - No action buttons
    return const SizedBox.shrink();
  }


  Widget _buildIconChip(IconData icon, String value, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isDark
            ? JAppColors.darkGray700.withValues(alpha: 0.5)
            : JAppColors.lightGray200,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDark ? JAppColors.darkGray600 : JAppColors.lightGray300,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: isDark ? JAppColors.darkGray300 : JAppColors.lightGray700,
          ),
          const SizedBox(width: 6),
          Text(
            value,
            style: AppTextStyle.dmSans(
              fontSize: 13.0,
              color: isDark ? JAppColors.darkGray200 : JAppColors.lightGray800,
              weight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
