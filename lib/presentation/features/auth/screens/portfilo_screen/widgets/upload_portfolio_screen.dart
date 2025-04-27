import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:job_contracts/utils/constants/app_text_style.dart';
import 'package:job_contracts/utils/constants/colors.dart';

import '../../../../../../utils/constants/image_string.dart';

class UploadContainerWidget extends StatelessWidget {
  final bool isDark;
  final Color cardColor;
  final Color accentColor;
  final Color secondaryTextColor;
  final double height;
  final VoidCallback? onTap;

  const UploadContainerWidget({
    super.key,
    required this.isDark,
    required this.cardColor,
    required this.accentColor,
    required this.secondaryTextColor,
    this.height = 120,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child:
      Container(
        height: height,
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDark ? JAppColors.darkGray700 : JAppColors.lightGray300,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: SvgPicture.asset(
                    JImages.upload,
                    width: 16,
                    height: 16,
                    colorFilter: ColorFilter.mode(
                      accentColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(

                      text:  easy.tr('clickToUpload'),
                      style: AppTextStyle.dmSans(
                        color: accentColor,
                        fontSize: 14.0,
                        weight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text:  easy.tr('orDragAndDrop'),
                      style: AppTextStyle.dmSans(
                        color: secondaryTextColor,
                        fontSize: 14.0,
                        weight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'fileFormats',
                style: AppTextStyle.dmSans(
                  color: secondaryTextColor,
                  fontSize: 12.0,
                  weight: FontWeight.w400,
                ),
              ).tr(),
            ],
          ),
        ),
      ),
    );
  }
}