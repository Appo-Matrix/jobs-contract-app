import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import '../../../../../utils/common_widgets/appbar.dart';
import '../../../../../utils/common_widgets/circular_shape.dart';
import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/device/device_utility.dart';

class ChangeAddSkillScreen extends StatefulWidget {
  const ChangeAddSkillScreen({super.key});

  @override
  State<ChangeAddSkillScreen> createState() => _ChangeAddSkillScreenState();
}

class _ChangeAddSkillScreenState extends State<ChangeAddSkillScreen> {
  final List<String> skills = [
    "Graphic Design",
    "ui/ux",
    "Design",
    "Website Design",
    "App Design",
    "UI",
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: JAppbar(
        title: Text(
          " Skill (${skills.length})",
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: skills.map((skill) {
                    return Chip(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        // Adjust the radius
                        side: BorderSide(
                            color: Colors.transparent,
                            width: 0), // Border color
                      ),
                      label: Text(
                        skill,
                        style: TextStyle(
                          fontSize: 12,
                          color: JAppColors.lightGray500,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                      backgroundColor: JAppColors.darkGray200,
                      deleteIcon: Icon(Icons.close, size: 16),
                      onDeleted: () {
                        setState(() {
                          skills.remove(skill);
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
            ),

            // 🔹 Save Button
            SizedBox(height: 20),
            Spacer(),
            MainButton(
              btn_title: 'Save',
              btn_radius: 8,
              btn_color: JAppColors.primary,
              btn_boarder_color: Colors.transparent,
              title_color: Colors.white,
              image_value: false,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
