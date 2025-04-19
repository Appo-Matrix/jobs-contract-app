import 'package:flutter/cupertino.dart';

import '../../../../../../utils/constants/app_text_style.dart';
import '../../../../../../utils/constants/text_strings.dart';

class ProfileHeader extends StatelessWidget {
  final Color textColor;
  const ProfileHeader({super.key, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Text(
      JText.profileDetails,
      style: AppTextStyle.dmSans(
        color: textColor,
        fontSize: 24.0,
        weight: FontWeight.w600,
      ),
    );
  }
}
