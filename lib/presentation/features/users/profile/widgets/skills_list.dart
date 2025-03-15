import 'package:flutter/cupertino.dart';

import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../profile_detail.dart';



class SkillsList extends StatelessWidget {
  final bool isDark;

  const SkillsList({
    Key? key,
    required this.isDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final skills = [
      'mudding',
      'Sanding',
      'Acoustic',
      'Surface Repair',
      'Plaster',
      'Blueprint',
      'Ceiling',
      'Maintenance',
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: skills.map((skill) {
        return SkillChip(skill: skill, isDark: isDark);
      }).toList(),
    );
  }
}


class SkillChip extends StatelessWidget {
  final String skill;
  final bool isDark;

  const SkillChip({
    Key? key,
    required this.skill,
    required this.isDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      decoration: BoxDecoration(
        color: isDark ? JAppColors.darkGray700 : JAppColors.lightGray200,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        skill,
        style: AppTextStyle.dmSans(
          fontSize: JSizes.fontSizeEaSm,
          weight: FontWeight.normal,
          color: isDark ? JAppColors.darkGray300 : JAppColors.lightGray600,
        ),
      ),
    );
  }
}
