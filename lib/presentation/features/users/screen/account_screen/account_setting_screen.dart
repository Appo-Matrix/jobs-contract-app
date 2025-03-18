import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/features/users/screen/account_screen/widgets/account_widget.dart';
import 'package:job_contracts/presentation/routes/app_routes.dart';
import 'package:job_contracts/utils/common_widgets/back_circle.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/constants/image_string.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';

import '../../../../../utils/common_widgets/appbar.dart';
import '../../../../../utils/common_widgets/circular_shape.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/device/device_utility.dart';

class AccountSettingScreen extends StatelessWidget {
  const AccountSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    bool light = false;
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
        leadingIcon: Padding(
          padding: const EdgeInsets.all(3.0),
          child: BackCircle(
            isDark: isDark,
            onTap: (){
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 18, right: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Account Section
              Text(
                JText.accountSettingText,
                style: AppTextStyle.dmSans(
                  color:
                      isDark ? JAppColors.darkGray100 : JAppColors.lightGray500,
                  fontSize: JSizes.fontSizeMd,
                  weight: FontWeight.w400,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(

                onTap: (){
                  AppRouter.router.push('/profileInformationScreen');


                }
                ,
                child: AccountWidgetContainer(
                  iconsImage: JImages.userIcon,
                  title: JText.profileInfo,
                  subTitle: JText.changeInfo,
                  child: Icon(
                    size: 20,
                    Icons.arrow_forward_ios_outlined,
                    color:
                        isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                  ),
                ),
              ),
              SizedBox(height: 15),
              GestureDetector(
                onTap: (){

                  AppRouter.router.push('/ChangedPasswordScreen');


                },
                child: AccountWidgetContainer(
                  iconsImage: JImages.lock,
                  title: JText.changePassword,
                  subTitle: JText.changeYourPassword,
                  child: Icon(
                    size: 20,
                    Icons.arrow_forward_ios_outlined,
                    color:
                    isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                  ),

                ),
              ),
              SizedBox(height: 15),
              GestureDetector(
                onTap: (){


                  AppRouter.router.push('/paymentsMethod');

                },
                child: AccountWidgetContainer(
                  iconsImage: JImages.payment,
                  title: JText.paymentMethodTitle,
                  subTitle: JText.addCreditTitle,
                  child: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color:
                        isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                  ),
                ),
              ),
              SizedBox(height: 15),
              GestureDetector(
                onTap: (){
                  AppRouter.router.push('/preferenceScreen');
                },
                child: AccountWidgetContainer(
                  iconsImage: JImages.preference,
                  title: JText.preferencesTitle,
                  subTitle: JText.preferencesTitleDe,
                  child: Icon(
                    size: 20,
                    Icons.arrow_forward_ios_outlined,
                    color:
                    isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                  ),
                ),
              ),
              SizedBox(height: JSizes.spaceBtwItems),

              ///Notification Section
              Text(
                JText.notifications,
                style: AppTextStyle.dmSans(
                  color:
                      isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                  fontSize: JSizes.fontSizeLg,
                  weight: FontWeight.w600,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 12),
              AccountWidgetContainer(
                iconsImage: JImages.notificationBell,
                title: JText.profileInfo,
                subTitle: JText.notificationsSubTitle,
                  child: SizedBox(
                    height: 30,
                    width: 60,
                    child: Switch(
                      value: light,
                      activeColor: Colors.white,
                      activeTrackColor: JAppColors.primary,
                      inactiveTrackColor: JAppColors.lightGray300,
                      onChanged: (bool value) {
                        // setState(() {
                        //   light = value;
                        // });
                      },
                    ),
                  )
              ),
              SizedBox(height: 15),
              AccountWidgetContainer(
                iconsImage: JImages.notificationBell,
                title: JText.notificationsSMSTitle,
                subTitle: JText.notificationsSubTitle,
                  child: SizedBox(
                    height: 30,
                    width: 60,
                    child: Switch(
                      // This bool value toggles the switch.
                      value: light,
                      activeColor: Colors.white,
                      activeTrackColor: JAppColors.primary,
                      inactiveTrackColor: JAppColors.lightGray300,
                      onChanged: (bool value) {
                        // setState(() {
                        //   light = value;
                        // });
                      },
                    ),
                  )
              ),
              SizedBox(height: 15),
              AccountWidgetContainer(
                iconsImage: JImages.notificationBell,
                title: JText.profileInfo,
                subTitle: JText.changeInfo,
                child: SizedBox(
                  height: 25,
                  width: 55,
                  child: Switch(

                    value: light,
                    activeColor: Colors.white,
                    activeTrackColor: JAppColors.primary,
                    inactiveTrackColor: JAppColors.lightGray300,
                    onChanged: (bool value) {
                      // setState(() {
                      //   light = value;
                      // });
                    },
                  ),
                )
              ),
              SizedBox(height: 12),


              ///More Section
              Text(
                JText.more,
                style: AppTextStyle.dmSans(
                  color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                  fontSize: JSizes.fontSizeLg,
                  weight: FontWeight.w600,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 15),
              AccountWidgetContainer(
                iconsImage: JImages.star,
                title: JText.rateUs,
                subTitle: JText.rate,
                child: Icon(
                  size: 20,
                  Icons.arrow_forward_ios_outlined,
                  color:
                  isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                ),
              ),
              SizedBox(height: 15),
              AccountWidgetContainer(
                iconsImage: JImages.userIcon,
                title: JText.faq,
                subTitle: JText.askQuestion,
                child: Icon(
                  size: 20,
                  Icons.arrow_forward_ios_outlined,
                  color:
                  isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                ),
              ),
              SizedBox(height: 15),
              AccountWidgetContainer(
                iconsImage: JImages.logout,
                title: JText.logout,
                subTitle: 'Are you want to logout',
                child: Icon(
                  size: 20,
                  Icons.arrow_forward_ios_outlined,
                  color:
                  isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                ),
              ),
              SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}

