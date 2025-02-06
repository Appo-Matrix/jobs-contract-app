import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';
import '../../../../../utils/common_widgets/appbar.dart';
import '../../../../../utils/common_widgets/circular_shape.dart';
import '../../../../../utils/common_widgets/search_bar_widget.dart';
import '../../../../../utils/common_widgets/text_field_widget.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/device/device_utility.dart';

class AddSkillsScreen extends StatelessWidget {
  final List<String> items = [
    "Graphic Design",
    "Graphic Thinking",
    "UI/UX Design",
    "Adobe InDesign",
    "Web Design",
    "User Interface Design",
    "Product Design"
  ];
  AddSkillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      appBar: JAppbar(
        title: Text(
          JText.addSkill,
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
            search_bar_widget(
              isDark: isDark,
              prefixIcon: Image.asset('assets/icons/search_icon.png',),
              suffixFixIcon: Image.asset('assets/icons/cancel_icon.png', height: 10,width: 10,),
              title: 'Design',
              color: Colors.red,
              textColor: Colors.black,
              boarderRadiusColor: Colors.yellow,
              boarderRadius: 40,
            ),
            SizedBox(height: 42),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 34.0),
                    child: Text(items[index], style: AppTextStyle.dmSans(
                      color: isDark? JAppColors.lightGray500 : JAppColors.darkGray500,
                      fontSize: JSizes.fontSizeLg,
                      weight: FontWeight.w400,
                    ),),
                  );
                },
              ),
            )

          ],
        ),
      ),
    );
  }
}
