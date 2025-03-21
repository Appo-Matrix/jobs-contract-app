import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../utils/constants/app_text_style.dart';
import '../../../../../../utils/constants/colors.dart';

class ContractDescription extends StatefulWidget {
  final bool isDark;
  final String title;
  final String description;

  const ContractDescription({
    Key? key,
    required this.isDark,
    this.title = 'Architects Construction Specialist',
    this.description = 'We are seeking a highly motivated and skilled Architects & Construction Specialist to join our dynamic team. The ideal candidate will be responsible for providing expertise in architectural planning, construction project management, and design oversight. You will collaborate with cross-functional teams to ensure projects are completed on time, within budget, and to the highest quality standards. The role requires excellent communication skills, technical knowledge, and problem-solving abilities.',
  }) : super(key: key);

  @override
  State<ContractDescription> createState() => _ContractDescriptionState();
}

class _ContractDescriptionState extends State<ContractDescription> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: AppTextStyle.dmSans(
            color: widget.isDark ? Colors.white : JAppColors.lightGray900,
            fontSize: 16.0,
            weight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Contract Description',
          style: AppTextStyle.dmSans(
            color: widget.isDark ? Colors.white : JAppColors.lightGray900,
            fontSize: 16.0,
            weight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        AnimatedCrossFade(
          firstChild: Text(

            widget.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle.dmSans(
              color: widget.isDark ? Colors.white : JAppColors.lightGray900,
              fontSize: 14.0,
              height: 1.5,
              weight: FontWeight.w400,
            ),
          ),
          secondChild: Text(
            widget.description,
            style: AppTextStyle.dmSans(
              color: widget.isDark ? Colors.white : JAppColors.lightGray900,
              fontSize: 14.0,
              height: 1.5,

              weight: FontWeight.w400,
            ),
          ),
          crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Text(
            _isExpanded ? 'See Less' : 'See More...',
            style: AppTextStyle.dmSans(
              color: JAppColors.primary,
              fontSize: 16.0,
              weight: FontWeight.w500,
            ),
          ),
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            alignment: Alignment.centerLeft,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
      ],
    );
  }
}