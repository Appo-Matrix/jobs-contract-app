import 'package:flutter/cupertino.dart';

import '../../../../../../utils/constants/app_text_style.dart';
import '../../../../../../utils/constants/colors.dart';

class BulletPointWidget extends StatelessWidget {
  final String text;
  final bool isDark;

  const BulletPointWidget({
    super.key,
    required this.text,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final style = AppTextStyle.dmSans(
      color: isDark ? JAppColors.lightGray300 : JAppColors.darkGray700,
      fontSize: 14.0,
      weight: FontWeight.w400,
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: style),
          Expanded(child: Text(text, style: style)),
        ],
      ),
    );
  }
}
