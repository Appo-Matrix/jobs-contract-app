
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:job_contracts/presentation/features/users/contract/tab_screen/active_page_contract.dart';
import 'package:job_contracts/presentation/features/users/contract/tab_screen/cancelled_page_contract.dart';
import 'package:job_contracts/presentation/features/users/contract/tab_screen/complete_contract_page.dart';
import 'package:job_contracts/presentation/features/users/contract/tab_screen/paused_contract_page.dart';
import 'package:job_contracts/utils/constants/app_text_style.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import 'package:job_contracts/utils/device/device_utility.dart';
import 'package:provider/provider.dart';

import '../../../../utils/common_widgets/appbar.dart';
import '../../../../utils/common_widgets/circular_avatar.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../routes/app_routes.dart';
import '../../theme_controller/ThemeNotifier.dart';
import '../home/drawer/widgets/drawer_item.dart';

class ContractsScreen extends StatefulWidget {
  const ContractsScreen({super.key});

  @override
  State<ContractsScreen> createState() => _ContractsScreenState();
}

class _ContractsScreenState extends State<ContractsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // final tabs = ['Active', 'Completed', 'Paused', 'Cancelled', 'Pending', 'Under Review'];

  final tabs = [
    'Active',
    'Completed',
    'Paused',
    'Cancelled',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
      key: _scaffoldKey,
      drawer: _buildNavigationDrawer(context, isDark),
      appBar: JAppbar(

        title: Text(JText.allContract,                style: AppTextStyle.dmSans(
          fontSize: 18.0,
          weight: FontWeight.bold,
          color:
          isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
        ),
        ),
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
      ),      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? JAppColors.darkGray700 : Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  SvgPicture.asset(
                    JImages.search,
                    width: 20,
                    height: 20,
                    colorFilter: ColorFilter.mode(
                      isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search Contracts',
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintStyle: TextStyle(
                            color:
                                isDark ? JAppColors.lightGray100 : Colors.grey),
                      ),
                      style: TextStyle(
                          color: isDark ? Colors.white : Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Tab Bar with left-aligned scrollable tabs
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: 35,
              margin: const EdgeInsets.only(left: 16, right: 16),
              child: TabBar(
                dividerColor: Colors.transparent,
                controller: _tabController,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                // Explicitly set alignment to start
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: JAppColors.primary,
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.white,
                unselectedLabelColor:
                    isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                padding: const EdgeInsets.all(3),
                indicatorWeight: 0,
                labelStyle:
                AppTextStyle.dmSans(
                  fontSize: JSizes.fontSizeESm,
                  weight: FontWeight.w500,
                  color: Colors.white,
                ),
                unselectedLabelStyle: AppTextStyle.dmSans(
                  fontSize: JSizes.fontSizeESm,
                  weight: FontWeight.w500,
                  color:
                      isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                ),
                tabs: tabs.map((tab) => Tab(text: tab)).toList(),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // TabBarView
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                ActiveContractsPage(),
                CompletedContractsPage(),
                PausedContractsPage(),
                CancelledContractsPage(),
              ],
            ),
          ),
        ],
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
