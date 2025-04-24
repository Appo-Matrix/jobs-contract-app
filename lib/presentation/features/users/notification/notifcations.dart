import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/features/users/notification/widgets/NotificationDialog.dart';
import 'package:job_contracts/presentation/features/users/notification/widgets/NotificationsContainer.dart';
import 'package:job_contracts/utils/constants/image_string.dart';
import 'package:job_contracts/utils/device/device_utility.dart';
import 'package:provider/provider.dart';

import '../../../../utils/common_widgets/appbar.dart';
import '../../../../utils/common_widgets/back_circle.dart';
import '../../../../utils/common_widgets/circular_avatar.dart';
import '../../../../utils/common_widgets/circular_shape.dart';
import '../../../../utils/constants/app_text_style.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../routes/app_routes.dart';
import '../../theme_controller/ThemeNotifier.dart';
import '../home/drawer/widgets/drawer_item.dart';

class NotifcationsScreen extends StatefulWidget {
  const NotifcationsScreen({super.key});

  @override
  State<NotifcationsScreen> createState() => _NotifcationsScreenState();
}

class _NotifcationsScreenState extends State<NotifcationsScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
      key: _scaffoldKey,
      drawer: _buildNavigationDrawer(context, isDark),
      appBar: JAppbar(
        leadingIcon: GestureDetector(
          onTap: () => {_scaffoldKey.currentState?.openDrawer()},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularAvatar(
              isDark: isDark,
              radius: 20,
              imageUrl: JImages.image,
              // Or use asset: true and imagePath: 'assets/images/profile1.jpg' for asset images
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert,
                color:
                isDark ? JAppColors.darkGray100 : JAppColors.darkGray800),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              NotificationsContainer(
                isDark: isDark,
                width: double.infinity,
                height: 130,
              ),
              NotificationDialog(isDark: isDark),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildNavigationDrawer(BuildContext context, bool isDark) {
    return Drawer(
      backgroundColor: isDark ? JAppColors.darkGray800 : Colors.white,
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
            title: JText.accountSetting,
            iconColor:
            isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            onTap: () {
              Navigator.pop(context);

              AppRouter.router.push('/accountSettingScreen');
              // Navigate to home
            },
          ),

          DrawerItem(
            iconPath: JImages.report,
            title: JText.financialReport,
            iconColor:
            isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            onTap: () {
              Navigator.pop(context);
              AppRouter.router.push('/financeReportScreen');

              // Navigate to profile
            },
          ),

          DrawerItem(
            iconPath: JImages.proposal,
            title: JText.proposal,
            iconColor:
            isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            onTap: () {
              Navigator.pop(context);
              AppRouter.router.push('/proposalScreen');
              // Navigate to applications
            },
          ),
          DrawerItem(
            iconPath: JImages.proposal,
            title: JText.myAds,
            iconColor:
            isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            onTap: () {
              Navigator.pop(context);
              AppRouter.router.push('/myAdsScreen');
              // Navigate to applications
            },
          ),
          DrawerItem(
            iconPath: JImages.upgrade,
            title: JText.upgrade,
            iconColor:
            isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            onTap: () {
              Navigator.pop(context);
              AppRouter.router.push('/membershipPlansScreen');
              // Navigate to applications
            },
          ),
          DrawerItem(
            iconPath: JImages.language,
            title: JText.language,
            iconColor:
            isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            onTap: () {
              Navigator.pop(context);
              AppRouter.router.push('/languageScreen');
              // Navigate to applications
            },
          ),

          DrawerItem(
            iconPath: JImages.helpsupport,
            title: JText.helpAndSupport,
            iconColor:
            isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            onTap: () {
              Navigator.pop(context);
              AppRouter.router.push('/contactSupportScreen');

              // Navigate to notifications
            },
          ),

          DrawerItem(
            iconPath: JImages.logout_icon,
            title: JText.logout,
            iconColor:
            isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            onTap: () {
              Navigator.pop(context);
              // Navigate to settings
            },
          ),

          Spacer(),
          ListTile(
            leading: Icon(
              Icons.brightness_6,
              color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            ),
            title: Text(
              JText.changeTheme,
              style: AppTextStyle.dmSans(
                fontSize: 16.0,
                weight: FontWeight.w500,
                color:
                isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              _showThemeBottomSheet(context, isDark);
            },
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
  void _showThemeBottomSheet(BuildContext context, bool isDark) {
    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? JAppColors.darkGray800 : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Choose Theme',
                style: AppTextStyle.dmSans(
                  fontSize: 18.0,
                  weight: FontWeight.bold,
                  color:
                  isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                ),
              ),
              ListTile(
                leading: Icon(Icons.light_mode, color: Colors.orange),
                title: Text('Light Theme'),
                onTap: () {
                  // Use ThemeNotifier to change the theme
                  Provider.of<ThemeNotifier>(context, listen: false)
                      .toggleTheme(false);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.dark_mode, color: Colors.blueGrey),
                title: Text('Dark Theme'),
                onTap: () {
                  // Use ThemeNotifier to change the theme
                  Provider.of<ThemeNotifier>(context, listen: false)
                      .toggleTheme(true);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.brightness_auto, color: Colors.green),
                title: Text('System Default'),
                onTap: () {
                  // Use ThemeNotifier to set the system default theme
                  Provider.of<ThemeNotifier>(context, listen: false).toggleTheme(
                      false); // System can fallback to light/dark based on system settings
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }


}
