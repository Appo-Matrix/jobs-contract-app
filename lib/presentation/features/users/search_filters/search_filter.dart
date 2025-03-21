import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';
import '../../../../utils/common_widgets/appbar.dart';
import '../../../../utils/common_widgets/back_circle.dart';
import '../../../../utils/constants/app_text_style.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';

class SearchFilter extends StatefulWidget {
  const SearchFilter({super.key});

  @override
  State<SearchFilter> createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {
  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      backgroundColor: isDark ? JAppColors.darkGray800 : Colors.white,
      appBar: JAppbar(
        title: Text(
          JText.searchJob,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : JAppColors.lightGray900,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search bar


          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? JAppColors.darkGray700 : Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  SvgPicture.asset(
                    JImages.search,
                    width: 20,
                    height: 20,
                    colorFilter: ColorFilter.mode(
                      isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: JText.searchJob,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintStyle: AppTextStyle.dmSans(
                          fontSize: JSizes.fontSizeMd,
                          weight: FontWeight.w400,
                          color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray500,
                        ),
                      ),
                      style: AppTextStyle.dmSans(
                        fontSize: JSizes.fontSizeMd,
                        weight: FontWeight.w400,
                        color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                      ),
                    ),
                  ),
                 SvgPicture.asset(
                    JImages.filters,
                    width: 20,
                    height: 20,
                    colorFilter: ColorFilter.mode(
                      isDark
                          ? JAppColors.lightGray100
                          : JAppColors.darkGray800,
                      BlendMode.srcIn,
                    ),
                  ),


                ],
              ),
            ),
          ),

          // Tab Bar with left-aligned scrollable tabs
        ],
      ),
    );
  }
}
