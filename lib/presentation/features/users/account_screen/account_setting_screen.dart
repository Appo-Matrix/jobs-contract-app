import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/features/users/account_screen/widgets/account_widget.dart';
import 'package:job_contracts/presentation/routes/app_routes.dart';
import 'package:job_contracts/utils/common_widgets/back_circle.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/constants/image_string.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';

import '../../../../../utils/common_widgets/appbar.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/device/device_utility.dart';
import '../home/bottom_sheet/app_bottom_sheets.dart';

class AccountSettingScreen extends StatefulWidget {
  const AccountSettingScreen({super.key});

  @override
  State<AccountSettingScreen> createState() => _AccountSettingScreenState();
}

class _AccountSettingScreenState extends State<AccountSettingScreen> {
  bool light = false;  // Track the state of the switch

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
      appBar: JAppbar(

        title: Text(
          textAlign: TextAlign.center,
          'settingsScreenTitle',
          style: AppTextStyle.onest(
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            fontSize: JSizes.fontSizeLg,
            weight: FontWeight.w600,
          ),
        ).tr(),

        leadingIcon: Icon(Icons.arrow_back),
        leadingOnPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 18, right: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 12,),
              // Account Section
              Text(
                'accountSettingText',
                style: AppTextStyle.onest(
                  color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray500,
                  fontSize: JSizes.fontSizeMd,
                  weight: FontWeight.w400,
                  height: 1.5,
                ),
              ).tr(),
              SizedBox(height: 10),
              GestureDetector(
                onTap: (){
                  AppRouter.router.push('/profileInformationScreen');
                },
                child: AccountWidgetContainer(
                  iconsImage: JImages.userIcon,
                  title: 'profileInfo',
                  subTitle: 'changeInfo',
                  child: Icon(
                    size: 20,
                    Icons.arrow_forward_ios_outlined,
                    color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                  ),
                ),
              ),
              SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  AppRouter.router.push('/ChangedPasswordScreen');
                },
                child: AccountWidgetContainer(
                  iconsImage: JImages.lock,
                  title: 'changePassword',
                  subTitle: 'changeYourPassword',
                  child: Icon(
                    size: 20,
                    Icons.arrow_forward_ios_outlined,
                    color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                  ),
                ),
              ),
              SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  AppRouter.router.push('/paymentsMethod');
                },
                child: AccountWidgetContainer(
                  iconsImage: JImages.payment,
                  title: 'paymentMethodTitle',
                  subTitle: 'addCreditTitle',
                  child: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                  ),
                ),
              ),
              // SizedBox(height: 15),
              // GestureDetector(
              //   onTap: () {
              //     AppRouter.router.push('/addressFormScreen');
              //   },
              //   child: AccountWidgetContainer(
              //     iconsImage: JImages.location,
              //     title: 'address',
              //     subTitle: 'addBusinessAddress',
              //     child: Icon(
              //       size: 20,
              //       Icons.arrow_forward_ios_outlined,
              //       color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
              //     ),
              //   ),
              // ),
              SizedBox(height: JSizes.spaceBtwItems),

              // Notification Section
              Text(
                'notifications',
                style: AppTextStyle.onest(
                  color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                  fontSize: JSizes.fontSizeLg,
                  weight: FontWeight.w600,
                  height: 1.5,
                ),
              ).tr(),
              SizedBox(height: 12),
              AccountWidgetContainer(
                iconsImage: JImages.notificationBell,
                title: 'pushNotifications',
                subTitle: 'notificationsSubTitle',
                child: SizedBox(
                  height: 30,
                  width: 60,
                  child: Switch(
                    value: light,  // Bind the switch to the `light` variable
                    activeColor: Colors.white,
                    activeTrackColor: JAppColors.primary,
                    inactiveTrackColor: JAppColors.lightGray300,
                    onChanged: (bool value) {
                      setState(() {
                        light = value;  // Update the `light` state
                      });

                      // You can add any action here that should occur when the switch state changes.
                      if (light) {
                        print("Notifications enabled");
                      } else {
                        print("Notifications disabled");
                      }
                    },
                  ),
                ),
              ),
              SizedBox(height: 15),

              // More Section
              Text(
                'theme',
                style: AppTextStyle.onest(
                  color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                  fontSize: JSizes.fontSizeLg,
                  weight: FontWeight.w600,
                  height: 1.5,
                ),
              ).tr(),
              SizedBox(height: 15),
              InkWell(
                onTap: (){

                  AppBottomSheets.showThemeBottomSheet(context, isDark);
                },
                child: AccountWidgetContainer(
                  iconsImage: JImages.nightmode,
                  title: 'changeTheme',
                  subTitle: 'changeYourTheme',
                  child: Icon(
                    size: 20,
                    Icons.arrow_forward_ios_outlined,
                    color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                  ),
                ),
              ),
              SizedBox(height: 15),

              // More Sect
              //
              // ion

              Text(
                'verification',
                style: AppTextStyle.onest(
                  color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                  fontSize: JSizes.fontSizeLg,
                  weight: FontWeight.w600,
                  height: 1.5,
                ),
              ).tr(),
              SizedBox(height: 15),
              InkWell(
                onTap: (){

                  AppRouter.router.push('/verifyProfile');

                },
                child: AccountWidgetContainer(
                  iconsImage: JImages.userIcon,
                  title: 'verifyYourAccount',
                  subTitle: 'verifyYourAccount',
                  child: Icon(
                    size: 20,
                    Icons.arrow_forward_ios_outlined,
                    color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                  ),
                ),
              ),
              SizedBox(height: 15),


              Text(
                'more',
                style: AppTextStyle.onest(
                  color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                  fontSize: JSizes.fontSizeLg,
                  weight: FontWeight.w600,
                  height: 1.5,
                ),
              ).tr(),
              SizedBox(height: 15),
              AccountWidgetContainer(
                iconsImage: JImages.star,
                title: 'rateUs',
                subTitle: 'rate',
                child: Icon(
                  size: 20,
                  Icons.arrow_forward_ios_outlined,
                  color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                ),
              ),
              SizedBox(height: 15),
              AccountWidgetContainer(
                iconsImage: JImages.userIcon,
                title: 'faq',
                subTitle: 'askQuestion',
                child: Icon(
                  size: 20,
                  Icons.arrow_forward_ios_outlined,
                  color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                ),
              ),
              SizedBox(height: 15),
              AccountWidgetContainer(
                iconsImage: JImages.logout,
                title: 'logout',
                subTitle: 'logoutConfirmation',
                child: Icon(
                  size: 20,
                  Icons.arrow_forward_ios_outlined,
                  color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
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
