import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../providers/auth_provider.dart';
import '../../providers/user_provider.dart';

class ProfileBio extends StatelessWidget {
  final bool isDark;

  const ProfileBio({
    super.key,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final bio = context.watch<AuthProvider>().currentUser?.bio ?? '';

    if (bio.isEmpty) {
      return Text(
        'Not yet added',
        style: AppTextStyle.dmSans(
          fontSize: 14.0,
          weight: FontWeight.w400,
          color: isDark ? JAppColors.darkGray500 : JAppColors.lightGray400,
        ),
      );
    }

    return Text(
      bio,
      style: AppTextStyle.dmSans(
        fontSize: 14.0,
        height: 1.5,
        weight: FontWeight.w400,
        color: isDark ? JAppColors.darkGray300 : JAppColors.lightGray600,
      ),
    );
  }
}