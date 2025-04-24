import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/features/users/add_social_account/widgets/button_widget.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';
import '../../../../utils/common_widgets/appbar.dart';
import '../../../../utils/common_widgets/circular_shape.dart';
import '../../../../utils/constants/app_text_style.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';

class AddSocialAccount extends StatefulWidget {
  const AddSocialAccount({super.key});

  @override
  State<AddSocialAccount> createState() => _AddSocialAccountState();
}

class _AddSocialAccountState extends State<AddSocialAccount> {
  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      appBar: JAppbar(
        title: Text(
          JText.addSocialAccount11s,
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            fontSize: 20.0,
            weight: FontWeight.w600,
          ),
        ),
        leadingIcon: JCircularAvatar(
          isDark: isDark,
          radius: 20, // Modify the radius to make it larger
          child: Icon(
            CupertinoIcons.back,
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
          ),
        ),
      ),
      body: Column(
        children: [


          SizedBox(height: 8,)
,          Container(height: 1,color: isDark ?  JAppColors.lightGray200 : JAppColors.grayBlue800,),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                SizedBox(height: JSizes.spaceBtwSections-2,),

                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    JText.addSocialAccount11s,
                    style: AppTextStyle.dmSans(
                      color:
                          isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                      fontSize: 20.0,
                      weight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: JSizes.spaceBtwInputFields,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    JText.addSocialAccountDesc,
                    style: AppTextStyle.dmSans(
                      color: isDark
                          ? JAppColors.darkGray100
                          : JAppColors.lightGray800.withValues(alpha: 0.5),
                      fontSize: 16.0,
                      weight: FontWeight.w400,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    JText.addSocialAccountDesc2,
                    style: AppTextStyle.dmSans(
                      color: isDark
                          ? JAppColors.darkGray100
                          : JAppColors.lightGray800.withValues(alpha: 0.5),
                      fontSize: 16.0,
                      weight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(
                  height: JSizes.spaceBtwSections,
                ),
                ButtonWidget(
                  imagePath: JImages.facebook1,
                  buttonText: JText.connectWithFacebook,
                  onPressed: () {},
                  backColor: JAppColors.darkest12,
                ),
                SizedBox(
                  height: JSizes.spaceBtwInputFields - 2,
                ),
                ButtonWidget(
                  imagePath: JImages.google1,
                  buttonText: JText.connectWithGoogle,
                  onPressed: () {},
                  backColor: JAppColors.darkest1212,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
