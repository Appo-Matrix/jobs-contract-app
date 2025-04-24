import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';

import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';

class ContractDescription extends StatefulWidget {
  final bool isDark;
  final String title;
  final String description;

  const ContractDescription({
    super.key,
    required this.isDark,
    this.title = 'Architects Construction Specialist',
    this.description = 'We are seeking a highly motivated and skilled Architects & Construction Specialist to join our dynamic team. The ideal candidate will be responsible for providing expertise in architectural planning, construction project management, and design oversight. You will collaborate with cross-functional teams to ensure projects are completed on time, within budget, and to the highest quality standards. The role requires excellent communication skills, technical knowledge, and problem-solving abilities.',
  });

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
        ).tr(),
        const SizedBox(height: 8),
        AnimatedCrossFade(
          firstChild: Text(

            widget.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle.dmSans(
              color: widget.isDark ? JAppColors.lightGray400 : JAppColors.lightGray900,
              fontSize: 14.0,
              height: 1.5,
              weight: FontWeight.w400,
            ),
          ).tr(),
          secondChild: Text(
            widget.description,
            style: AppTextStyle.dmSans(
              color: widget.isDark ? Colors.white : JAppColors.lightGray900,
              fontSize: 14.0,
              height: 1.5,

              weight: FontWeight.w400,
            ),
          ).tr(),
          crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            alignment: Alignment.centerLeft,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            _isExpanded ? 'seeLess' : 'seeMore',
            style: AppTextStyle.dmSans(
              color: JAppColors.light,
              fontSize: 16.0,
              weight: FontWeight.w400,
            ),
          ).tr(),
        ),
      ],
    );
  }
}