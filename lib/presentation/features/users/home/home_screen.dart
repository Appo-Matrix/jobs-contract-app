// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:job_contracts/presentation/features/users/home/recent_jobs/recent_jobs_screen.dart';
// import 'package:job_contracts/presentation/features/users/home/saved_jobs/saved_jobs_screen.dart';
// import 'package:job_contracts/presentation/routes/app_routes.dart';
// import 'package:job_contracts/utils/common_widgets/appbar.dart';
// import 'package:job_contracts/utils/constants/image_string.dart';
// import 'package:job_contracts/utils/constants/sizes.dart';
// import 'package:job_contracts/utils/constants/text_strings.dart';
// import 'package:job_contracts/utils/device/device_utility.dart';
// import 'package:provider/provider.dart';
// import '../../../../utils/common_widgets/circular_avatar.dart';
// import '../../../../utils/constants/app_text_style.dart';
// import '../../../../utils/constants/colors.dart';
// import '../../theme_controller/ThemeNotifier.dart';
// import 'best_match_screen/best_match_screen.dart';
// import 'drawer/widgets/drawer_item.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//
//   @override
//   void initState() {
//     super.initState();
//     // Initialize TabController in initState
//     _tabController = TabController(length: 3, vsync: this);
//   }
//
//   @override
//   void dispose() {
//     // Dispose the controller when the widget is removed
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final isDark = JDeviceUtils.isDarkMode(context);
//     final themeNotifier = Provider.of<ThemeNotifier>(context);
//
//     return Scaffold(
//       key: _scaffoldKey,
//       drawer: _buildNavigationDrawer(context, isDark),
//       backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
//       appBar: JAppbar(
//         leadingIcon: GestureDetector(
//           onTap: () => {_scaffoldKey.currentState?.openDrawer()},
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: CircularAvatar(
//               isDark: isDark,
//               radius: 20,
//               imageUrl: JImages.image,
//             ),
//           ),
//         ),
//         actions: [
//           // Language button
//
//           GestureDetector(
//               onTap: () => _showLanguageBottomSheet(context, isDark),
//               child: Icon(
//                 Icons.language,
//                 size: 24,
//               )),
//
//           SizedBox(width: 8,),
//           GestureDetector(
//             onTap: () => _showThemeBottomSheet(context, isDark),
//             child: Icon(
//               isDark ? Icons.light_mode : Icons.dark_mode,
//               color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray800,
//               size: 24,
//             ),
//           ),          // IconButton(
//           //   icon: Icon(
//           //     Icons.language,
//           //     color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray800,
//           //   ),
//           //   onPressed: () => _showLanguageBottomSheet(context, isDark),
//           // ),
//           // Theme button
//           // IconButton(
//           //   icon: Icon(
//           //     isDark ? Icons.light_mode : Icons.dark_mode,
//           //     color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray800,
//           //   ),
//           //   onPressed: () => _showThemeBottomSheet(context, isDark),
//           // ),
//           // More options button
//           IconButton(
//             icon: Icon(
//               Icons.more_vert,
//               color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray800,
//             ),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
//         child: Column(
//           children: [
//             SizedBox(
//               height: 35,
//               child: TabBar(
//                 dividerColor: Colors.transparent,
//                 controller: _tabController,
//                 // Set the controller
//                 // Add rounded indicator with no underline
//                 indicator: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: JAppColors.primary,
//                 ),
//                 indicatorSize: TabBarIndicatorSize.tab,
//                 labelColor: Colors.white,
//                 // Set selected tab text color to white
//                 unselectedLabelColor:
//                     isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
//                 padding: EdgeInsets.all(3),
//                 indicatorWeight: 0,
//                 // Set to 0 to remove the underline
//                 labelStyle: AppTextStyle.dmSans(
//                   fontSize: JSizes.fontSizeESm,
//                   weight: FontWeight.w500,
//                   color: Colors.white,
//                 ),
//                 unselectedLabelStyle: AppTextStyle.dmSans(
//                   fontSize: JSizes.fontSizeESm,
//                   weight: FontWeight.w500,
//                   color: Colors.white,
//                 ),
//                 tabs: [
//                   Tab(text: tr('bestMatch')),
//                   Tab(text: tr('recentMatch')),
//                   Tab(text: tr('savedMatch')),
//                 ],
//               ),
//             ),
//
//             // Add a TabBarView to display content for each tab
//             Expanded(
//               child: TabBarView(
//                 controller: _tabController, // Same controller for TabBarView
//                 children: [
//                   // Content for first tab
//                   BestMatchesPage(),
//                   RecentJobsPage(),
//                   SavedJobsPage(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
// // Usage example for the navigation drawer
//   Widget _buildNavigationDrawer(BuildContext context, bool isDark) {
//     return Drawer(
//       backgroundColor: isDark ? JAppColors.darkGray800 : Colors.white,
//       child: Column(
//         children: [
//           // Custom drawer header with profile in a row
//           Container(
//             padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 40),
//                 Row(
//                   children: [
//                     InkWell(
//                       onTap: () {
//                         // Close the drawer first
//
//                         Navigator.pop(context);
//                         // Navigate to profile screen
//                         AppRouter.router.push('/profileScreen');
//                       },
//                       child: CircularAvatar(
//                         isDark: isDark,
//                         radius: 30,
//                         imageUrl: JImages.image,
//                       ),
//                     ),
//                     SizedBox(width: 16),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'John Doe',
//                           style: AppTextStyle.dmSans(
//                             fontSize: JSizes.fontSizeMd,
//                             weight: FontWeight.w600,
//                             color: isDark
//                                 ? JAppColors.darkGray100
//                                 : JAppColors.lightGray800,
//                           ),
//                         ),
//                         SizedBox(height: 4),
//                         Text(
//                           '@johndoe',
//                           style: AppTextStyle.dmSans(
//                             fontSize: 14.0,
//                             weight: FontWeight.w400,
//                             color: isDark
//                                 ? JAppColors.darkGray100
//                                 : JAppColors.lightGray800,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 16),
//               ],
//             ),
//           ),
//
//           Divider(),
//           // Drawer items using the custom widget
//           DrawerItem(
//             iconPath: JImages.profilesetting,
//             title: 'accountSetting',
//             iconColor:
//                 isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
//             onTap: () {
//               Navigator.pop(context);
//
//               AppRouter.router.push('/accountSettingScreen');
//               // Navigate to home
//             },
//           ),
//
//           DrawerItem(
//             iconPath: JImages.report,
//             title: 'financialReport',
//             iconColor:
//                 isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
//             onTap: () {
//               Navigator.pop(context);
//               AppRouter.router.push('/financeReportScreen');
//
//               // Navigate to profile
//             },
//           ),
//
//           DrawerItem(
//             iconPath: JImages.proposal,
//             title: 'proposal',
//             iconColor:
//                 isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
//             onTap: () {
//               Navigator.pop(context);
//               AppRouter.router.push('/proposalScreen');
//               // Navigate to applications
//             },
//           ),
//           DrawerItem(
//             iconPath: JImages.proposal,
//             title: 'myAds',
//             iconColor:
//                 isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
//             onTap: () {
//               Navigator.pop(context);
//               AppRouter.router.push('/myAdsScreen');
//               // Navigate to applications
//             },
//           ),
//           DrawerItem(
//             iconPath: JImages.upgrade,
//             title: 'upgrade',
//             iconColor:
//                 isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
//             onTap: () {
//               Navigator.pop(context);
//               AppRouter.router.push('/membershipPlansScreen');
//               // Navigate to applications
//             },
//           ),
//           DrawerItem(
//             iconPath: JImages.language,
//             title: 'language',
//             iconColor:
//                 isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
//             onTap: () {
//               Navigator.pop(context);
//               AppRouter.router.push('/languageScreen');
//               // Navigate to applications
//             },
//           ),
//
//           DrawerItem(
//             iconPath: JImages.helpsupport,
//             title: 'helpAndSupport',
//             iconColor:
//                 isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
//             onTap: () {
//               Navigator.pop(context);
//               AppRouter.router.push('/contactSupportScreen');
//
//               // Navigate to notifications
//             },
//           ),
//
//           DrawerItem(
//             iconPath: JImages.logout_icon,
//             title: 'logout',
//             iconColor:
//                 isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
//             onTap: () {
//               Navigator.pop(context);
//               // Navigate to settings
//             },
//           ),
//
//
//         ],
//       ),
//     );
//   }
//   void _showThemeBottomSheet(BuildContext context, bool isDark) {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: isDark ? JAppColors.darkGray800 : Colors.white,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) {
//         return Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 'chooseTheme',
//                 style: AppTextStyle.dmSans(
//                   fontSize: 18.0,
//                   weight: FontWeight.bold,
//                   color:
//                   isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
//                 ),
//               ).tr(),
//               ListTile(
//                 leading: Icon(Icons.light_mode, color: Colors.orange),
//                 title: Text('lightTheme').tr(),
//                 onTap: () {
//                   Provider.of<ThemeNotifier>(context, listen: false)
//                       .toggleTheme(false);
//                   Navigator.pop(context);
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.dark_mode, color: Colors.blueGrey),
//                 title: Text('darkTheme').tr(),
//                 onTap: () {
//                   Provider.of<ThemeNotifier>(context, listen: false)
//                       .toggleTheme(true);
//                   Navigator.pop(context);
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.brightness_auto, color: Colors.green),
//                 title: Text('systemDefault').tr(),
//                 onTap: () {
//                   // Pass null to indicate system theme
//                   Provider.of<ThemeNotifier>(context, listen: false)
//                       .toggleTheme(null);
//                   Navigator.pop(context);
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//
//   void _showLanguageBottomSheet(BuildContext context, bool isDark) {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: isDark ? JAppColors.darkGray800 : Colors.white,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) {
//         return Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 'chooseLanguage',
//                 style: AppTextStyle.dmSans(
//                   fontSize: 18.0,
//                   weight: FontWeight.bold,
//                   color:
//                       isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
//                 ),
//               ).tr(),
//               ListTile(
//                 leading: Text('🇺🇸', style: TextStyle(fontSize: 24)),
//                 title: Text('english').tr(),
//                 onTap: () async {
//                   await context.setLocale(const Locale('en', 'US'));
//                   Navigator.pop(context);
//                   setState(() {});
//                 },
//               ),
//               ListTile(
//                 leading: Text('🇪🇸', style: TextStyle(fontSize: 24)),
//                 title: Text('spanish').tr(),
//                 onTap: () async {
//                   await context.setLocale(const Locale('es', 'ES'));
//                   Navigator.pop(context);
//                   setState(() {});
//                 },
//               ),
//               // Add more languages as needed
//             ],
//           ),
//         );
//       },
//     );
//   }
// }


