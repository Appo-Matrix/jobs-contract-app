import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_contracts/utils/common_widgets/main_button.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';
import '../../../../../utils/common_widgets/appbar.dart';
import '../../../../../utils/common_widgets/circular_shape.dart';
import '../../../../../utils/common_widgets/search_bar_widget.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/device/device_utility.dart';

class ChangeAddSkillScreen extends StatelessWidget {
  final List<String> items = [
    "Graphic Design",
    "Graphic Thinking",
    "UI/UX Design",
    "Adobe InDesign",
    "Web Design",
    "User Interface Design",
    "Product Design"
  ];

  ChangeAddSkillScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      appBar: JAppbar(
        title: Text(
          " Skill (${items.length})",
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            fontSize: JSizes.fontSizeLg,
            weight: FontWeight.w600,
          ),
        ),
        leadingIcon: JCircularAvatar(
          isDark: isDark,
          radius: 50, // Modify the radius to make it larger
          child: Icon(
            CupertinoIcons.back,
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18),
        child: Column(
          children: [
            SizedBox(height: 42),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: (items.length / 3).ceil(),
                itemBuilder: (context, index) {
                  int startIndex = index * 3;
                  int endIndex = startIndex + 3;
                  List<String> rowItems = items.sublist(startIndex,
                      endIndex > items.length ? items.length : endIndex);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 34.0),
                    child: Text(
                      items[index],
                      style: AppTextStyle.dmSans(
                        color: isDark
                            ? JAppColors.lightGray500
                            : JAppColors.darkGray500,
                        fontSize: JSizes.fontSizeLg,
                        weight: FontWeight.w400,
                      ),
                    ),
                  );
                },
              ),
            ),
            Spacer(),
            MainButton(
              btn_title: 'Change',
              btn_radius: 8,
              btn_color: JAppColors.primary,
              btn_boarder_color: Colors.transparent,
              title_color: Colors.white,
              image_value: false,
            ),
          ],
        ),
      ),
    );
  }
}
