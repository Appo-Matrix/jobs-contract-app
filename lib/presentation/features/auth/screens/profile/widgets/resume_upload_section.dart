import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../utils/constants/app_text_style.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/image_string.dart';
import '../../../../../../utils/constants/text_strings.dart';

class ResumeUploadSection extends StatelessWidget {
  final bool isDark;
  final Color textColor;
  final Color secondaryTextColor;

  const ResumeUploadSection({
    super.key,
    required this.isDark,
    required this.textColor,
    required this.secondaryTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          JText.uploadResume,
          style: AppTextStyle.dmSans(
            color: textColor,
            fontSize: 20.0,
            weight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          height: 150,

          decoration: BoxDecoration(
            color: isDark ? JAppColors.backGroundDarkCard : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isDark ? JAppColors.darkGray600 : JAppColors.lightGray300,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: isDark ? JAppColors.lightGray200 : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: SvgPicture.asset(
                      JImages.upload,
                      colorFilter: ColorFilter.mode(JAppColors.primary, BlendMode.srcIn),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: JText.clickToUpload,
                        style: AppTextStyle.dmSans(
                          color: isDark ? Colors.white : JAppColors.darkGray800,
                          fontSize: 16.0,
                          weight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: JText.orDragAndDrop,
                        style: AppTextStyle.dmSans(
                          color: secondaryTextColor,
                          fontSize: 16.0,
                          weight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  JText.fileFormats,
                  style: AppTextStyle.dmSans(
                    color: secondaryTextColor,
                    fontSize: 14.0,
                    weight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
