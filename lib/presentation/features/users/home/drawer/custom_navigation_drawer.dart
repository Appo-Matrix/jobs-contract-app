import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/features/users/home/drawer/widgets/drawer_item.dart';
import 'package:job_contracts/presentation/routes/app_routes.dart';
import 'package:job_contracts/utils/common_widgets/circular_avatar.dart';
import 'package:job_contracts/utils/constants/app_text_style.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/constants/image_string.dart';
import 'package:job_contracts/utils/constants/sizes.dart';

import '../bottom_sheet/app_bottom_sheets.dart';

class CustomNavigationDrawer extends StatelessWidget {
  final bool isDark;

  const CustomNavigationDrawer({
    super.key,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: isDark ? JAppColors.darkGray800 : Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Custom drawer header with profile in a row
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          // Close the drawer first
                          Navigator.pop(context);
                          // Navigate to profile screen
                          AppRouter.router.push('/profileScreen');
                        },
                        child: CircularAvatar(
                          isDark: isDark,
                          radius: 30,
                          imageUrl: JImages.image,
                        ),
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'John Doe',
                            style: AppTextStyle.dmSans(
                              fontSize: JSizes.fontSizeMd,
                              weight: FontWeight.w600,
                              color: isDark
                                  ? JAppColors.darkGray100
                                  : JAppColors.lightGray800,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '@johndoe',
                            style: AppTextStyle.dmSans(
                              fontSize: 14.0,
                              weight: FontWeight.w400,
                              color: isDark
                                  ? JAppColors.darkGray100
                                  : JAppColors.lightGray800,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
        
            Divider(),
            // Drawer items using the custom widget
            DrawerItem(
              iconPath: JImages.profilesetting,
              title: 'accountSetting',
              iconColor:
              isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
              onTap: () {
                Navigator.pop(context);
                AppRouter.router.push('/accountSettingScreen');
              },
            ),
        
            DrawerItem(
              iconPath: JImages.report,
              title: 'financialReport',
              iconColor:
              isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
              onTap: () {
                Navigator.pop(context);
                AppRouter.router.push('/financeReportScreen');
              },
            ),
        
            DrawerItem(
              iconPath: JImages.proposal,
              title: 'proposal',
              iconColor:
              isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
              onTap: () {
                Navigator.pop(context);
                AppRouter.router.push('/proposalScreen');
              },
            ),
        
            DrawerItem(
              iconPath: JImages.proposal,
              title: 'myAds',
              iconColor:
              isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
              onTap: () {
                Navigator.pop(context);
                AppRouter.router.push('/myAdsScreen');
              },
            ),
        
            DrawerItem(
              iconPath: JImages.upgrade,
              title: 'upgrade',
              iconColor:
              isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
              onTap: () {
                Navigator.pop(context);
                AppRouter.router.push('/membershipPlansScreen');
              },
            ),
        
            DrawerItem(
              iconPath: JImages.language,
              title: 'language',
              iconColor:
              isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
              onTap: () {
                Navigator.pop(context);
                AppRouter.router.push('/languageScreen');
              },
            ),
        
            DrawerItem(
              iconPath: JImages.helpsupport,
              title: 'helpAndSupport',
              iconColor:
              isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
              onTap: () {
                Navigator.pop(context);
                AppRouter.router.push('/contactSupportScreen');
              },
            ),
        
            DrawerItem(
              iconPath: JImages.logout_icon,
              title: 'logout',
              iconColor:
              isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
              onTap: () {
                Navigator.pop(context);
                // Add logout logic here
              },
            ),
        
        
        
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 🌗 Theme Button
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pop(context); // Close drawer
                      AppBottomSheets.showThemeBottomSheet(context, isDark);
                    },
                    icon: Icon(
                      Icons.brightness_6_outlined,
                      color: isDark
                          ? JAppColors.darkGray100
                          : JAppColors.lightGray800,
                    ),
                    label: Text(
                      'Theme',
                      style: AppTextStyle.dmSans(
                        fontSize: 14.0,
                        weight: FontWeight.w500,
                        color: isDark
                            ? JAppColors.darkGray100
                            : JAppColors.lightGray800,
                      ),
                    ),
                  ),
        
                  // 🌍 Language Button
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pop(context); // Close drawer
                      AppBottomSheets.showLanguageBottomSheet(context, isDark);
                    },
                    icon: Icon(
                      Icons.language,
                      color: isDark
                          ? JAppColors.darkGray100
                          : JAppColors.lightGray800,
                    ),
                    label: Text(
                      'Language',
                      style: AppTextStyle.dmSans(
                        fontSize: 14.0,
                        weight: FontWeight.w500,
                        color: isDark
                            ? JAppColors.darkGray100
                            : JAppColors.lightGray800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}