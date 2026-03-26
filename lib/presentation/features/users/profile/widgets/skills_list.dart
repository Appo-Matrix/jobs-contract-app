import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../providers/skill_provider.dart';

class SkillsList extends StatelessWidget {
  final bool isDark;

  const SkillsList({
    super.key,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SkillProvider>();
    final mySkills = provider.mySkills;

    if (provider.isLoadingMine) {
      return const Center(child: CircularProgressIndicator());
    }

    if (mySkills.isEmpty) {
      return Text(
        'No skills added yet.',
        style: AppTextStyle.dmSans(
          fontSize: JSizes.fontSizeSm,
          weight: FontWeight.w400,
          color: isDark ? JAppColors.darkGray400 : JAppColors.lightGray500,
        ),
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: mySkills.map((skill) {
        return SkillChip(skill: skill.name, isDark: isDark);
      }).toList(),
    );
  }
}


class SkillChip extends StatelessWidget {
  final String skill;
  final bool isDark;

  const SkillChip({
    super.key,
    required this.skill,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
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