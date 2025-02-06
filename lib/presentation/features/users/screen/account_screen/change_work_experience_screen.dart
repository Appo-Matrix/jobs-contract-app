import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_contracts/utils/common_widgets/main_button.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';
import '../../../../../utils/common_widgets/add_experience_des_widget.dart';
import '../../../../../utils/common_widgets/appbar.dart';
import '../../../../../utils/common_widgets/circular_shape.dart';
import '../../../../../utils/common_widgets/text_field_widget.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/device/device_utility.dart';

class ChangeWorkExperienceScreen extends StatelessWidget {
  const ChangeWorkExperienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    bool light = true;
    return Scaffold(
      appBar: JAppbar(
        title: Text(
          JText.changeWorkExperience,
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            fontSize: JSizes.fontSizeLg,
            weight: FontWeight.w600,
          ),
        ),
        leadingIcon: JCircularAvatar(
          isDark: isDark,
          radius: 20,
          // Modify the radius to make it larger
          child: Icon(
            CupertinoIcons.back,
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 18, right: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFieldWidget(
                subTitle: 'Job Title',
                hintText: 'Manager',
                subtitleColor: JAppColors.darkGray700,
              ),
              SizedBox(height: 25),
              TextFieldWidget(
                subTitle: 'Company',
                hintText: 'Appo Matrix',
                subtitleColor: JAppColors.darkGray700,
                suffixIcon: Icon(Icons.calendar_month_outlined),
              ),
              SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                    child: TextFieldWidget(
                      subTitle: 'Start Date',
                      hintText: 'Start Date',
                      subtitleColor: JAppColors.darkGray700,
                    ),
                  ),
                  SizedBox(width: 10),

                  Expanded(
                    child: TextFieldWidget(
                      subTitle: 'End Date',
                      hintText: 'End Date',
                      subtitleColor: JAppColors.darkGray700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              AddExperienceDesWidget(
                subTitle: 'Description',
                hintText: 'Write additional information here',
                subtitleColor: JAppColors.darkGray700,
              ),
              SizedBox(height: 25),

              Row(
                children: [
                  Expanded(
                    child: MainButton(
                      btn_title: 'Remove',
                      btn_radius: 10,
                      btn_color: JAppColors.error100,
                      btn_boarder_color: Colors.transparent,
                      title_color: JAppColors.error500,
                    
                      image_value: false,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: MainButton(
                      btn_title: 'Save',
                      btn_radius: 10,
                      btn_color: JAppColors.main,
                      btn_boarder_color: Colors.transparent,
                      title_color: Colors.white,
                    
                      image_value: false,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