import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/features/users/home/best_match_screen/best_match_screen.dart';
import 'package:job_contracts/presentation/features/users/home/recent_jobs/recent_jobs_screen.dart';
import 'package:job_contracts/presentation/features/users/home/saved_jobs/saved_jobs_screen.dart';
import 'package:job_contracts/utils/common_widgets/appbar.dart';
import 'package:job_contracts/utils/common_widgets/circular_avatar.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/constants/image_string.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import 'package:job_contracts/utils/device/device_utility.dart';
import 'package:provider/provider.dart';
import '../../../../utils/constants/app_text_style.dart';
import '../../theme_controller/ThemeNotifier.dart';
import 'bottom_sheet/app_bottom_sheets.dart';
import 'drawer/custom_navigation_drawer.dart';  // Import the new drawer

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // Initialize TabController in initState
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // Dispose the controller when the widget is removed
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomNavigationDrawer(isDark: isDark),  // Use the new drawer widget
      backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
      appBar: JAppbar(
        leadingIcon: GestureDetector(
          onTap: () => {_scaffoldKey.currentState?.openDrawer()},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularAvatar(
              isDark: isDark,
              radius: 20,
              imageUrl: JImages.image,
            ),
          ),
        ),
        actions: [
          // Language button
          GestureDetector(
              onTap: () => AppBottomSheets.showLanguageBottomSheet(context, isDark),  // Use the new method
              child: Icon(
                Icons.language,
                size: 24,
              )
          ),

          SizedBox(width: 8),
          GestureDetector(
            onTap: () => AppBottomSheets.showThemeBottomSheet(context, isDark),  // Use the new method
            child: Icon(
              isDark ? Icons.light_mode : Icons.dark_mode,
              color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray800,
              size: 24,
            ),
          ),
          // More options button
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray800,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
        child: Column(
          children: [
            SizedBox(
              height: 35,
              child: TabBar(
                dividerColor: Colors.transparent,
                controller: _tabController,
                // Set the controller
                // Add rounded indicator with no underline
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: JAppColors.primary,
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.white,
                // Set selected tab text color to white
                unselectedLabelColor:
                isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                padding: EdgeInsets.all(3),
                indicatorWeight: 0,
                // Set to 0 to remove the underline
                labelStyle: AppTextStyle.dmSans(
                  fontSize: JSizes.fontSizeESm,
                  weight: FontWeight.w500,
                  color: Colors.white,
                ),
                unselectedLabelStyle: AppTextStyle.dmSans(
                  fontSize: JSizes.fontSizeESm,
                  weight: FontWeight.w500,
                  color: Colors.white,
                ),
                tabs: [
                  Tab(text: tr('bestMatch')),
                  Tab(text: tr('recentMatch')),
                  Tab(text: tr('savedMatch')),
                ],
              ),
            ),

            // Add a TabBarView to display content for each tab
            Expanded(
              child: TabBarView(
                controller: _tabController, // Same controller for TabBarView
                children: [
                  // Content for first tab
                  BestMatchesPage(),
                  RecentJobsPage(),
                  SavedJobsPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}