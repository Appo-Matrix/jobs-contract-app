import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/routes/app_routes.dart';
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

class ProfileInformationScreen extends StatelessWidget {
  const ProfileInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    return Scaffold(
      backgroundColor: isDark ? JAppColors.darkGray800 : Colors.white,
      appBar: JAppbar(
        title: Text(
          JText.accountSetting,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 18, right: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: JSizes.spaceBtwInputFields,
              ),
              TextFieldWidget(
                subTitle: 'First Name',
                hintText: 'e.g john',
                subtitleColor:
                    isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
                titleColor:
                    isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
              ),
              SizedBox(height: JSizes.spaceBtwInputFields),
              TextFieldWidget(
                subTitle: 'Last Name',
                hintText: 'e.g doe',
                subtitleColor:
                    isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
                titleColor:
                    isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
              ),
              SizedBox(height: JSizes.spaceBtwInputFields),
              TextFieldWidget(
                subTitle: 'Date of Birth',
                hintText: '10 August 2004',
                subtitleColor:
                    isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
                titleColor:
                    isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
                suffixIcon: Icon(Icons.calendar_month_outlined),
              ),
              SizedBox(height: JSizes.spaceBtwInputFields),
              TextFieldWidget(
                subTitle: 'Email Address',
                hintText: 'e.g johndev@gmail.com',
                subtitleColor:
                    isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
                titleColor:
                    isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
              ),
              SizedBox(height: JSizes.spaceBtwInputFields),
              PhoneNumberWidget(),
              SizedBox(height: JSizes.spaceBtwInputFields),
              TextFieldWidget(
                subTitle: 'Education',
                hintText: 'e.g BBA',
                subtitleColor:
                    isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
                titleColor:
                    isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
                suffixIcon: Image.asset(
                  'assets/icons/edit_icon.png',
                ),
              ),
              SizedBox(height: JSizes.spaceBtwInputFields),
              TextFieldWidget(
                subTitle: 'Add Skill',
                hintText: 'e.g Electrician',
                subtitleColor:
                    isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
                titleColor:
                    isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
                suffixIcon: Image.asset(
                  'assets/icons/edit_icon.png',
                ),
              ),
              SizedBox(height: JSizes.spaceBtwInputFields),
              TextFieldWidget(
                subTitle: 'Add Resume',
                hintText: 'e.g john resume.pdf',
                subtitleColor:
                    isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
                titleColor:
                    isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
                suffixIcon: Image.asset(
                  'assets/icons/edit_icon.png',
                ),
              ),
              SizedBox(height: JSizes.spaceBtwInputFields),

              TextFieldWidget(
                subTitle: 'Add Resume',
                hintText: 'e.g john resume.pdf',
                subtitleColor:
                    isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
                titleColor:
                    isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
                suffixIcon: Image.asset(
                  'assets/icons/edit_icon.png',
                ),
              ),
              SizedBox(height: JSizes.spaceBtwInputFields),

              TextFieldWidget(
                subTitle: 'Add work experience',
                hintText: 'e.g john construction',
                subtitleColor:
                    isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
                titleColor:
                    isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
                suffixIcon: Image.asset(
                  'assets/icons/edit_icon.png',
                ),
              ),
              SizedBox(height: 25),
              MainButton(
                onTap: () {
                  AppRouter.router.push('/addExperienceScreen');
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
