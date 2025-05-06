

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
import '../../../../theme_controller/ThemeNotifier.dart';
import '../../../../utils/constants/app_text_style.dart';
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