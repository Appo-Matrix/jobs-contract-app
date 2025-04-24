import 'package:flutter/material.dart';

import '../constants/app_text_style.dart';
import '../constants/colors.dart';
import '../constants/sizes.dart';

class FilePickerContainerWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String subTitle;

  const FilePickerContainerWidget({
    super.key,
    required this.isDark,
    required this.onTap,
    required this.title,
    required this.subTitle,
  });

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 130,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: JAppColors.darkGray200,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/icons/pdf_icon.png',
                      width: 40,
                      height: 45,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: true,
                            style: AppTextStyle.dmSans(
                              color: isDark
                                  ? JAppColors.lightGray500
                                  : JAppColors.lightGray500,
                              fontSize: JSizes.fontSizeESm,
                              weight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            subTitle,
                            style: AppTextStyle.dmSans(
                              color: isDark
                                  ? JAppColors.lightGray500
                                  : JAppColors.lightGray500,
                              fontSize: JSizes.fontSizeESm,
                              weight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Image.asset(
                      'assets/icons/delete_icon.png',
                      height: 28,
                      width: 28,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Remove File',
                      style: AppTextStyle.dmSans(
                        color:
                            isDark ? JAppColors.error700 : JAppColors.error700,
                        fontSize: JSizes.fontSizeSm,
                        weight: FontWeight.w400,
                      ),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}
