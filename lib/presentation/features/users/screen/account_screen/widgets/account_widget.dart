import 'package:flutter/material.dart';

import '../../../../../../utils/constants/app_text_style.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/constants/text_strings.dart';
import '../../../../../../utils/themes/themes.dart';

class AccountWidgetContainer extends StatelessWidget {
  final String iconsImage;
  final String title;
  final String? subTitle;
  final IconData lastIcon;

  const AccountWidgetContainer({
    super.key, required this.iconsImage, required this.title, this.subTitle, required this.lastIcon,
  });

  @override
  Widget build(BuildContext context) {
   // var DarkTheme = JAppTheme.darkTheme;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          border: Border.all(color: JAppColors.lightGray300)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  iconsImage,
                  width: 24,
                  height: 24,
                ),
                SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyle.dmSans(
                        color: JAppColors.lightGray800,
                        fontSize: JSizes.fontSizeMd,
                        weight: FontWeight.w500,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      subTitle!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: AppTextStyle.dmSans(
                        color: JAppColors.lightGray500,
                        fontSize: JSizes.fontSizeEaSm,
                        weight: FontWeight.w400,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
                //Spacer(),
                Icon(lastIcon,
                    color: JAppColors.lightGray800),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
