import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_contracts/utils/common_widgets/main_button.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';

import '../../../../../utils/common_widgets/appbar.dart';
import '../../../../../utils/common_widgets/circular_shape.dart';
import '../../../../../utils/common_widgets/phone_number_widget.dart';
import '../../../../../utils/common_widgets/text_field_widget.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/device/device_utility.dart';
import 'add_experiance_screen.dart';

class ProfileInformationScreen extends StatelessWidget {
  const ProfileInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    bool light = true;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: JAppbar(
        title: Text(
          JText.profileInfo2,
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            fontSize: JSizes.fontSizeLg,
            weight: FontWeight.w600,
          ),
        ),
        leadingIcon: JCircularAvatar(
          isDark: isDark,
          radius: 40, // Modify the radius to make it larger
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
                subTitle: 'First Name',

                hintText: 'Shehla',
                subtitleColor: JAppColors.darkGray700,
              ),
              SizedBox(height: 25),
              TextFieldWidget(
                subTitle: 'Last Name',
                hintText: 'Abbas',
                subtitleColor: JAppColors.darkGray700,
              ),
              SizedBox(height: 25),
              TextFieldWidget(
                subTitle: 'Date of Birth',
                hintText: '10 August 2004',
                subtitleColor: JAppColors.darkGray700,
                suffixIcon: Icon(Icons.calendar_month_outlined),
              ),
              SizedBox(height: 25),
              TextFieldWidget(
                subTitle: 'Email Address',
                hintText: 'Shehla@gmail.com',
                subtitleColor: JAppColors.darkGray700,
              ),
              SizedBox(height: 25),
              PhoneNumberWidget(),
              SizedBox(height: 25),
              TextFieldWidget(
                subTitle: 'Education',
                hintText: 'BBA',
                subtitleColor: JAppColors.darkGray700,
                suffixIcon: Image.asset(
                  'assets/icons/edit_icon.png',
                ),
              ),
              SizedBox(height: 25),
              TextFieldWidget(
                subTitle: 'Add Skill',
                hintText: 'UIUX Design',
                subtitleColor: JAppColors.darkGray700,
                suffixIcon: Image.asset(
                  'assets/icons/edit_icon.png',
                ),
              ),
              SizedBox(height: 25),
              TextFieldWidget(
                subTitle: 'Add Resume',
                hintText: 'Shehla.UIUX Design',
                subtitleColor: JAppColors.darkGray700,
                suffixIcon: Image.asset(
                  'assets/icons/edit_icon.png',
                ),
              ),
              SizedBox(height: 25),
              MainButton(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddExperienceScreen(),));
                },
                btn_title: 'Save',
                btn_radius: 10,
                btn_color: JAppColors.main,
                btn_boarder_color: Colors.transparent,
                title_color: Colors.white,

                image_value: false,
              ),
              SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
