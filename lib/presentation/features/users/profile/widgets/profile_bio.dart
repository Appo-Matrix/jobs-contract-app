import 'package:flutter/cupertino.dart';

import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';

class ProfileBio extends StatelessWidget {
  final bool isDark;

  const ProfileBio({
    Key? key,
    required this.isDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Hello, I'm Alina Abbas, a passionate Drywall Installer with 3+ years of experience in transforming construction spaces with precision and efficiency. I specialize in seamless drywall installation, finishing, and repairs, ensuring durable and aesthetically pleasing results. My expertise lies in turning complex designs into smooth, high-quality surfaces, enhancing both residential and commercial projects.",
      style: AppTextStyle.dmSans(
        fontSize: 14.0,
        height: 1.0,
        weight: FontWeight.w400,
        color: isDark ? JAppColors.darkGray300 : JAppColors.lightGray600,
      ),
    );
  }
}
