import 'package:flutter/material.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';

class ExpandableTextCardWidget extends StatefulWidget {
  final bool isDark;
  final String text;
  final int maxLines;

  const ExpandableTextCardWidget({
    super.key,
    required this.isDark,
    required this.text,
    this.maxLines = 5,
  });

  @override
  State<ExpandableTextCardWidget> createState() => _ExpandableTextCardWidgetState();
}

class _ExpandableTextCardWidgetState extends State<ExpandableTextCardWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final textStyle = AppTextStyle.dmSans(
      fontSize: 13.0,
      weight: FontWeight.w400,
      color: widget.isDark
          ? JAppColors.darkGray100.withOpacity(0.8)
          : JAppColors.darkGray800.withOpacity(0.8),
      height: 1.6,
    );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: widget.isDark ? JAppColors.darkGray700 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: widget.isDark ? JAppColors.darkGray700 : Colors.grey[300]!,
          width: 1,
        ),
        boxShadow: widget.isDark
            ? []
            : [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dear Hiring Manager,',
            style: AppTextStyle.dmSans(
              fontSize: 14.0,
              weight: FontWeight.w600,
              color: widget.isDark ? JAppColors.darkGray100 : JAppColors.darkGray800,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            widget.text,
            style: textStyle,
            maxLines: _isExpanded ? null : widget.maxLines,
            overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            child: Text(
              _isExpanded ? 'Read Less' : 'Read More',
              style: AppTextStyle.dmSans(
                fontSize: 13.0,
                weight: FontWeight.w600,
                color: JAppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
